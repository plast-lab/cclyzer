;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((c++-mode
  (flycheck-checker . c/c++-gcc)
  (flycheck-gcc-language-standard . "c++11")
  (eval . (setq include-paths (list "../include"
                                    (replace-regexp-in-string
                                     "\n$" ""
                                     (shell-command-to-string
                                      "llvm-config --includedir")))
                flycheck-gcc-include-path include-paths
                company-clang-arguments (mapcar (lambda (p) (concat "-I" p))
                                                include-paths)))))
