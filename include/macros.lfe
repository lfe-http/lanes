;; We need 3 functions of different arities:
;;    routes/2 - NOTFOUND expr
;;    routes/3 - METHOD path expr
;;    routes/3 - FORBIDDEN method-list
;;    routes/4 - METHOD path args expr


; (defroutes handler
;   (POST "/order"
;         (create-order))
;   (GET "/order/:id" (id)
;        (get-order id))
;   )

;; XXX this macro should probably be moved into lfe-utils ...
(defmacro in (item collection)
  `(orelse ,@(lists:map (lambda (x) `(=== ,x ,item)) collection)))

;; XXX this macro should probably be moved into lfe-utils ...
(defmacro not-in (item collection)
  `(not (in ,item ,collection)))

;; In LFE, if you want to call functions from macros, they need to be
;; wrapped in (eval-when-compile ...).
(eval-when-compile

  (defun rebuild-head
    (((list method path-string))
     `(,method ,(string:tokens path-string "/") arg-data)))

  (defun split-params (elements)
    "For each form passed, the last element is always the expression to
    execute; before it are the method, the path, and the data from YAWS.

    We need to re-form each route as a function head pattern and the
    expression for that pattern."
    (let* (((cons tail rev-head) (lists:reverse elements))
           (head (lists:reverse rev-head)))
      (case (eval (car head))
        ('FORBIDDEN `((method p a) (when (not-in method ,(lists:nth 2 head)))
                      ,tail))
        ('NOTFOUND `((method path arg-data) ,tail))
        (_ `((,@(rebuild-head head)) ,tail)))))

  (defun compile-routes (forms)
    (lists:map #'split-params/1 forms)))

(defmacro defroutes body
  `(defun routes ,@(compile-routes body)))
