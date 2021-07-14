(defmodule lanes.yaws.response.html
  (export all))

(defun html-content (data)
  (lanes.yaws.response:content "text/html" data))

(defun not-found (html)
  (lanes.yaws.response:not-found (html-content html)))

(defun ok (html)
  (lanes.yaws.response:ok (html-content html)))

(defun error (status-code html)
  (lanes.yaws.response:response
    status-code
    (html-content html)))
