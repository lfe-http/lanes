(defmodule lanes.util
  (export
   (version 0)
   (versions 0))
  (export
   (handle-path-segment 1)))

;;; Project Metadata

(defun version ()
  (app-version 'lanes))

(defun versions ()
  `(#(apps ,(app-version 'lanes))
    #(languages (language-versions))))

(defun language-versions ()
  `(#(lfe (app-version 'lfe))
    #(erlang ,(erlang:system_info 'otp_release))
    #(emulator ,(erlang:system_info 'version))
    #(driver-version ,(erlang:system_info 'driver_version))))

(defun rebar-versions ()
  `(#(rebar (app-verion 'rebar))
    #(rebar3_lfe (app-version 'rebar3_lfe))))

(defun app-version (app-name)
  (application:load app-name)
  (case (application:get_key app-name 'vsn)
    (`#(ok ,version) version)
    (default default)))

;;; Routes utility functions

(defun handle-path-segment
  (((= (cons #\: var-name) seg)) (when (is_list seg))
   (list_to_atom var-name))
  (((= (binary ":" (var-name bitstring)) seg)) (when (is_binary seg))
    (binary_to_atom var-name))
  ((seg)
   seg))
