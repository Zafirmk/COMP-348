;; Author: Zafir Khalid
;; ID: 40152164
;; Description: An iterative lisp solution that prints a triangle with n rows
;; Input: n - number of rows of the triangle

(defun triangle (n)

    (if (integerp n)

        (loop for x from 1 to n do
        
            (loop for y from 1 to x do
            
                (write y)
            
            )

            (write-line "")
        
        )
        
    (if (floatp n) (write-line "Decimal numbers are not valid input, please enter an integer") (write-line "Enter an integer please - not a string")))
    

)

(triangle 4)