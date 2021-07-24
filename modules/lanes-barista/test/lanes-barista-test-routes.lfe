(defmodule lanes-barista-test-routes
  (export
   (handle 3)))

(include-lib "lanes-barista/include/macros.lfe")

(defun test-handler (msg _req)
  (lists:flatten (io_lib:format msg '())))

(defroutes
  ('GET #"/a"
        (barista-response:ok
         (test-handler "/a - gotten" req)))
  ('POST #"/a/b"
         (barista-response:accepted))
  ('PUT #"/a/b/:id"
        (barista-response:accepted
         (test-handler
          (io_lib:format "/a/b/~p - updated" (list id))
          req)))
  ('ALLOWONLY
        ('GET 'PUT 'POST)
        (barista-response:method-not-allowed))
  ('NOTFOUND
        (barista-response:not-found)))
