(defmodule lanes.elli.util
  (export
   (compile-route 1)
   (compile-routes 1)
   (make-handler-pattern 1) (make-handler-pattern 2)
   (parse-path 1)
   ))

(defun parse-path (path-segments)
  (lists:map
   #'lanes.util:handle-path-segment/1
   path-segments))

(defun make-handler-pattern
  (('NOTFOUND)
   (list '_ '_ 'req)))

(defun make-handler-pattern
  ((method path-segments)
   (list method (parse-path path-segments) 'req)))

(defun compile-route
  "For each form passed, the last element is always the expression to
    execute; before it are the method, the path, and the data from YAWS.

    We need to re-form each route as a function head pattern and the
    expression (function to call or output to render) for that pattern."
  ((`('ALLOWONLY ,methods ,expr))
   `((method path arg-data) (when (not-in method ,methods))
     ,expr))
  ((`('NOTFOUND ,expr))
   `((method path arg-data) ,expr))
  ((`(,method ,path ,expr))
   `((,@(make-handler-pattern method path)) ,expr)))

(defun compile-routes (forms)
  (lists:map #'compile-route/1 forms))

;;(defun handle
;;  (('GET '(#"hello" #"world") _req)
;;   #(200 () #"Hello, world!"))
;;  (('GET `(#"hello" ,name) _req)
;;   `#(200 () (#"Hello, " ,name #".")))
;;  ((_ _ _req)
;;   #(404 () #"Not Found")))