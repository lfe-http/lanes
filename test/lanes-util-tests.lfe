(defmodule lanes-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest split-path
  (is-equal '(#"" #"a" #"b" #"c")
            (lanes.util:split-path "/a/b/c"))
  (is-equal '(#"" #"a" #"b" #"c")
            (lanes.util:split-path #"/a/b/c"))
  (is-equal '(#"a" #"b" #"c")
            (lanes.util:split-path #"a/b/c"))
  (is-equal '(#" a" #"b" #"c ")
            (lanes.util:split-path #" a/b/c "))
  (is-equal '(#"" #"user" #"update" #":id")
            (lanes.util:split-path #"/user/update/:id")))

(deftest handle-path-segment
  (is-equal "a"
            (lanes.util:handle-path-segment "a"))
  (is-equal 'id
            (lanes.util:handle-path-segment ":id"))
  (is-equal 'id-with-dashes
            (lanes.util:handle-path-segment ":id-with-dashes"))
  (is-equal #"a"
            (lanes.util:handle-path-segment #"a"))
  (is-equal 'id
            (lanes.util:handle-path-segment #":id")))

(deftest handle-path-segments
  (is-equal '(#"a" #"b" #"c")
            (lanes.util:handle-path-segments '(#"a" #"b" #"c")))
  (is-equal '(#"user" #"update" id)
            (lanes.util:handle-path-segments '(#"user" #"update" #":id"))))

(deftest path->segments
  (is-equal '(#"a" #"b" #"c")
            (lanes.util:path->segments "/a/b/c"))
  (is-equal '(#"a" #"b" #"c")
            (lanes.util:path->segments #"/a/b/c"))
  (is-equal '(#"a" #"b" #"c")
            (lanes.util:path->segments #"a/b/c"))
  (is-equal '(#"%20a" #"b" #"c%20")
            (lanes.util:path->segments #" a/b/c "))
  (is-equal '(#"user" #"update" id)
            (lanes.util:path->segments #"/user/update/:id")))

(deftest hex-octet
  (is-equal "61"
            (lanes.util:hex-octet #\a))
  (is-equal "20"
            (lanes.util:hex-octet #\ )))

(deftest percent-encode-byte
  (is-equal "%61"
            (lanes.util:percent-encode-byte #\a))
  (is-equal "%20"
            (lanes.util:percent-encode-byte #\ )))

(deftest encode-uri
  (is-equal #"a"
            (lanes.util:encode-uri "a"))
  (is-equal #"%20"
            (lanes.util:encode-uri " "))
  (is-equal #"alice%3aroberts%40host"
            (lanes.util:encode-uri "alice:roberts@host")))