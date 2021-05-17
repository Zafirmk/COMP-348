;; Author: Zafir Khalid
;; ID: 40152164
;; Description: Two implementations of a method to calculate the distance between two points on a 2D grid
;; Input: P1/P2 - (x, y) coordinate of the first/second location on the 2D grid
;; Extra note: Lambda implementation is more efficient since they are not stored permanently in memory

;; Regular implementation
(defun distance (P1 P2) 
    (setf x1 (car P1))
    (setf x2 (car P2))
    (setf y1 (car (cdr P1)))
    (setf y2 (car (cdr P2)))
    
    (print (sqrt (+ (* (- x1 x2) (- x1 x2)) (* (- y1 y2) (- y1 y2))))))

;; Lambda implementation
(write ((lambda (P1 P2)
    (setf x1 (car P1))
    (setf x2 (car P2))
    (setf y1 (car (cdr P1)))
    (setf y2 (car (cdr P2)))
    (sqrt (+ (* (- x1 x2) (- x1 x2)) (* (- y1 y2) (- y1 y2)))))

   '(-7 -4)'(17 6.5))
)

(distance '(-7 -4)'(17 6.5))