(defun noop ()
  'noop)

;; We need 3 functions of different arities:
;;    routes/3 - METHOD path expr
;;    routes/4 - METHOD path args expr
;;    routes/5 - METHOD path args data expr
;;    routes/6 - METHOD path args data response expr


; (defroutes handler
;   (POST "/order"
;         (create-order))
;   (GET "/order/:id" (id)
;        (get-order id))
;   )

(defmacro defroutes body
  'noop)

(defun many-or (body)
  (let (((cons head tail) body))
    (case tail
      ('() head)
      (_ `(or ,head ,(many-or tail))))))

(defun in? (item collection)
  (orelse (lists:map (lambda (x) `(=== ,x ,item)) collection)))

(defmacro in (item collection)
  `(orelse ,@(lists:map (lambda (x) `(=== ,x ,item)) collection)))

(defmacro not-in (item collection)
  `(not (in ,item ,collection)))
