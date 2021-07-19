(defmodule lanes.httpc
  (export
   (body 1)
   (headers 1)
   (status 1)))

(defun body
  ((`#(,_ ,_ ,body))
   body))

(defun headers
  ((`#(,_ ,headers ,_))
   headers))

(defun status
  ((`#(#(,_ ,status ,_) ,_ ,_))
   status))
