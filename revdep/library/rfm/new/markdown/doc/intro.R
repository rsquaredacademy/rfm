## ----include=FALSE------------------------------------------------------------
options(width = 80)
knitr::opts_chunk$set(comment = '#>')

## ----smartypants, echo=FALSE, eval=isTRUE(l10n_info()[['UTF-8']])-------------
p = markdown:::pants[-(4:14)]
knitr::kable(t(as.matrix(p)), col.names = sprintf('`%s`', names(p)))

## ----collapse=TRUE------------------------------------------------------------
markdown::markdown_options()
# commonmark's arguments
opts = formals(commonmark::markdown_html)
opts = opts[setdiff(names(opts), c('text', 'extensions'))]
unlist(opts)
# commonmark's extensions
commonmark::list_extensions()

