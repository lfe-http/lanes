(defmodule lanes-elli-app
  (behaviour application)
  ;; app implementation
  (export
   (start 2)
   (stop 0)))

(include-lib "logjam/include/logjam.hrl")

;;; --------------------------
;;; application implementation
;;; --------------------------

(defun start (_type _args)
  (logger:set_primary_config #m(level all))
  (logjam:set-handler-from-config "config/sys.config")
  (log-notice "Starting LFE elli example application ...")
  (lanes-elli-sup:start_link))

(defun stop ()
  (lanes-elli-sup:stop)
  'ok)
