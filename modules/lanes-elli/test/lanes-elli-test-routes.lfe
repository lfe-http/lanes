(defmodule lanes-elli-test-routes
  (export
   (handle 3)))

(include-lib "lanes-elli/include/macros.lfe")

(defun test-handler (msg _req)
  (lists:flatten (io_lib:format msg '())))

(defroutes
  ('GET #"/a"
        (test-handler "/a - gotten" req))
  ('POST #"/a/b"
         (lanes.elli:accepted))
  ('PUT #"/a/b/:id"
        (test-handler (io_lib:format "/a/b/~p - updated" (list id)) req))
  ('ALLOWONLY
        ('GET 'PUT 'POST)
        (lanes.elli:method-not-allowed))
  ('NOTFOUND
        (lanes.elli:not-found)))
