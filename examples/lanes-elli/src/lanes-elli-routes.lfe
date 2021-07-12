(defmodule lanes-elli-routes
  (behaviour elli_handler)
  (export
   (handle 2)
   (handle_event 3)))

(include-lib "logjam/include/logjam.hrl")
(include-lib "lanes/include/elli.lfe")

(defroutes
  ;; This macro generates the handle/3 function used by handle/2.
  ;;
  ;; top-level
  ('GET "/"
    (lanes.elli.response:ok "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST "/order"
    (lanes-elli-data:create-order (lanes.elli:get-data req)))
  ('GET "/order/:id"
    (lanes-elli-data:get-order id))
  ('PUT "/order/:id"
    (lanes-elli-data:update-order id (lanes.elli:get-data req)))
  ('DELETE "/order/:id"
    (lanes-elli-data:delete-order id))
  ;; order collection operations
  ('GET "/orders"
    (lanes-elli-data:get-orders))
  ;; payment operations
  ('GET "/payment/order/:id"
    (lanes-elli-data:get-payment-status id))
  ('PUT "/payment/order/:id"
    (lanes-elli-data:make-payment id (lanes.elli:get-data req)))
  ;; error conditions
  ('ALLOWONLY
    ('GET 'POST 'PUT 'DELETE)
    (lanes.elli.response:method-not-allowed))
  ('NOTFOUND
   (lanes.elli.response:not-found "Bad path: invalid operation.")))

;;(defun handle
;;  (('GET '(#"hello" #"world") _req)
;;   #(200 () #"Hello, world!"))
;;  (('GET `(#"hello" ,name) _req)
;;   `#(200 () (#"Hello, " ,name #".")))
;;  ((_ _ _req)
;;   #(404 () #"Not Found")))

(defun handle (req _args)
  (handle (elli_request:method req)
          (elli_request:path req)
          req))

(defun handle_event (event data args)
  (log-info "Got event: ~p" `(,event))
  (log-debug "Got data: ~p" `(,data))
  (log-debug "Got args: ~p" `(,args))
  'ok)
