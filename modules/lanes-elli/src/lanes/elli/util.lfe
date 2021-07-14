(defmodule lanes.elli.util
  (export
   (compile-route 1)
   (compile-routes 1)
   (make-handler-pattern 1) (make-handler-pattern 2)))

(defun make-handler-pattern
  (('NOTFOUND)
   (list '_ '_ 'req)))

(defun make-handler-pattern
  ((method path)
   (list method `(list ,@(lanes.util:path->segments path)) 'req)))

(defun compile-route
  "For each form passed, the last element is always the expression to
  execute; before it are the method, the path segments, and the request.

  We need to re-form each route as a function head pattern and the
  expression (function to call or output to render) for that pattern."
  ((`('ALLOWONLY ,methods ,expr))
   `((method _segments _req) (when ,(lanes.util:not-in 'method methods))
     ,expr))
  ((`('NOTFOUND ,expr))
   `((,@(make-handler-pattern 'NOTFOUND)) ,expr))
  ((`(,method ,path ,expr))
   `((,@(make-handler-pattern method path)) ,expr)))

(defun compile-routes (forms)
  (lists:map #'compile-route/1 forms))
