(defmodule lanes-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "lanes/include/elli.lfe")

(deftest handle-path-segment
  (is-equal "a"
            (lanes.util:handle-path-segment "a"))
  (is-equal 'id
            (lanes.util:handle-path-segment ":id"))
  (is-equal 'id-with-dashes
            (lanes.util:handle-path-segment ":id-with-dashes"))
  (is-equal #"a"
            (lanes.util:handle-path-segment #"a"))
  (is-equal 'id
            (lanes.util:handle-path-segment #":id")))
