(defmodule lanes-common-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest make-handler-pattern
  (is-equal '(GET (list #"a" #"b" #"c") req)
            (lanes.common:make-handler-pattern
             'GET "a/b/c"))
  (is-equal '(GET (list #"a" #"b" #"c") req)
            (lanes.common:make-handler-pattern
             'GET #"a/b/c"))
  (is-equal '(GET (list #"user" #"update" id) req)
            (lanes.common:make-handler-pattern
             'GET #"/user/update/:id")))
