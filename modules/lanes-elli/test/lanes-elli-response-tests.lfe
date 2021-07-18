(defmodule lanes-elli-response-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(defun test-response ()
  #(#("HTTP/1.1" 404 "Not Found")
    (#("date" "Sun, 18 Jul 2021 21:04:25 GMT")
     #("content-length" "18")
     #("content-type" "text/plain"))
    "404 page not found"))

(deftest body
  (is-equal "404 page not found"
            (lanes.elli.response:body (test-response))))

(deftest headers
  (is-equal '(#("date" "Sun, 18 Jul 2021 21:04:25 GMT")
              #("content-length" "18")
              #("content-type" "text/plain"))
            (lanes.elli.response:headers (test-response))))

(deftest status
  (is-equal 404
            (lanes.elli.response:status (test-response))))
