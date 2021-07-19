(defmodule lanes-elli-sup
  (beehaviour supervisor)
  ;; supervisor implementation
  (export
   (start_link 0)
   (stop 0))
  ;; callback implementation
  (export
    (init 1)))

;;; ----------------
;;; config functions
;;; ----------------

(defun SERVER () (MODULE))
(defun supervisor-opts () '())

(defun sup-flags ()
  `#m(strategy one_for_one
      intensity 3
      period 60))

(defun elli-opts ()
  '(#(callback lanes-elli-routes)
    #(port 5099)))

(defun elli-spec ()
  `#m(id lanes-elli-example
      start #(elli start_link (,(elli-opts)))
      restart permanent
      shutdown 5000
      type worker
      modules (elli)))

;;; -------------------------
;;; supervisor implementation
;;; -------------------------

(defun start_link ()
  (supervisor:start_link `#(local ,(SERVER))
                         (MODULE)
                         (supervisor-opts)))

(defun stop ()
  (gen_server:call (SERVER) 'stop))

;;; -----------------------
;;; callback implementation
;;; -----------------------

(defun init (_args)
  `#(ok #(,(sup-flags) (,(elli-spec)))))
