(defmodule lanes.elli
  (export
   (get-data 1))
  (export
   (accepted 0) (accepted 1)
   (created 0) (created 1)
   (method-not-allowed 0) (method-not-allowed 1)
   (no-content 0) (no-content 1)
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

(defun accepted ()
  (accepted #"Accepted"))

(defun accepted (body)
  (response 202 body))

(defun created ()
  (created #"Created"))

(defun created (body)
  (response 201 body))

(defun ok ()
  (ok #"OK"))

(defun ok (body)
  (response 200 body))

(defun method-not-allowed ()
  (method-not-allowed #"Method Not Allowed"))

(defun method-not-allowed (body)
  (response 405 body))

(defun no-content ()
  (no-content #"No Content"))

(defun no-content (body)
  (response 204 body))

(defun not-found ()
  (not-found #"Not Found"))

(defun not-found (body)
  (response 404 body))
