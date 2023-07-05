(defmodule lanes-httpd-example-tests
  (behaviour ltest-integration))

(include-lib "ltest/include/ltest-macros.lfe")

(defun set-up ()
  (let ((`#(ok ,pid) (lanes-httpd-app:start)))
    (logger:unset_module_level 'supervisor)
    (logger:unset_module_level 'application_controller)
    (logger:set_primary_config #m(level error))
    pid))

(defun tear-down (pid)
  (lanes-httpd-app:stop pid))

(deftestcase start-up (pid)
  (is (is_pid pid)))

(deftestcase root (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5097/")))
    (is-equal 200
              (lanes.httpc:status resp))
    (is-equal "Welcome to the Volvo Store!"
              (lanes.httpc:body resp))))

(deftestcase create-order (_)
  (let ((`#(ok ,resp) (httpc:request 'post
                                     #("http://localhost:5097/order" () "" "")
                                     '()
                                     '())))
    (is-equal 202
              (lanes.httpc:status resp))
    (is-equal "Accepted"
              (lanes.httpc:body resp))))


(deftestcase get-order (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5097/order/42")))
    (is-equal 200
              (lanes.httpc:status resp))
    (is-equal "ORDER DATA FOR ID 42"
              (lanes.httpc:body resp))))

(deftestcase update-order (_)
  (let ((`#(ok ,resp) (httpc:request 'put
                                     #("http://localhost:5097/order/42" () "" "")
                                     '()
                                     '())))
    (is-equal 204
              (lanes.httpc:status resp))))

(deftestcase get-orders (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5097/orders")))
    (is-equal 200
              (lanes.httpc:status resp))
    (is-equal "ALL ORDERS DATA"
              (lanes.httpc:body resp))))

(deftestcase update-payment (_)
  (let ((`#(ok ,resp) (httpc:request 'put
                                     #("http://localhost:5097/payment/order/42" () "" "")
                                     '()
                                     '())))
    (is-equal 204
              (lanes.httpc:status resp))))

(deftestcase get-payment-status (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5097/payment/order/42")))
    (is-equal 200
              (lanes.httpc:status resp))
    (is-equal "PAID"
              (lanes.httpc:body resp))))

(deftestcase not-allowed (_)
  (let ((`#(ok ,resp) (httpc:request 'head
                                     #("http://localhost:5097/" ()) '() '())))
    (is-equal 405
              (lanes.httpc:status resp))))

(deftestcase not-found (_)
  (let ((`#(ok ,resp) (httpc:request "http://localhost:5097/no/such/path")))
    (is-equal 404
              (lanes.httpc:status resp))))

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
