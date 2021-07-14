(defmodule lanes-elli-macro-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest get
  (is-equal "/a - gotten"
            (lanes-elli-test-routes:handle
             'GET '(#"a") '())))

(deftest post
  (is-equal #(202 () #"Accepted")
            (lanes-elli-test-routes:handle
             'POST '(#"a" #"b") '())))

(deftest put
  (is-equal "/a/b/42 - updated"
            (lanes-elli-test-routes:handle
             'PUT '(#"a" #"b" 42) '())))

(deftest not-found
  (is-equal #(404 ()#"Not Found")
            (lanes-elli-test-routes:handle
             'GET '(#"no" #"such" #"path") '())))

(deftest method-not-allowed()
  (is-equal #(405 () #"Method Not Allowed")
            (lanes-elli-test-routes:handle
             'HEAD '() '())))
