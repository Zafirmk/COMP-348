;; Author: Zafir Khalid
;; ID: 40152164
;; Description: 2 functions that create a list of pell numbers
;; Input: n - The number of pell numbers needed

;; Iterative solution
(defun pellnumbersIterative (n)

    (setf previouspell 0)
    (setf previouspreviouspell 0)
    (setf currentpell 1)
    (setf x 1)

    (setf lst '(0 1))

    (loop
    
    
        (setf previouspreviouspell previouspell)
        (setf previouspell currentpell)
        (setf currentpell (+ previouspreviouspell (* 2 previouspell)))
        (setf x (+ x 1))
        
        (setf lst (append lst (list currentpell)))

        (when (> x (- n 1))(return lst))
    )

)

;; Recursive solution
(defun pellnumbersrecursive (n)
    (cond 
        ((<= n 2) n)
        (t
            (setf curr_val (+ (* 2 (pellnumbersrecursive (- n 1))) (pellnumbersrecursive (- n 2)))) 
        )
    )
)

;; Helper function to generate a list from the recursive solution
(defun pellRecursionList (n)

    (setf i 0)
    (setf pellRecursionListlst '())

    (loop
        (setf curr_val2 (pellnumbersrecursive i))
        (setf pellRecursionListlst (append pellRecursionListlst (list curr_val2)))
        (setf i (+ i 1))
        (when (> i n)(return pellRecursionListlst))
    )
)

;; Sample outputs
(write "Recursive Solution:")
(print (pellRecursionList 6))
(write-line "")
(write "Iterative Solution:")
(print (pellnumbersIterative 6))
(write-line "")
(write "Recursive Solution:")
(print (pellRecursionList 10))
(write-line "")
(write "Iterative Solution:")
(print (pellnumbersIterative 10))

