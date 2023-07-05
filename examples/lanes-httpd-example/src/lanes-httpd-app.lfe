(defmodule lanes-httpd-app
  (behaviour application)
  (export all))

(defun config ()
  '(#(port 5097)
    #(server_name "lanes-httpd-example")
    #(modules (lanes-httpd-routes))))

(defun start ()
  (inets:start 'httpd (config)))

(defun start (_type _args)
  (start))

(defun stop (pid)
  (inets:stop 'httpd pid))

(defun stop ()
  (inets:stop 'httpd))
