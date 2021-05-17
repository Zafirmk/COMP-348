;; Author: Zafir Khalid
;; ID: 40152164
;; Description: Function to create a list of only characters without any duplications
;; Input: lst - list to create a list of only characters from

;; Converts a list to a set by removing all duplicates
(defun lst-to-set (lst)

    (cond ((null lst) lst)

        ((member (car lst) (cdr lst))(lst-to-set (cdr lst)))

        (t (cons (car lst) (lst-to-set (cdr lst))))))


;; Function to only hold on to the characters in a list
(defun charsOnly (lst)

    (cond 
        ((null lst) nil)


        ((atom (car lst)) 
        
            (cond 
                ((numberp (car lst)) (lst-to-set (charsOnly (cdr lst))))
                (t (lst-to-set (cons (car lst) (charsOnly (cdr lst)))))
            )
        )       
        
        (t (lst-to-set (append (charsOnly (car lst)) (charsOnly(cdr lst)))))
        
    )
        
        
)

(print (charsOnly '((z f) (b a 5 3.5) 6 (7) (a) c)))
(print (charsOnly '( (n) 2 (6 h 7.8) (w f) (n) (c) n)))



