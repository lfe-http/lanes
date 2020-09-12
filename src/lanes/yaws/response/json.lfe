(defmodule lanes.yaws.response.json
  (export all))

(defun json-content (data)
  (lanes.yaws.response:content "application/json" data))

(defun json-result (data)
  (json-content (++ "{\"result\": " data "}")))

(defun json-text-result (text)
  (json-content (++ "{\"result\": \"" text "\"}")))

(defun created (message)
  (lanes.yaws.response:response
    (lanes.http-codes:created)
    (json-text-result message)))

(defun created (message location)
  (lanes.yaws.response:response
    (lanes.http-codes:created)
    (json-text-result message)
    (list (lanes.yaws:make-header 'location location))))

(defun created ()
  (created "created"))

(defun updated (message)
  (lanes.yaws.response:response
    (lanes.http-codes:ok)
    (json-text-result message)))

(defun updated ()
  (updated "updated"))

(defun deleted (message)
  (lanes.yaws.response:response
    (lanes.http-codes:ok)
    (json-text-result message)))

(defun deleted ()
  (deleted "deleted"))

(defun error (status-code message)
  (lanes.yaws.response:response
    status-code
    (json-result (++ "{\"error\": \"" message "\"}"))))

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
  (lanes.yaws.response:ok (json-text-result content)))

(defun ok ()
  (ok "ok"))
