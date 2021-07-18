(defmodule lanes-elli-routes-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest get-root
  (let ((`#(,status ,_ ,body) (lanes-elli-routes:handle 'GET '() '())))
    (is-equal "Welcome to the Volvo Store!"
              body)))

(deftest get-order
  (let ((`#(,status ,_ ,body) (lanes-elli-routes:handle 'GET '(#"order" #"42") '())))
    (is-equal '(#"ORDER DATA FOR ID " #"42")
              body)))

(deftest get-payment-status
  (let ((`#(,status ,_ ,body) (lanes-elli-routes:handle 'GET '(#"payment" #"order" #"42") '())))
    (is-equal #"PAID"
              body)))

(deftest get-no-such-path
  (let ((`#(,status ,_ ,body) (lanes-elli-routes:handle 'GET '(#"no" #"such" #"path") '())))
    (is-equal "Bad path: invalid operation."
              body)))
