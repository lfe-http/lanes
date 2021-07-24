(defmodule lanes-barista-macro-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest get
  (is-equal #(proceed (#(response #(200 "/a - gotten"))))
            (lanes-barista-test-routes:handle
             'GET '(#"a") '())))

(deftest post
  (is-equal #(proceed (#(response #(202 "Accepted"))))
            (lanes-barista-test-routes:handle
             'POST '(#"a" #"b") '())))

(deftest put
  (is-equal #(proceed (#(response #(202 "/a/b/42 - updated"))))
            (lanes-barista-test-routes:handle
             'PUT '(#"a" #"b" 42) '())))

(deftest not-found
  (is-equal #(proceed (#(response #(404 "Not Found"))))
            (lanes-barista-test-routes:handle
             'GET '(#"no" #"such" #"path") '())))

(deftest method-not-allowed()
  (is-equal #(proceed (#(response #(405 "Method Not Allowed"))))
            (lanes-barista-test-routes:handle
             'HEAD '() '())))
