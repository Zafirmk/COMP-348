;; Author: Zafir Khalid
;; ID: 40152164
;; Description: Function to check if the given tree is binary search tree
;; Input: tree - The binary tree to check whether it is or isn't a binary search tree
;; Algorithm - Checks if the in order traversal of a tree is in ascending order, if so then the given tree is a BST

(setf lst ())

;; Inorder traversal of the binary tree
(defun inOrderTraversal (tree)
    (cond
        ((null tree)
            ()
        )
        (t
            (list (car tree) (inOrderTraversal (car (cdr tree))) (car (cdr (cdr tree))))
            (setf lst (append lst (list (car tree))))
            (list (car tree) (car (cdr tree)) (inOrderTraversal (car (cdr (cdr tree)))))
        )
    )
)

;; Helper function to check if a list is sorted in ascending order
(defun isSorted (lst)

    (cond 
        ((or (null lst) (null (cdr lst)))
            t
        )
        ((< (car lst) (car (cdr lst))) 
            (isSorted (cdr lst))
        )
        (t 
            nil
        )
    )
)

;; Main function to check if a tree is a binary search tree
(defun isBST (tree)

    (inOrderTraversal tree)
    (setf inOrderTraversal lst)
    (if (isSorted inOrderTraversal) (write-line "The tree is a BST!") (write-line "The tree is not a BST!"))

)

(setf testTree '(8 (3 (1 () ()) (6 (4 () ())(7 () ()))) (10 () (14 (13 () () ) ()))))
(setf testTree2 '(8 (3 (1 (100 () ()) ()) (6 (4 () ())(7 () ()))) (10 () (14 (13 () () ) ()))))

(isBST testTree)
(isBST testTree2)