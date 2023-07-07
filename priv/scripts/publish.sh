#!/bin/bash

# Publish lanes itself
echo ">> Publishing lanes to hex.pm ..."
rm -f rebar.lock
rebar3 do clean,compile,hex publish

# Note: YAWS is not setup for publishing yet

# The ordering is important for elli and barista: the elli module must be
# published first due to the fact that the barista module currently depends
# upon it.
for MOD in ./modules/lanes-{elli,barista}; do
    echo ">> Publishing $MOD to hex.pm ..."
    cd $MOD
    rm -f rebar.lock
    rebar3 do clean,compile,hex publish
    cd -
done
