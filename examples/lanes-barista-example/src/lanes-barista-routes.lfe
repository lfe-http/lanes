(defmodule lanes-barista-routes
  (export
   (do 1)))

(include-lib "inets/include/httpd.hrl")
(include-lib "logjam/include/logjam.hrl")

(defun do (httpd-req)
  (let ((req (barista-request:->map httpd-req)))
    (log-debug "barista request: ~p" (list req))
    (handle (mref req 'method)
            (mref req 'path)
            req)))

(defun handle
  ((method path (= `#m(body ,body) req))
   "Example handler that displays whatever is passed through."
   (log-debug "method: ~p" (list method))
   (log-debug "path: ~p" (list path))
   (let* ((headers '("Content-Type: text/plain"
                     "Cache-Control: no-cache"
                     "Cache-Control: no-store"
                     "\r\n"))
          (body "hej!\r\n"))
     (log-debug "headers: ~p" `(,headers))
     (log-debug "body: ~p" `(,body))
     (barista-resposne:proceed 200 headers body))))
