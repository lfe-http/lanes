# lanes-esi-example

[![Build Status][gh-actions-badge]][gh-actions]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][versions]
[![Tags][github tags badge]][github tags]

[![Project Logo][logo]][logo-large]

*An example application for lanes running on inets httpd*

##### Table of Contents

* [About](#about-)
* [Build](#build-)
* [Start the App](#start-the-app-)
* [Tests](#tests-)
* [Usage](#usage-)
* [License](#license-)

## About [&#x219F;](#table-of-contents)

TBD

## Build [&#x219F;](#table-of-contents)

```shell
$ rebar3 compile
```

## Start the App [&#x219F;](#table-of-contents)

```shell
$ rebar3 lfe repl
```

``` cl
lfe> (lanes-httpd-example:start)
```

# Tests [&#x219F;](#table-of-contents)

```shell
$ rebar3 as test lfe test
```

## Usage [&#x219F;](#table-of-contents)

TBD

## License [&#x219F;](#table-of-contents)

Apache License, Version 2.0

Copyright © 2021, Duncan McGreggor <oubiwann@gmail.com>.

<!-- Named page links below: /-->

[logo]: https://avatars1.githubusercontent.com/u/3434967?s=250
[logo-large]: https://avatars1.githubusercontent.com/u/3434967
[github]: https://github.com/ORG/lanes-esi-example
[gitlab]: https://gitlab.com/ORG/lanes-esi-example
[gh-actions-badge]: https://github.com/lfex/lanes/workflows/ci%2Fcd/badge.svg
[gh-actions]: https://github.com/lfex/lanes/actions
[lfe]: https://github.com/lfe/lfe
[lfe badge]: https://img.shields.io/badge/lfe-2.0-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-19%20to%2024-blue.svg
[version]: https://github.com/ORG/lanes-esi-example/blob/master/.github/workflows/cicd.yml
[github tags]: https://github.com/ORG/lanes-esi-example/tags
[github tags badge]: https://img.shields.io/github/tag/ORG/lanes-esi-example.svg
[github downloads]: https://img.shields.io/github/downloads/ORG/lanes-esi-example/total.svg
