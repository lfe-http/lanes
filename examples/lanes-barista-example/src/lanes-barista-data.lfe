(defmodule lanes-barista-data
  (export
   (create-order 1)
   (get-order 1)
   (get-orders 0)
   (update-order 2)
   (delete-order 1)
   (get-payment-status 1)
   (make-payment 2)))

(include-lib "logjam/include/logjam.hrl")

(defun create-order (post-data)
  (log-debug "Got POST data: ~p" (list post-data))
  "CREATED")

(defun get-order
  ((id) (when (is_binary id))
   (get-order (binary_to_list id)))
  ((id)
   (log-debug "Querying DB fo order id ~p ..." (list id))
   (++ "ORDER DATA FOR ID " id)))

(defun get-orders ()
  (log-debug "Querying DB for all orders ...")
  "ALL ORDERS DATA")

(defun update-order (id post-data)
  (log-debug "Updating order with id ~p ..." (list id))
  (log-debug "Got POST data: ~p" (list post-data))
  "UPDATED")

(defun delete-order (id)
  (log-debug "Deleting order for id ~p ..." (list id))
  "DELETED")

(defun get-payment-status (order-id)
  (log-debug "Checking for payment status of order with id ~p ..."
             (list order-id))
  "PAID")

(defun make-payment (order-id payment-data)
  (log-debug "Making payment for order with id ~p ..." (list order-id))
  (log-debug "Got POST data: ~p" (list payment-data))
  "PAYMENT SUBMITTED")
