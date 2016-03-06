;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((c++-mode
  (flycheck-checker . c/c++-gcc)
  (flycheck-gcc-language-standard . "c++11")
  (eval . (setq flycheck-gcc-include-path
                (list "../include"
                      (replace-regexp-in-string
                       "\n$" ""
                       (shell-command-to-string "llvm-config --includedir")))))))
