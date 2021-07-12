(defmodule lanes.util
  (export
   (version 0)
   (versions 0))
  (export
   (handle-path-segment 1)))

;;; Project Metadata

(defun version ()
  (version 'lanes))

(defun version (app-name)
  (application:load app-name)
  (case (application:get_key app-name 'vsn)
    (`#(ok ,vsn) vsn)
    (default default)))

(defun version-arch ()
  `#(architecture ,(erlang:system_info 'system_architecture)))

(defun version+name (app-name)
  `#(,app-name ,(version app-name)))

(defun versions-rebar ()
  `(,(version+name 'rebar)
    ,(version+name 'rebar3_lfe)))

(defun versions-langs ()
  `(,(version+name 'lfe)
    #(erlang ,(erlang:system_info 'otp_release))
    #(emulator ,(erlang:system_info 'version))
    #(driver ,(erlang:system_info 'driver_version))))

(defun versions ()
  (lists:append `((,(version+name 'lanes))
                  ,(versions-langs)
                  ,(versions-rebar)
                  (,(version-arch)))))

;;; Routes utility functions

(defun handle-path-segment
  (((= (cons #\: var-name) seg)) (when (is_list seg))
   (list_to_atom var-name))
  (((= (binary ":" (var-name bitstring)) seg)) (when (is_binary seg))
    (binary_to_atom var-name 'utf8))
  ((seg)
   seg))
