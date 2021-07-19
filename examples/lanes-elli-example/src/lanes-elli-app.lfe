(defmodule lanes-elli-app
  (behaviour application)
  ;; app implementation
  (export
   (start 2)
   (stop 0)))

;;; --------------------------
;;; application implementation
;;; --------------------------

(defun start (_type _args)
  (lanes-elli-sup:start_link))

(defun stop ()
  (lanes-elli-sup:stop)
  'ok)
