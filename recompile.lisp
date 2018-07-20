(defpackage #:recompile
  (:use #:cl)
  (:export
   #:recompile))
(in-package recompile)


(defun recompile (system-name &key (verbose t) (break-on-warnings t))
  "Recompile given system. By default all warnings are considered as errors.

   If system uses :package-inferred-system class, then all known subsystems are also
   recompiled."
  (declare (ignorable break-on-warnings))
  (let* ((all-systems (asdf:already-loaded-systems))
         #+ccl ;; CCL allows to continue, but ASDF don't
         (ccl:*break-on-warnings* break-on-warnings)
         #-ccl ;; This does not work for SBCL's notes, only for warnings
         (asdf:*compile-file-warnings-behaviour* (if break-on-warnings
                                                     :error
                                                     :warn)))
    (loop for system in all-systems
          for primary-name = (asdf:primary-system-name system)
          when (string-equal system-name
                             primary-name)
            do (format t "~3&Recompiling ~S system:~2%" system)
               (asdf:load-system system
                                 :verbose verbose
                                 :force t))))
