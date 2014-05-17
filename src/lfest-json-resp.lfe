(defmodule lfest-json-resp
  (export all))

(defun json-content (data)
  (lfest-resp:content "application/json" data))

(defun json-result (data)
  (json-content (++ "{\"result\": " data "}")))

(defun created ()
  (lfest-resp:response
    (lfest-codes:created)
    (json-result "\"created\"")))

(defun created (location)
  (lfest-resp:response
    (lfest-codes:created)
    (json-result
      "\"created\"")
      (list (lfest:make-header 'location location))))

(defun updated ()
  (lfest-resp:response
    (lfest-codes:no-content)
    (json-result "\"updated\"")))

(defun deleted ()
  (lfest-resp:response
    (lfest-codes:no-content)
    (json-result "\"deleted\"")))

(defun response (status-code content)
  `(#(status ,status-code) ,content))

(defun error (status-code message)
  (response (json-result (++ "{\"error\": \"" message "\"}"))))

(defun error (status)
  (error status "internal server error"))

(defun not-found ()
  (error (lfest-codes:not-found) "not found"))

(defun ok ()
  (lfest-resp:ok (json-result "\"ok\"")))

(defun ok (content)
  (lfest-resp:ok (json-content content)))
