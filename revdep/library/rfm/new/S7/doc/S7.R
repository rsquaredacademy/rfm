## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(S7)

## -----------------------------------------------------------------------------
Dog <- new_class("Dog", properties = list(
  name = class_character,
  age = class_numeric
))
Dog

## -----------------------------------------------------------------------------
lola <- Dog(name = "Lola", age = 11)
lola

## -----------------------------------------------------------------------------
lola@age <- 12
lola@age

## ----error = TRUE-------------------------------------------------------------
try({
lola@age <- "twelve"
})

## -----------------------------------------------------------------------------
S7_class(lola)

## -----------------------------------------------------------------------------
class(lola)

## -----------------------------------------------------------------------------
speak <- new_generic("speak", "x")

## -----------------------------------------------------------------------------
method(speak, Dog) <- function(x) {
  "Woof"
}

## -----------------------------------------------------------------------------
speak(lola)

## -----------------------------------------------------------------------------
Cat <- new_class("Cat", properties = list(
  name = class_character,
  age = class_double
))
method(speak, Cat) <- function(x) {
  "Meow"
}

fluffy <- Cat(name = "Fluffy", age = 5)
speak(fluffy)

## ----error = TRUE-------------------------------------------------------------
try({
speak(1)
})

## -----------------------------------------------------------------------------
Pet <- new_class("Pet",
  properties = list(
    name = class_character,
    age = class_numeric
  )
)

## -----------------------------------------------------------------------------
Cat <- new_class("Cat", parent = Pet)
Dog <- new_class("Dog", parent = Pet)

Cat
Dog

## -----------------------------------------------------------------------------
lola <- Dog(name = "Lola", age = 11)
fluffy <- Cat(name = "Fluffy", age = 5)

## -----------------------------------------------------------------------------
describe <- new_generic("describe", "x")
method(describe, Pet) <- function(x) {
  paste0(x@name, " is ", x@age, " years old")
}
describe(lola)
describe(fluffy)

method(describe, Dog) <- function(x) {
  paste0(x@name, " is a ", x@age, " year old dog")
}
describe(lola)
describe(fluffy)

## -----------------------------------------------------------------------------
method(describe, S7_object) <- function(x) {
  "An S7 object"
}

Cocktail <- new_class("Cocktail",
  properties = list(
    ingredients = class_character
  )
)
martini <- Cocktail(ingredients = c("gin", "vermouth"))
describe(martini)

## -----------------------------------------------------------------------------
describe

## -----------------------------------------------------------------------------
method(describe, Pet)

