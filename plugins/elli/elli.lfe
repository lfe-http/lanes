(defmodule lanes.elli
  (export
   (get-data 1))
  (export
   (method-not-allowed 0) (method-not-allowed 1)
   (not-found 0) (not-found 1)
   (ok 0) (ok 1)
   (response 1) (response 2) (response 3)))

;;; Request functions

(defun get-data (req)
  (elli_request:post_args_decoded req))

;;; Response functions

(defun response (body)
  (response 200 body))

(defun response (status body)
  (response status '() body))

(defun response (status headers body)
  (tuple status headers body))

(defun ok ()
  (ok "OK"))

(defun ok (body)
  (response 200 body))

(defun method-not-allowed ()
  (method-not-allowed #"Method Not Allowed"))

(defun method-not-allowed (body)
  (response 405 body))

(defun not-found ()
  (not-found "Not Found"))

(defun not-found (body)
  (response 404 body))
