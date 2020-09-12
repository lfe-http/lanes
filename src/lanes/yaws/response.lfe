(defmodule lanes.yaws.response
  (export all))

(defun content (content-type content)
  "Makes a content tuple in the format required by YAWS."
  `#(content ,content-type ,content))

(defun text-content (data)
  (content "text/plain" data))

(defun response (status-code content)
  `(#(status ,status-code) ,content))

(defun response (status-code content headers)
  (++ (response status-code content) headers))

(defun error (content)
  (response (lanes.http-codes:internal-server-error) content))

(defun not-found (content)
  (response (lanes.http-codes:not-found) content))

(defun ok (content)
  (response (lanes.http-codes:ok) content))
