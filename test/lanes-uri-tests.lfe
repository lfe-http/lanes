(defmodule lanes-uri-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

;; TODO:
;; encode_uri_rfc3986:encode --> lanes.uri:encode

(deftest encode
  (is-equal "a"
            (encode_uri_rfc3986:encode "a"))
  (is-equal "42"
            (encode_uri_rfc3986:encode "42"))
  (is-equal "%20"
            (encode_uri_rfc3986:encode " "))
  (is-equal "a42"
            (encode_uri_rfc3986:encode "a42"))
  (is-equal "42a"
            (encode_uri_rfc3986:encode "42a"))
  (is-equal "42%20a"
            (encode_uri_rfc3986:encode "42 a"))
  (is-equal "42%20a%40stuff"
            (encode_uri_rfc3986:encode "42 a@stuff"))
  (is-equal "alice%3aroberts%40host"
            (encode_uri_rfc3986:encode "alice:roberts@host")))

(deftest encode-string
  (is-equal "a"
            (encode_uri_rfc3986:encode "a"))
  (is-equal "42"
            (encode_uri_rfc3986:encode "42"))
  (is-equal "%20"
            (encode_uri_rfc3986:encode " "))
  (is-equal "a42"
            (encode_uri_rfc3986:encode "a42"))
  (is-equal "42a"
            (encode_uri_rfc3986:encode "42a"))
  (is-equal "42%20a"
            (encode_uri_rfc3986:encode "42 a"))
  (is-equal "42%20a%40stuff"
            (encode_uri_rfc3986:encode "42 a@stuff"))
  (is-equal "alice%3aroberts%40host"
            (encode_uri_rfc3986:encode "alice:roberts@host")))

(deftest encode-bytes
  (is-equal #"a" #"a"))
