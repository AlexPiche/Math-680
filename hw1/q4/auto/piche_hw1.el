(TeX-add-style-hook
 "piche_hw1"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "scale=0.7")))
   (add-to-list 'LaTeX-verbatim-environments-local "alltt")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "mathtools"
    "hyperref"
    "geometry")
   (LaTeX-add-bibliographies
    "Untitled")))

