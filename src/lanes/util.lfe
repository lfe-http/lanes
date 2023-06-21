(defmodule lanes.util
  (export
   (handle-path-segment 1)
   (handle-path-segments 1)
   (path->segments 1)
   (split-path 1))
  (export
   (not-in 2)))

;;; Routes utility functions

(defun path-sep () #"/")

(defun split-path
  ((path) (when (is_list path))
   (split-path (list_to_binary path)))
  ((path) (when (is_binary path))
   (binary:split path (path-sep) '(global))))

(defun handle-path-segment
  (((= (cons #\: var-name) seg)) (when (is_list seg))
   (list_to_atom var-name))
  (((= (binary ":" (var-name bitstring)) seg)) (when (is_binary seg))
    (binary_to_atom var-name 'utf8))
  ((seg)
   seg))

(defun handle-path-segments (path-segments)
  (lists:map
   #'lanes.util:handle-path-segment/1
   path-segments))

(defun path->segments (path)
  (lists:filter
   (lambda (x) (=/= #"" x))
   (lists:map
    (lambda (x)
      (let ((r (handle-path-segment x)))
        (if (is_atom r)
          r
          (lanes.uri:encode r `#m(as-bytes true)))))
    (split-path path))))

;;; General utility functions

(defun not-in (item collection)
  `(not (orelse ,@(lists:map (lambda (x) `(== ,x ,item)) collection))))
