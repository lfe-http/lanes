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
  (is-equal '(#"a" #"b" #"42")
            (lanes.util:path->segments "/a/b/42"))
  (is-equal '(#"a" #"b" #"42")
            (lanes.util:path->segments #"/a/b/42"))
  (is-equal '(#"a" #"b" #"42")
            (lanes.util:path->segments #"a/b/42"))
  (is-equal '(#"%20a" #"b" #"42%20")
            (lanes.util:path->segments #" a/b/42 "))
  (is-equal '(#"user" #"update" id)
            (lanes.util:path->segments #"/user/update/:id")))
