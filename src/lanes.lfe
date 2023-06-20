(defmodule lanes
  (export all))

(defun version () (lanes.version:get))

(defun versions () (lanes.version:all))
