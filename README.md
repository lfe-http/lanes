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

Add content to me here!


Concepts
========

lfest needs to provide YAWS with an ``out/1`` function, and YAWS will
call this function with one argument: the YAWS ``arg`` record data. Since
this function is the entry point for applications running under YAWS, it is
responsible for determining how to process all requests.



Here's how lfest expects you to create your

In order to make this work, you need to do the following:

1. Update your yaws.conf file with an ``<appmods ...>`` directive that
   associates a module with a path.
1. Define your routes using the ``defroutes`` macro from ``lfeet``.
1. Update your module with an ``out/1`` function which calls the macro-generated ``routes/3`` function.
