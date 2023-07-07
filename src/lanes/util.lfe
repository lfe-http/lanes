(defmodule lanes.util
  (export
   (not-in 2)))

(defun not-in (item collection)
  `(not (orelse ,@(lists:map (lambda (x) `(== ,x ,item)) collection))))
