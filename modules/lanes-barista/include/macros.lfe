(defmacro defroutes body
  "This macro takes the elements of a valid set of routes and transforms them
  into a series of function heads which comprise the final output, the barista
  handler function 'handle/3'."
  `(defun handle
     ,@(lanes.common:compile-routes body)))

(defun --loaded-barista-route-macros-- ()
  "This is just a dummy function for display purposes when including from the
  REPL (the last function loaded has its name printed in stdout).

  This function needs to be the last one in this include."
  'ok)
