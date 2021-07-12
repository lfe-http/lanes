(defmodule lanes-elli-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "lanes/include/elli.lfe")

(deftest parse-path
  (is-equal '(#"a" #"b" #"c")
            (lanes.elli.util:parse-path '(#"a" #"b" #"c")))
  (is-equal '(#"user" #"update" id)
            (lanes.elli.util:parse-path '(#"user" #"update" #":id"))))

(deftest make-handler-pattern
  (is-equal '(GET (#"a" #"b" #"c") req)
            (lanes.elli.util:make-handler-pattern
             'GET '(#"a" #"b" #"c")))
  (is-equal '(GET (#"user" #"update" id) req)
            (lanes.elli.util:make-handler-pattern
             'GET '(#"user" #"update" #":id"))))
