(defmodule lanes-barista-app
  (behaviour application)
  (export all))

(defun config ()
  '(#(port 5098)
    #(server_name "lanes-barista-example")
    #(modules (lanes-barista-routes))))

(defun start ()
  (barista:start (config)))

(defun start (_type _args)
  (start))

(defun stop (pid)
  (barista:stop pid))

(defun stop ()
  (inets:stop 'httpd))
