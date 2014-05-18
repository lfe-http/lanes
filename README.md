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
$ make get-deps
```

Or, you can have it download automatically when you compile:

```bash
$ make compile
```


Usage
=====

Create your application/service routes with the ``(defroutes ...)`` form.
Here is an example:

```cl
(include-lib "deps/lfest/include/macros.lfe")

(defroutes
  ;; top-level
  ('GET "/"
        (lfest-html-resp:ok "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST "/order"
         (create-order (lfest:get-data arg-data)))
  ('GET "/order/:id"
        (get-order id))
  ('PUT "/order/:id"
        (update-order id (lfest:get-data arg-data)))
  ('DELETE "/order/:id"
           (delete-order id))
  ;; order collection operations
  ('GET "/orders"
        (get-orders))
  ;; payment operations
  ('GET "/payment/order/:id"
        (get-payment-status id))
  ('PUT "/payment/order/:id"
        (make-payment id (lfest:get-data arg-data)))
  ;; error conditions
  ('ALLOWONLY
    ('GET 'POST 'PUT 'DELETE)
    (lfest-json-resp:method-not-allowed))
  ('NOTFOUND
    (lfest-json-resp:not-found "Bad path: invalid operation.")))
```

Note that this creates the ``#'routes/3`` function which can then be called
in the ``out/1`` function.

A few important things to note here:

* Each route is composed of an HTTP verb, a path, and a function to execute
  should both the verb and path match.
* The function call in the route has access to the ``arg-data`` passed from
  YAWS; this contains all the data you could conceivably need to process a
  request. (You may need to import the ``yaws_api.hrl`` in your module to
  parse the data of your choice, though.)
* If a path has a segment preceded by a colon, this will be converted to a
  variable by the ``(defroutes ...)`` macro; the variable will then be
  accessible from the route function.


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
