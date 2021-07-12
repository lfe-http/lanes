(defmodule lanes.util
  (export
   (version 0)
   (versions 0))
  (export
   (handle-path-segment 1)
   (handle-path-segments 1)
   (path->segments 1)
   (split-path 1)))

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

(defun path-sep () #"/")

(defun split-path
  ((path) (when (is_list path))
   (split-path (list_to_binary path)))
  ((path) (when (is_binary path))
   (binary:split path (path-sep) '(global))))

(defun handle-path-segment
  (((= (cons #\: var-name) seg)) (when (is_list seg))
   (list_to_atom var-name))
  (((= (binary ":" (var-name bitstring)) seg)) (when (is_binary seg))
    (binary_to_atom var-name 'utf8))
  ((seg)
   seg))

(defun handle-path-segments (path-segments)
  (lists:map
   #'lanes.util:handle-path-segment/1
   path-segments))

(defun path->segments (path)
  (lists:filter
   (lambda (x) (=/= #"" x))
   (lists:map
    (lambda (x)
      (let ((r (handle-path-segment x)))
        (if (is_atom r)
          r
          (http_uri:encode r))))
    (split-path path))))