(defmodule lanes.uri
  (export
   (encode 1)))

;; Code for this was converted from Erlang written by Renato Albano, CapnKernul
;; (Github user), erlangexamples.com, and the erlang docs for the edoc lib.
;; This function was originally part of the lanes library at the following:
;;  * `src/encode_uri_rfc3986.erl`

(defun encode (chars)
  chars `#m(as-string true))

(defun encode (chars opts)
  chars)

;;; Private functions

(defun encode-binary (data)
  (unicode:characters_to_binary
    (encode-string
      (unicode:characters_to_list data))))

(defun encode-string (data)
  data)

(defun hex-octet (char)
  char)

(defun normalise-hex (hex)
  hex)

(defun escape-byte (char)
  (normalise-hex (hex-octet char)))
