# elli on LFE

[![Build Status][gh-actions-badge]][gh-actions]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][versions]
[![Tags][github tags badge]][github tags]

[![Project Logo][logo]][logo-large]

*An LFE port of the Elli "Hello World" web application*

##### Table of Contents

* [About](#about-)
* [Build](#build-)
* [Start the App](#start-the-app-)
* [Tests](#tests-)
* [License](#license-)

## About [&#x219F;](#table-of-contents)

This is an LFE port of the Erlang [elli Hello World](https://github.com/elli-lib/elli-examples/tree/master/hello_world) app.

## Build [&#x219F;](#table-of-contents)

```shell
$ rebar3 compile
```

# Start the App [&#x219F;](#table-of-contents)

```shell
$ rebar3 lfe repl
```

``` cl
lfe> (application:ensure_all_started 'lanes-elli-example)

```

At which point you should see logged output such as the following:

```
2021-07-18 16:47:32 NOTICE <0.543.0> [lanes-elli-app:start/2:14] ▸ text="Starting LFE elli example application ..."
2021-07-18 16:47:32 INFO <0.547.0> [lanes-elli-routes:handle_event/3:58] ▸ text="Got event: elli_startup"
2021-07-18 16:47:32 DEBUG <0.547.0> [lanes-elli-routes:handle_event/3:58] ▸ text="Got data: []"
2021-07-18 16:47:32 DEBUG <0.547.0> [lanes-elli-routes:handle_event/3:58] ▸ text="Got args: undefined"
```

# HTTP Resources [&#x219F;](#table-of-contents)

Then, in another terminal window, you can do the usual:

``` shell
$ curl http://localhost:5099/
Welcome to the Volvo Store!
$ curl -XPOST http://localhost:5099/order
Accepted
$ curl http://localhost:5099/order/42
ORDER DATA FOR ID 42
$ curl --silent -XPUT -I http://localhost:5099/order/42 | head -1
HTTP/1.1 204 No Content
$ curl --silent -XDELETE -I http://localhost:5099/order/42 | head -1
HTTP/1.1 204 No Content
$ curl http://localhost:5099/orders
ALL ORDERS DATA
$ curl --silent -XPUT -I http://localhost:5099/payment/order/42 | head -1
HTTP/1.1 204 No Content
$ curl http://localhost:5099/payment/order/42
PAID
$ curl -XPATCH http://localhost:5099/orders
Method Not Allowed
$ curl http://localhost:5099/no/such/path
Bad path: invalid operation.oubiwann
```

The terminal where you ran the LFE REPL should now have log messages for the associated events.

# Tests [&#x219F;](#table-of-contents)

```shell
$ rebar3 as test lfe test
```

## License [&#x219F;](#table-of-contents)

Apache License, Version 2.0

Copyright © 2021, Duncan McGreggor <oubiwann@gmail.com>.

<!-- Named page links below: /-->

[logo]: https://avatars1.githubusercontent.com/u/3434967?s=250
[logo-large]: https://avatars1.githubusercontent.com/u/3434967
[github]: https://github.com/lfe/examples/tree/master/elli
[gh-actions-badge]: https://github.com/lfe/examples/workflows/cicd/badge.svg
[gh-actions]: https://github.com/lfe/examples/actions
[lfe]: https://github.com/lfe/lfe
[lfe badge]: https://img.shields.io/badge/lfe-2.0-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-21%20to%2024-blue.svg
[versions]: https://github.com/lfe/examples/blob/master/.github/workflows/cicd.yml
[github tags]: https://github.com/lfe/examples/tags
[github tags badge]: https://img.shields.io/github/tag/lfe/examples.svg
[github downloads]: https://img.shields.io/github/downloads/lfe/examples/total.svg
