(defmodule lanes-elli-example
  (export
   (start 0)))

(include-lib "logjam/include/logjam.hrl")

(defun start ()
  (logger:set_primary_config #m(level all))
  (logjam:set-handler-from-config "config/sys.config")
  (log-notice "Starting LFE elli example application ...")
  (application:ensure_all_started 'lanes-elli-example))
