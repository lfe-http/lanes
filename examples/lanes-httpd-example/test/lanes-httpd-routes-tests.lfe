(defmodule lanes-httpd-routes-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest get-root
  (let ((`#(proceed (#(response #(,status ,body)))) (lanes-httpd-routes:handle 'GET '() '())))
    (is-equal 200 status)
    (is-equal "Welcome to the Volvo Store!"
              body)))

(deftest get-order
  (let ((`#(proceed (#(response #(,status ,body)))) (lanes-httpd-routes:handle 'GET '(#"order" #"42") '())))
    (is-equal 200 status)
    (is-equal "ORDER DATA FOR ID 42"
              body)))

(deftest get-payment-status
  (let ((`#(proceed (#(response #(,status ,body)))) (lanes-httpd-routes:handle 'GET '(#"payment" #"order" #"42") '())))
    (is-equal 200 status)
    (is-equal "PAID"
              body)))

(deftest get-404
  (let ((`#(proceed (#(response #(,status ,body)))) (lanes-httpd-routes:handle 'GET '(#"no" #"such" #"path") '())))
    (is-equal 404 status)
    (is-equal "Bad path: invalid operation."
              body)))

(deftest get-405
  (let ((`#(proceed (#(response #(,status ,body)))) (lanes-httpd-routes:handle 'PATCH '(#"order" #"42") '())))
    (is-equal 405 status)
    (is-equal "Method Not Allowed"
              body)))
