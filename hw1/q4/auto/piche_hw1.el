(TeX-add-style-hook
 "piche_hw1"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "mathtools")
   (LaTeX-add-bibliographies
    "Untitled")))

