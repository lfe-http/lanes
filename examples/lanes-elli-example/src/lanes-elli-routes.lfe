(defmodule lanes-elli-routes
  (behaviour elli_handler)
  (export
   (handle 2)
   (handle 3)
   (handle_event 3)))

(include-lib "logjam/include/logjam.hrl")
(include-lib "lanes_elli/include/macros.lfe")

(defroutes
  ;; This macro generates the handle/3 function used by handle/2.
  ;;
  ;; top-level
  ('GET #"/"
        (lanes.elli:ok "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST #"/order"
         (progn
           (lanes-elli-data:create-order (lanes.elli:get-data req))
           (lanes.elli:accepted)))
  ('GET #"/order/:id"
        (lanes.elli:ok
         (lanes-elli-data:get-order id)))
  ('PUT #"/order/:id"
        (progn
          (lanes-elli-data:update-order id (lanes.elli:get-data req))
          (lanes.elli:no-content)))
  ('DELETE #"/order/:id"
           (progn
             (lanes-elli-data:delete-order id)
             (lanes.elli:no-content)))
  ;; order collection operations
  ('GET #"/orders"
        (lanes.elli:ok
         (lanes-elli-data:get-orders)))
  ;; payment operations
  ('PUT #"/payment/order/:id"
        (progn
          (lanes-elli-data:make-payment id (lanes.elli:get-data req))
          (lanes.elli:no-content)))
  ('GET #"/payment/order/:id"
        (lanes.elli:ok
         (lanes-elli-data:get-payment-status id)))
  ;; error conditions
  ('ALLOWONLY ('GET 'POST 'PUT 'DELETE)
              (lanes.elli:method-not-allowed))
  ('NOTFOUND
   (lanes.elli:not-found "Bad path: invalid operation.")))

(defun handle (req _args)
  (handle (elli_request:method req)
          (elli_request:path req)
          req))

(defun handle_event (event data args)
  (log-info "Got event: ~p" `(,event))
  (log-debug "Got data: ~p" `(,data))
  (log-debug "Got args: ~p" `(,args))
  'ok)
