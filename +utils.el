;;; ~/.doom.d/+utils.el -*- lexical-binding: t; -*-


(defun print-icons (name buf)
  "Print all-the-icons-NAME-data to BUF."
  (let* ((icons (intern (format "all-the-icons-%s" name)))
         (icons-data (intern (format "%s-data" icons))))
    (with-current-buffer buf
      (dolist (icon (funcall icons-data))
        (insert (format "%s  -->  %s\n" (car icon) (funcall icons (car icon) :height 1.0)))))))

(defun print-wicon nil
  (print-icons "wicon" (current-buffer)))

(defun print-fileicon nil
  (print-icons "fileicon" (current-buffer)))

(defun print-faicon nil
  (print-icons "faicon" (current-buffer)))

(defun print-octicon nil
  (print-icons "octicon" (current-buffer)))

(defun print-material nil
  (print-icons "material" (current-buffer)))

(defun print-alltheicon nil
  (print-icons "alltheicon" (current-buffer)))
