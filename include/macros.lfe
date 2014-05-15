(defun noop ()
  'noop)

;; We need 3 functions of different arities:
;;    routes/2 - METHOD path
;;    routes/3 - METHOD path args
;;    routes/4 - METHOD path args data
;;    routes/5 - METHOD path args data response
