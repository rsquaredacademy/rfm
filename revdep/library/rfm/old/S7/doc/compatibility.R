## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(S7)

## -----------------------------------------------------------------------------
Foo <- new_class("Foo")
class(Foo())

mean.Foo <- function(x, ...) {
  "mean of foo"
}

mean(Foo())

## -----------------------------------------------------------------------------
rle <- function(x) {
  if (!is.vector(x) && !is.list(x)) {
    stop("'x' must be a vector of an atomic type")
  }
  n <- length(x)
  if (n == 0L) {
    new_rle(integer(), x)
  } else {
    y <- x[-1L] != x[-n]
    i <- c(which(y | is.na(y)), n)
    new_rle(diff(c(0L, i)), x[i])
  }
}
new_rle <- function(lengths, values) {
  structure(
    list(
      lengths = lengths,
      values = values
    ),
    class = "rle"
  )
}

## -----------------------------------------------------------------------------
new_rle <- new_class("rle",
  parent = class_list,
  constructor = function(lengths, values) {
    new_object(list(lengths = lengths, values = values))
  }
)
rle(1:10)

## -----------------------------------------------------------------------------
new_rle <- new_class("rle", properties = list(
  lengths = class_integer,
  values = class_atomic
))

## -----------------------------------------------------------------------------
method(`$`, new_rle) <- prop
rle(1:10)

## -----------------------------------------------------------------------------
Class1 <- new_class("Class1")
Class2 <- new_class("Class2")
Union1 <- new_union(Class1, Class2)

foo <- new_generic("foo", "x")
method(foo, Union1) <- function(x) ""
foo

