;; Author: Zafir Khalid
;; ID: 40152164
;; Description: Function that swaps the first and last elements of a list
;; Input: lst - list to create a to swap first and last elements of

;; Helper function that returns only the last element in a list
(defun endElement (lst)
    (cond
        ((null lst)
            nil
        )

        ((null (cdr lst))
            (car lst)
        )

        (t
            (endElement (cdr lst))
        )
    )
)

;; Helper function that returns all elements except the last one
(defun allButLast (lst)

    (cond
        ((null lst)
            nil
        )

        ((null (cdr lst))
            '()
        )

        (t
            (cons (car lst) (allButLast (cdr lst)))
        )
    
    )

)

;; Main function to swap the first and last elements
(defun f-l-swap (lst)

    (setf firstElement (car lst))
    (setf lastElement (endElement lst))
    (setf middleLst (cdr (allButLast lst)))

    (setf newlst (append (cons lastElement middleLst) (list firstElement)))

)

(print (f-l-swap '((a d) f 10 w h)))
(print (f-l-swap '(g 6 p 10 m)))