# Elli

Wriing Elli applications in LFE with lanes is very similar as in Erlang:
the only difference is that you don't create a `handle/3` function. Instead,
you use `defroutes` which creates `handle/3` under the covers for you.
Everything else is vanilla Elli. To be clear, one still needs to provide the
`handle/2` and `handle_event/3` functions in the module where `defroutes` is
called.

## Example

See the [lanes Elli example](../../examples/lanes-elli-example).
