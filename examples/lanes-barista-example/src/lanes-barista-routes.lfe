(defmodule lanes-barista-routes
  (export
   (do 1)
   (handle 3)))

(include-lib "lanes_barista/include/macros.lfe")
(include-lib "logjam/include/logjam.hrl")

(defun do (httpd-req)
  (let ((req (barista-request:->map httpd-req)))
    (log-debug "barista request: ~p" (list req))
    (log-debug "raw method: ~p" (list (mref req 'method)))
    (log-debug "method: ~p" (list (list_to_atom (mref req 'method))))
    (log-debug "path: ~p" (list (mref req 'path)))
    (handle (list_to_atom (mref req 'method))
            (mref req 'path)
            req)))

(defroutes
  ;; This macro generates the handle/3 function used by do/1.
  ;;
  ;; top-level
  ('GET #"/"
        (barista-response:ok "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST #"/order"
         (progn
           (lanes-barista-data:create-order (barista-request:get-data req))
           (barista-response:accepted)))
  ('GET #"/order/:id"
        (barista-response:ok
         (lanes-barista-data:get-order id)))
  ('PUT #"/order/:id"
        (progn
          (lanes-barista-data:update-order id (barista-request:get-data req))
          (barista-response:no-content)))
  ('DELETE #"/order/:id"
           (progn
             (lanes-barista-data:delete-order id)
             (barista-response:no-content)))
  ;; order collection operations
  ('GET #"/orders"
        (barista-response:ok
         (lanes-barista-data:get-orders)))
  ;; payment operations
  ('PUT #"/payment/order/:id"
        (progn
          (lanes-barista-data:make-payment id (barista-request:get-data req))
          (barista-response:no-content)))
  ('GET #"/payment/order/:id"
        (barista-response:ok
         (lanes-barista-data:get-payment-status id)))
  ;; error conditions
  ('ALLOWONLY ('GET 'POST 'PUT 'DELETE)
              (barista-response:method-not-allowed))
  ('NOTFOUND
   (progn
     (log-debug "barista request: ~p" (list req))
     (barista-response:not-found "Bad path: invalid operation."))))


;(defroutes ('GET #"/" (barista-response:ok "Welcome to the Volvo Store!")))