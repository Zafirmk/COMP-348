;; Author: Zafir Khalid
;; ID: 40152164
;; Description: Function that calculates sin and cos values
;; Input: x - -10<x<10. The value of sin/cos to calculate
;; Input: n - The relative degree of accuracy required

;; Helper function to calculate factorials of a number
(defun factorial (n)
  (cond
    ((= n 1) 1)
    ((= n 0) 1)
    (t (* n (factorial (- n 1))))))

;; Helper function to calculate x^n
(defun raiseToPower (x n)
    (cond 
        ((= n 0) 1)
        (t (* x (raiseToPower x (- n 1))))
    )
)

;; Helper function to calculate sin(x)
(defun sinx (x n)

    (setf sum 0)
    (setf curr_exp 1)
    (setf curr_sign 1)
    (setf i 0)

    (loop

        (if (oddp i) (setf curr_sign -1) (setf curr_sign 1))

        (setf numerator (raiseToPower x curr_exp))
        (setf denominator (factorial curr_exp))
        (setf curr_val (* curr_sign (/ numerator denominator)))


        (setf sum (+ sum curr_val))

        (setf i (+ i 1))
        (setf curr_exp (+ curr_exp 2))
        (when (> curr_exp n) (return (float sum)))
    )

)

;; Helper function to calculate cos(x)
(defun cosx (x n)

    (setf sum 0)
    (setf curr_exp 0)
    (setf curr_sign 1)
    (setf i 0)

    (loop

        (if (oddp i) (setf curr_sign -1) (setf curr_sign 1))


        (setf numerator (raiseToPower x curr_exp))
        (setf denominator (factorial curr_exp))
        (setf curr_val (* curr_sign (/ numerator denominator)))

        (setf sum (+ sum curr_val))

        (setf i (+ i 1))
        (setf curr_exp (+ curr_exp 2))
        (when (> curr_exp n) (return (float sum)))
    )

)

;; Main function that calculates sin or cos based on the n value
(defun sin-cos-comp (x n)

    (cond 
        
        ((floatp n) (write-line "Please enter an integer value for n"))
        ((stringp n) (write-line "Please enter an integer value for n (Not a string)"))
        (t (if (oddp n) (sinx x n) (cosx x n)))
    
    )

)

(print (sin-cos-comp 3.1415926535 30))
(print (sin-cos-comp 3.1415926535 29))