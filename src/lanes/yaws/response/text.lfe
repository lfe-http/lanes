(defmodule lanes.yaws.response.text
  (export all))

(defun text-content (data)
  (lanes.yaws.response:content "text/plain" data))

(defun created (message)
  (lanes.yaws.response:response
    (lanes.http-codes:created)
    (text-content message)))

(defun created (message location)
  (lanes.yaws.response:response
    (lanes.http-codes:created)
    (text-content message)
    (list (lanes.yaws:make-header 'location location))))

(defun created ()
  (created "created"))

(defun updated (message)
  (lanes.yaws.response:response
    (lanes.http-codes:ok)
    (text-content message)))

(defun updated ()
  (updated "updated"))

(defun deleted (message)
  (lanes.yaws.response:response
    (lanes.http-codes:ok)
    (text-content message)))

(defun deleted ()
  (deleted "deleted"))

(defun error (status-code message)
  (lanes.yaws.response:response
    status-code
    (text-content (++ "error :" message))))

(defun error ()
  (error
    (lanes.http-codes:internal-server-error)
    "internal server error"))

(defun not-found (message)
  (error
    (lanes.http-codes:not-found)
    message))

(defun not-found ()
  (not-found "not found"))

(defun method-not-allowed ()
  (error
    (lanes.http-codes:method-not-allowed)
    "method not allowed"))

(defun ok (content)
  (lanes.yaws.response:ok (text-content content)))

(defun ok ()
  (ok "ok"))
