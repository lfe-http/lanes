# lanes

[![Build Status][gh-actions-badge]][gh-actions]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][versions]
[![Tags][github tags badge]][github tags]

[![][logo]][logo-large]

*A slightly more general LFE HTTP routing library than lfest*

## Introduction

The lanes project aims to offer some of the YAWS-specific features of the [lfest project](https://github.com/lfex/lfest) to a wider selection of BEAM-based web servers. This is done with the understanding that the original design of lfest (and thus the design inherited in the lanes project) is not optimal.

For now, though, we are focused on the immediate and practical needs of LFE application developers.

## Dependencies

* Erlang 20+
* `rebar3`

## Compatibility

Releases of Elli map to the following versions in its dependencies:

* `0.3.0` - LFE 2.1.1, Erlang 20-26, Rebar 3.22, rebar2_lfe 0.4.2 (with examples using logjam 1.0.5, Elli 3.3.0, Barista 0.3.2)
* `0.2.0` - LFE 2.0.1, Erlang 20-25, Rebar 3.16, rebar3_lfe 0.3.1 (with examples using logjam 1.0.0, Elli 3.3.0, Barista 0.3.2)

## Usage

Create your application/service routes with the `(defroutes ...)` form.
Here is an example that is compatible with [Elli](https://github.com/elli-lib/elli):

```cl
(include-lib "lanes_elli/include/macros.lfe")

(defroutes
  ;; top-level
  ('GET #"/"
        (lanes.elli:ok "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST #"/order"
         (progn
           (lanes-elli-data:create-order (lanes.elli:get-data req))
           (lanes.elli:accepted)))
  ('GET #"/order/:id"
        (lanes.elli:ok
         (lanes-elli-data:get-order id)))
  ('PUT #"/order/:id"
        (progn
          (lanes-elli-data:update-order id (lanes.elli:get-data req))
          (lanes.elli:no-content)))
  ('DELETE #"/order/:id"
           (progn
             (lanes-elli-data:delete-order id)
             (lanes.elli:no-content)))
  ;; order collection operations
  ('GET #"/orders"
        (lanes.elli:ok
         (lanes-elli-data:get-orders)))
  ;; payment operations
  ('PUT #"/payment/order/:id"
        (progn
          (lanes-elli-data:make-payment id (lanes.elli:get-data req))
          (lanes.elli:no-content)))
  ('GET #"/payment/order/:id"
        (lanes.elli:ok
         (lanes-elli-data:get-payment-status id)))
  ;; error conditions
  ('ALLOWONLY ('GET 'POST 'PUT 'DELETE)
              (lanes.elli:method-not-allowed))
  ('NOTFOUND
   (lanes.elli:not-found "Bad path: invalid operation.")))
```

For full context, be sure to see the code in `./examples`.

### Consuming Routes

The following frameworks/HTTP servers are targetted by lanes, with the goal that each will be able to consume the routes defined by lanes:

* [Elli](./docs/src/elli.md)
* [Barista](./docs/src/barista.md)
* [Erlang (inets)](./docs/src/inets.md) (partial)
* [YAWS](./docs/src/yaws.md) (partial)
* [Nova](./docs/src/nova.md) (not started)
* [Cowboy](./docs/src/cowboy.md) (not started)

## License [&#x219F;](#contents)

Apache Version 2 License

Copyright © 2014-2023, Duncan McGreggor <oubiwann@gmail.com>

[//]: ---Named-Links---

[logo]: priv/images/logo.jpg
[logo-large]: priv/images/logo-large.jpg
[gh-actions-badge]: https://github.com/lfex/lanes/workflows/ci%2Fcd/badge.svg
[gh-actions]: https://github.com/lfex/lanes/actions
[lfe]: https://github.com/lfe/lfe
[lfe badge]: https://img.shields.io/badge/lfe-2.0-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-201%20to%2025-blue.svg
[versions]: https://github.com/lfex/lanes/blob/master/.github/workflows/cicd.yml
[github tags]: https://github.com/lfex/lanes/tags
[github tags badge]: https://img.shields.io/github/tag/lfex/lanes.svg
