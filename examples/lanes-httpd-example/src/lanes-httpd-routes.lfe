(defmodule lanes-httpd-routes
  (export
   (do 1)
   (handle 3)))

;;(include-lib "lanes_httpd/include/macros.lfe")
(include-lib "logjam/include/logjam.hrl")

(defun do (req)
    (log-debug "httpd request: ~p" (list req))
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
        (response 200 "Welcome to the Volvo Store!"))
  ;; single order operations
  ('POST #"/order"
         (progn
           (lanes-httpd-data:create-order (get-data req))
           (response 202)))
  ('GET #"/order/:id"
        (response
         200
         (lanes-httpd-data:get-order id)))
  ('PUT #"/order/:id"
        (progn
          (lanes-httpd-data:update-order id (get-data req))
          (response 204)))
  ('DELETE #"/order/:id"
           (progn
             (lanes-httpd-data:delete-order id)
             (response 204)))
  ;; order collection operations
  ('GET #"/orders"
        (response
         200
         (lanes-httpd-data:get-orders)))
  ;; payment operations
  ('PUT #"/payment/order/:id"
        (progn
          (lanes-httpd-data:make-payment id (get-data req))
          (response 204)))
  ('GET #"/payment/order/:id"
        (response
         "200"
         (lanes-httpd-data:get-payment-status id)))
  ;; error conditions
  ('ALLOWONLY ('GET 'POST 'PUT 'DELETE)
              (response "405" "Method Not Allowed"))
  ('NOTFOUND
   (progn
     (log-debug "inets httpd request: ~p" (list req))
     (response 404 "Bad path: invalid operation."))))

(defun munge-request (req)
  'tbd)

(defun get-data (req)
  'tbd)

(defun response (status)
  (response status ""))

(defun response (status body)
  (response status headers body)

(defun response (status headers body)
  `#(proceed
     (#(response
        #(,status ,(string:join (++ headers (list body)) "\r\n"))))))
