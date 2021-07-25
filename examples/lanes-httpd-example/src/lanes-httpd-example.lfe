(defmodule lanes-httpd-example
  (export all))

(include-lib "logjam/include/logjam.hrl")

(defun start ()
  (logger:set_primary_config #m(level all))
  (logjam:set-handler-from-config "config/sys.config")
  (log-notice "Starting lanes httpd example application ...")
  (application:ensure_all_started 'lanes-httpd-example))
