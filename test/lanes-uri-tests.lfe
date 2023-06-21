(defmodule lanes-uri-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest encode
  (is-equal ""
            (lanes.uri:encode ""))
  (is-equal "a"
            (lanes.uri:encode "a"))
  (is-equal "42"
            (lanes.uri:encode "42"))
  (is-equal "%20"
            (lanes.uri:encode " "))
  (is-equal "a42"
            (lanes.uri:encode "a42"))
  (is-equal "42a"
            (lanes.uri:encode "42a"))
  (is-equal "42%20a"
            (lanes.uri:encode "42 a"))
  (is-equal "42%20a%40stuff"
            (lanes.uri:encode "42 a@stuff"))
  (is-equal "alice%3aroberts%40host"
            (lanes.uri:encode "alice:roberts@host"))
  (is-equal "-_.!~*'()"
            (lanes.uri:encode "-_.!~*'()")))

(deftest encode-string
  (is-equal ""
            (lanes.uri:encode "" #m(as-string true)))`
  (is-equal "a"
            (lanes.uri:encode "a" #m(as-string true)))`
  (is-equal "42"
            (lanes.uri:encode "42" #m(as-string true)))
  (is-equal "%20"
            (lanes.uri:encode " " #m(as-string true)))
  (is-equal "a42"
            (lanes.uri:encode "a42" #m(as-string true)))
  (is-equal "42a"
            (lanes.uri:encode "42a" #m(as-string true)))
  (is-equal "42%20a"
            (lanes.uri:encode "42 a" #m(as-string true)))
  (is-equal "42%20a%40stuff"
            (lanes.uri:encode "42 a@stuff" #m(as-string true)))
  (is-equal "alice%3aroberts%40host"
            (lanes.uri:encode "alice:roberts@host" #m(as-string true))))

(deftest encode-bytes
  (is-equal #""
            (lanes.uri:encode #"" #m(as-bytes true)))
  (is-equal #"a"
            (lanes.uri:encode #"a" #m(as-bytes true)))
  (is-equal #"42"
            (lanes.uri:encode #"42" #m(as-bytes true)))
  (is-equal #"%20"
            (lanes.uri:encode #" " #m(as-bytes true)))
  (is-equal #"a42"
            (lanes.uri:encode #"a42" #m(as-bytes true)))
  (is-equal #"42a"
            (lanes.uri:encode #"42a" #m(as-bytes true)))
  (is-equal #"42%20a"
            (lanes.uri:encode #"42 a" #m(as-bytes true)))
  (is-equal #"42%20a%40stuff"
            (lanes.uri:encode #"42 a@stuff" #m(as-bytes true)))
  (is-equal #"alice%3aroberts%40host"
            (lanes.uri:encode #"alice:roberts@host" #m(as-bytes true))))
