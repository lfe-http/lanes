# Barista

[Barista](https://github.com/lfex/barista) is a thin wrapper around the
Erlang standard library's httpd, written in LFE. The `lanes-barista`
module supports a `defroutes` macro that generates a `handle/3` function
and allows barista web applications to dispatch based upon request method and path.
