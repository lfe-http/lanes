(defmodule lanes-elli-data
  (behaviour elli_handler)
  (export
   (handle 2)
   (handle_event 3)))

(include-lib "logjam/include/logjam.hrl")

(defun create-order (post-data)
  (log-debug "Got POST data: ~p" (list post-data))
  #"CREATED")

(defun get-order (id)
  (log-debug "Querying DB fo order id ~p ..." (list id))
  #"ORDER DATA")

(defun get-orders ()
  (log-debug "Querying DB for all orders ...")
  #"ALL ORDERS DATA")

(defun update-order (id post-data)
    (log-debug "Updating order with id ~p ..." (list id))
    (log-debug "Got POST data: ~p" (list post-data))
    #"UPDATED")

(defun delete-order (id)
  (log-debug "Deleting order for id ~p ..." (list id))
  #"DELETED")

(defun get-payment-status (order-id)
  (log-debug "Checking for payment status of order with id ~p ..."
             list order-id)
  #"PAID")

(defun make-payment (order-id payment-data)
    (log-debug "Making payment for order with id ~p ..." (list order-id))
    (log-debug "Got POST data: ~p" (list payment-data))
    #"PAYMENT SUBMITTED")
