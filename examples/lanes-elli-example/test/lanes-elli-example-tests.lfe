(defmodule lanes-elli-example-tests
  (behaviour ltest-integration))

(include-lib "ltest/include/ltest-macros.lfe")

(defun set-up ()
  (let ((start-result (application:ensure_all_started 'lanes-elli-example)))
    (inets:start)
    (logger:unset_module_level 'supervisor)
    (logger:unset_module_level 'application_controller)
    (logger:set_primary_config #m(level error))
    start-result))

(defun tear-down (setup-result)
  (let ((stop-result (application:stop 'lanes-elli-example)))
    (is-equal 'ok stop-result)))

(deftestcase start-up (setup-result)
  (is-equal '#(ok (sasl lanes-elli-example))
            setup-result))

(deftestcase root (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5099/")))
    (is-equal 200
              (lanes.elli.response:status resp))
    (is-equal "Welcome to the Volvo Store!"
              (lanes.elli.response:body resp))))

(deftestcase create-order (_)
  (let ((`#(ok ,resp) (httpc:request 'post
                                     #("http://localhost:5099/order" () "" "")
                                     '()
                                     '())))
    (is-equal 202
              (lanes.elli.response:status resp))
    (is-equal "Accepted"
              (lanes.elli.response:body resp))))


(deftestcase get-order (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5099/order/42")))
    (is-equal 200
              (lanes.elli.response:status resp))
    (is-equal "ORDER DATA FOR ID 42"
              (lanes.elli.response:body resp))))

(deftestcase update-order (_)
  (let ((`#(ok ,resp) (httpc:request 'put
                                     #("http://localhost:5099/order/42" () "" "")
                                     '()
                                     '())))
    (is-equal 204
              (lanes.elli.response:status resp))))

(deftestcase get-orders (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5099/orders")))
    (is-equal 200
              (lanes.elli.response:status resp))
    (is-equal "ALL ORDERS DATA"
              (lanes.elli.response:body resp))))

(deftestcase update-payment (_)
  (let ((`#(ok ,resp) (httpc:request 'put
                                     #("http://localhost:5099/payment/order/42" () "" "")
                                     '()
                                     '())))
    (is-equal 204
              (lanes.elli.response:status resp))))

(deftestcase get-payment-status (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5099/payment/order/42")))
    (is-equal 200
              (lanes.elli.response:status resp))
    (is-equal "PAID"
              (lanes.elli.response:body resp))))

(deftestcase not-allowed (_)
  (let ((`#(ok ,resp) (httpc:request 'head
                                     #("http://localhost:5099/" ()) '() '())))
    (is-equal 405
              (lanes.elli.response:status resp))))

(deftestcase not-found (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5099/no/such/path")))
    (is-equal 404
              (lanes.elli.response:status resp))))

(deftestgen suite
  (tuple 'foreach
         (defsetup set-up)
         (defteardown tear-down)
         (deftestcases
           start-up
           root
           create-order
           get-order
           update-order
           get-orders
           update-payment
           get-payment-status
           not-allowed
           not-found)))
