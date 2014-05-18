# lfest [![Build Status](https://travis-ci.org/lfe/lfest.png?branch=master)](https://travis-ci.org/lfe/lfest)

<img src="resources/images/Banners-And-Confetti.png"/>

*Macros and functions for LFE+REST on YAWS*


Introduction
============

REST is a party, and you know it.


Dependencies
------------

This project assumes that you have [rebar](https://github.com/rebar/rebar)
and [lfetool]() installed somwhere in your ``$PATH``.

This project depends upon the following, which are automatically installed
to the ``deps`` directory of this project when you run ``make compile``:

* [LFE](https://github.com/rvirding/lfe) - Lisp Flavored Erlang; needed to
  compile
* [YAWS]() - needed for the header file


Installation
============

Just add it to your ``rebar.config`` deps:

```erlang

{deps, [
    ...
    {lfest, ".*", {git, "git@github.com:lfe/lfest.git", "master"}}
  ]}.
```

If you have created your project with ``lfetool``, you can download
``lfeest`` with the following:

```bash
$ rebar get-deps
```

Or, you can have it download automatically when you compeile:

```bash
$ rebar compile
```


Usage
=====

Create your application/service routes with the ``(defroutes ...)`` form.
Here is an example:

```cl
(defroutes
  ;; top-level
  ('GET "/"
        (lfest-html-resp:ok "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST "/order"
         (create-order (lfest:get-data arg-data)))
  ;; XXX next up in hacking tasks: change 124 in the url to :id and then
  ;; do some crazy parsing in the macros
  ('GET "/order/124"
        (get-order 124))
  ('PUT "/order/124"
        (update-order 124 (lfest:get-data arg-data)))
  ('DELETE "/order/124"
           (delete-order 124))
  ;; order collection operations
  ('GET "/orders"
        (get-orders))
  ;; payment operations
  ('GET "/payment/order/124"
        (get-payment-status 124))
  ('PUT "/payment/order/124"
        (make-payment 124 (lfest:get-data arg-data)))
  ;; error conditions
  ('FORBIDDEN
    ('GET 'POST 'PUT 'DELETE)
    (lfest-json-resp:method-not-allowed))
  ('NOTFOUND
    (lfest-json-resp:not-found "Bad path: invalid operation.")))
```

Note that this creates the ``#'routes/3`` function which can then be called
in the ``out/1`` function.


Concepts
========

lfest needs to provide YAWS with an ``out/1`` function, and YAWS will
call this function with one argument: the YAWS ``arg`` record data. Since
this function is the entry point for applications running under YAWS, it is
responsible for determining how to process all requests.

The route definition macro does some pretty heavy remixing of the routes
defined in ``(defroutes ...)``. When it's done, a ``#'routes/3`` function
is availble for use from the macro where the routes are defined.

In order to make this work, you need to do the following:

1. Update your yaws.conf file with an ``<appmods ...>`` directive that
   associates a module with a path.
1. Define your routes using the ``defroutes`` macro from ``lfeet``.
1. Update your module with an ``out/1`` function which calls the macro-generated ``routes/3`` function.
