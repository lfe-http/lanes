(defmodule lanes-elli-macro-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "lanes/include/elli.lfe")

(deftest placeholder
  (is-equal 1 1))
