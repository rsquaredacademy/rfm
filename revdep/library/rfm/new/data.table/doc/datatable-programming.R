## ----echo=FALSE, file='_translation_links.R'------------------------------------------------------
# build a link list of alternative languages (may be character(0))
# idea is to look like 'Other languages: en | fr | de'
.write.translation.links <- function(fmt) {
    url = "https://rdatatable.gitlab.io/data.table/articles"
    path = dirname(knitr::current_input(TRUE))
    if (basename(path) == "vignettes") {
      lang = "en"
    } else {
      lang = basename(path)
      path = dirname(path)
    }
    translation = dir(path,
      recursive = TRUE,
      pattern = glob2rx(knitr::current_input(FALSE))
    )
    transl_lang = ifelse(dirname(translation) == ".", "en", dirname(translation))
    block = if (!all(transl_lang == lang)) {
      linked_transl = sprintf("[%s](%s)", transl_lang, file.path(url, sub("(?i)\\.Rmd$", ".html", translation)))
      linked_transl[transl_lang == lang] = lang
      sprintf(fmt, paste(linked_transl, collapse = " | "))
    } else ""
    knitr::asis_output(block)
}

## ----init, include = FALSE------------------------------------------------------------------------
require(data.table)
knitr::opts_chunk$set(
  comment = "#",
    error = FALSE,
     tidy = FALSE,
    cache = FALSE,
 collapse = TRUE
)

## ----df_print, echo=FALSE-------------------------------------------------------------------------
registerS3method("print", "data.frame", function(x, ...) {
  base::print.data.frame(head(x, 2L), ...)
  cat("...\n")
  invisible(x)
})
.opts = options(
  datatable.print.topn=2L,
  datatable.print.nrows=20L
)

## ----subset---------------------------------------------------------------------------------------
subset(iris, Species == "setosa")

## ----subset_nolazy--------------------------------------------------------------------------------
my_subset = function(data, col, val) {
  data[data[[col]] == val & !is.na(data[[col]]), ]
}
my_subset(iris, col = "Species", val = "setosa")

## ----subset_parse---------------------------------------------------------------------------------
my_subset = function(data, col, val) {
  data = deparse(substitute(data))
  col  = deparse(substitute(col))
  val  = paste0("'", val, "'")
  text = paste0("subset(", data, ", ", col, " == ", val, ")")
  eval(parse(text = text)[[1L]])
}
my_subset(iris, Species, "setosa")

## ----subset_substitute----------------------------------------------------------------------------
my_subset = function(data, col, val) {
  eval(substitute(subset(data, col == val)))
}
my_subset(iris, Species, "setosa")

## ----hypotenuse-----------------------------------------------------------------------------------
square = function(x) x^2
quote(
  sqrt(square(a) + square(b))
)

## ----hypotenuse_substitute2-----------------------------------------------------------------------
substitute2(
  outer(inner(var1) + inner(var2)),
  env = list(
    outer = "sqrt",
    inner = "square",
    var1 = "a",
    var2 = "b"
  )
)

## ----hypotenuse_datatable-------------------------------------------------------------------------
DT = as.data.table(iris)

str(
  DT[, outer(inner(var1) + inner(var2)),
     env = list(
       outer = "sqrt",
       inner = "square",
       var1 = "Sepal.Length",
       var2 = "Sepal.Width"
    )]
)

# return as a data.table
DT[, .(Species, var1, var2, out = outer(inner(var1) + inner(var2))),
   env = list(
     outer = "sqrt",
     inner = "square",
     var1 = "Sepal.Length",
     var2 = "Sepal.Width",
     out = "Sepal.Hypotenuse"
  )]

## ----hypotenuse_datatable_i_j_by------------------------------------------------------------------
DT[filter_col %in% filter_val,
   .(var1, var2, out = outer(inner(var1) + inner(var2))),
   by = by_col,
   env = list(
     outer = "sqrt",
     inner = "square",
     var1 = "Sepal.Length",
     var2 = "Sepal.Width",
     out = "Sepal.Hypotenuse",
     filter_col = "Species",
     filter_val = I(c("versicolor", "virginica")),
     by_col =  "Species"
  )]

## ----substitute_fun1, result='hide'---------------------------------------------------------------
DT[, outer(Sepal.Length), env = list(outer="sqrt"), verbose=TRUE]
#Argument 'j' after substitute: sqrt(Sepal.Length)
## DT[, sqrt(Sepal.Length)]

DT[, outer(Sepal.Length), env = list(outer=sqrt), verbose=TRUE]
#Argument 'j' after substitute: .Primitive("sqrt")(Sepal.Length)
## DT[, .Primitive("sqrt")(Sepal.Length)]

## ----substitute_fun2, result='hide'---------------------------------------------------------------
DT[, sqrt(Sepal.Length)]

## ----substitute_fun3, result='hide', eval=FALSE---------------------------------------------------
# DT[, ns::fun(Sepal.Length), env = list(ns="base", fun="sqrt"), verbose=TRUE]
# #Argument 'j' after substitute: base::sqrt(Sepal.Length)
# ## DT[, base::sqrt(Sepal.Length)]

## ----rank-----------------------------------------------------------------------------------------
substitute(    # base R behaviour
  rank(input, ties.method = ties),
  env = list(input = as.name("Sepal.Width"), ties = "first")
)

substitute2(   # mimicking base R's "substitute" using "I"
  rank(input, ties.method = ties),
  env = I(list(input = as.name("Sepal.Width"), ties = "first"))
)

substitute2(   # only particular elements of env are used "AsIs"
  rank(input, ties.method = ties),
  env = list(input = "Sepal.Width", ties = I("first"))
)

## ----substitute2_recursive------------------------------------------------------------------------
substitute2(   # all are symbols
  f(v1, v2),
  list(v1 = "a", v2 = list("b", list("c", "d")))
)
substitute2(   # 'a' and 'd' should stay as character
  f(v1, v2),
  list(v1 = I("a"), v2 = list("b", list("c", I("d"))))
)

## ----splice_sd------------------------------------------------------------------------------------
cols = c("Sepal.Length", "Sepal.Width")
DT[, .SD, .SDcols = cols]

## ----splice_tobe----------------------------------------------------------------------------------
DT[, list(Sepal.Length, Sepal.Width)]

## ----splice_datatable-----------------------------------------------------------------------------
# this works
DT[, j,
   env = list(j = as.list(cols)),
   verbose = TRUE]

# this will not work
#DT[, list(cols),
#   env = list(cols = cols)]

## ----splice_enlist--------------------------------------------------------------------------------
DT[, j,  # data.table automatically enlists nested lists into list calls
   env = list(j = as.list(cols)),
   verbose = TRUE]

DT[, j,  # turning the above 'j' list into a list call
   env = list(j = quote(list(Sepal.Length, Sepal.Width))),
   verbose = TRUE]

DT[, j,  # the same as above but accepts character vector
   env = list(j = as.call(c(quote(list), lapply(cols, as.name)))),
   verbose = TRUE]

## ----splice_substitute2_not-----------------------------------------------------------------------
str(substitute2(j, env = I(list(j = lapply(cols, as.name)))))

str(substitute2(j, env = list(j = as.list(cols))))

## ----complex--------------------------------------------------------------------------------------
outer = "sqrt"
inner = "square"
vars = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")

syms = lapply(vars, as.name)
to_inner_call = function(var, fun) call(fun, var)
inner_calls = lapply(syms, to_inner_call, inner)
print(inner_calls)

to_add_call = function(x, y) call("+", x, y)
add_calls = Reduce(to_add_call, inner_calls)
print(add_calls)

rms = substitute2(
  expr = outer((add_calls) / len),
  env = list(
    outer = outer,
    add_calls = add_calls,
    len = length(vars)
  )
)
print(rms)

str(
  DT[, j, env = list(j = rms)]
)

# same, but skipping last substitute2 call and using add_calls directly
str(
  DT[, outer((add_calls) / len),
     env = list(
       outer = outer,
       add_calls = add_calls,
       len = length(vars)
    )]
)

# return as data.table
j = substitute2(j, list(j = as.list(setNames(nm = c(vars, "Species", "rms")))))
j[["rms"]] = rms
print(j)
DT[, j, env = list(j = j)]

# alternatively
j = as.call(c(
  quote(list),
  lapply(setNames(nm = vars), as.name),
  list(Species = as.name("Species")),
  list(rms = rms)
))
print(j)
DT[, j, env = list(j = j)]

## ----obj_vs_objname-------------------------------------------------------------------------------
DT[, fun(Petal.Width), env = list(fun = mean), verbose=TRUE]
DT[, fun(Petal.Width), env = list(fun = "mean"), verbose=TRUE]

## ----env_se---------------------------------------------------------------------------------------
fun = function(x, col.mean) {
  stopifnot(is.character(col.mean), is.data.table(x))
  x[, .(col_avg = mean(.col)), env = list(.col = col.mean)]
}
fun(DT, col.mean="Petal.Length")

## ----env_nse--------------------------------------------------------------------------------------
fun = function(x, col.mean) {
  col.mean = substitute(col.mean)
  stopifnot(is.name(col.mean), is.data.table(x))
  x[, .(col_avg = mean(.col)), env = list(.col = col.mean)]
}
fun(DT, col.mean=Petal.Length)

## ----old_get--------------------------------------------------------------------------------------
v1 = "Petal.Width"
v2 = "Sepal.Width"

DT[, .(total = sum(get(v1), get(v2)))]

DT[, .(total = sum(v1, v2)),
   env = list(v1 = v1, v2 = v2)]

## ----old_mget-------------------------------------------------------------------------------------
v = c("Petal.Width", "Sepal.Width")

DT[, lapply(mget(v), mean)]

DT[, lapply(v, mean),
   env = list(v = as.list(v))]

DT[, lapply(v, mean),
   env = list(v = as.list(setNames(nm = v)))]

## ----old_eval-------------------------------------------------------------------------------------
cl = quote(
  .(Petal.Width = mean(Petal.Width), Sepal.Width = mean(Sepal.Width))
)

DT[, eval(cl)]

DT[, cl, env = list(cl = cl)]

## ----cleanup, echo=FALSE--------------------------------------------------------------------------
options(.opts)
registerS3method("print", "data.frame", base::print.data.frame)

