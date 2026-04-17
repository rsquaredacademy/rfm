## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(S7)

## -----------------------------------------------------------------------------
Range <- new_class("Range",
  properties = list(
    start = class_double,
    end = class_double
  ),
  validator = function(self) {
    if (length(self@start) != 1) {
      "@start must be length 1"
    } else if (length(self@end) != 1) {
      "@end must be length 1"
    } else if (self@end < self@start) {
      sprintf(
        "@end (%i) must be greater than or equal to @start (%i)",
        self@end,
        self@start
      )
    }
  }
)

## ----error = TRUE-------------------------------------------------------------
try({
x <- Range(1, 2:3)
x <- Range(10, 1)

x <- Range(1, 10)
x@start <- 20
})

## ----error = TRUE-------------------------------------------------------------
try({
x <- Range(1, 2)
attr(x, "start") <- 3
validate(x)
})

## -----------------------------------------------------------------------------
shift <- function(x, shift) {
  x@start <- x@start + shift
  x@end <- x@end + shift
  x
}
shift(Range(1, 10), 1)

## ----error = TRUE-------------------------------------------------------------
try({
shift(Range(1, 10), 10)
})

## -----------------------------------------------------------------------------
shift <- function(x, shift) {
  props(x) <- list(
    start = x@start + shift,
    end = x@end + shift
  )
  x
}
shift(Range(1, 10), 10)

## -----------------------------------------------------------------------------
Range <- new_class("Range",
  properties = list(
    start = new_property(class_double),
    end = new_property(class_double)
  )
)

## ----error = TRUE-------------------------------------------------------------
try({
prop_number <- new_property(
  class = class_double,
  validator = function(value) {
    if (length(value) != 1L) "must be length 1"
  }
)

Range <- new_class("Range",
  properties = list(
    start = prop_number,
    end = prop_number
  ),
  validator = function(self) {
    if (self@end < self@start) {
      sprintf(
        "@end (%i) must be greater than or equal to @start (%i)",
        self@end,
        self@start
      )
    }
  }
)

Range(start = c(1.5, 3.5))
Range(end = c(1.5, 3.5))
})

## -----------------------------------------------------------------------------
Empty <- new_class("Empty",
  properties = list(
    x = class_double,
    y = class_character,
    z = class_logical
  ))
Empty()

## -----------------------------------------------------------------------------
Empty <- new_class("Empty",
  properties = list(
    x = new_property(class_numeric, default = 0),
    y = new_property(class_character, default = ""),
    z = new_property(class_logical, default = NA)
  )
)
Empty()

## -----------------------------------------------------------------------------
Stopwatch <- new_class("Stopwatch", properties = list(
  start_time = new_property(
    class = class_POSIXct,
    default = quote(Sys.time())
  ),
  elapsed = new_property(
    getter = function(self) {
      difftime(Sys.time(), self@start_time, units = "secs")
    }
  )
))
args(Stopwatch)
round(Stopwatch()@elapsed)
round(Stopwatch(Sys.time() - 1)@elapsed)

## -----------------------------------------------------------------------------
Range <- new_class("Range",
  properties = list(
    start = class_double,
    end = class_double,
    length = new_property(
      getter = function(self) self@end - self@start
    )
  )
)

x <- Range(start = 1, end = 10)
x

## ----error = TRUE-------------------------------------------------------------
try({
x@length <- 20
})

## -----------------------------------------------------------------------------
Range <- new_class("Range",
  properties = list(
    start = class_double,
    end = class_double,
    length = new_property(
      class = class_double,
      getter = function(self) self@end - self@start,
      setter = function(self, value) {
        if (!length(value)) {
          # Do nothing if called with the constructor default
          # value for this property, a zero-length double vector.
          return(self)
        }
        self@end <- self@start + value
        self
      }
    )
  )
)

x <- Range(start = 1, end = 10)
x

x@length <- 5
x

## -----------------------------------------------------------------------------
Person <- new_class("Person", properties = list(
 first_name = class_character,
 firstName = new_property(
    class_character,
    default = quote(first_name),
    getter = function(self) {
      warning("@firstName is deprecated; please use @first_name instead", call. = FALSE)
      self@first_name
    },
    setter = function(self, value) {
      if (identical(value, self@first_name)) {
        return(self)
      }
      warning("@firstName is deprecated; please use @first_name instead", call. = FALSE)
      self@first_name <- value
      self
    }
  )
))

args(Person)

hadley <- Person(firstName = "Hadley")

hadley <- Person(first_name = "Hadley") # no warning

hadley@firstName

hadley@firstName <- "John"

hadley@first_name  # no warning

## -----------------------------------------------------------------------------
Person <- new_class("Person", properties = list(
 name = new_property(
   class_character,
   validator = function(value) {
     if (length(value) != 1 || is.na(value) || value == "")
       "must be a non-empty string"
   }
 )
))

try(Person())

try(Person(1)) # class_character$validator() is also checked.

Person("Alice")

## -----------------------------------------------------------------------------
Person <- new_class("Person", properties = list(
 name = new_property(
   class_character,
   default = quote(stop("@name is required")))
))

try(Person())

Person("Alice")

## -----------------------------------------------------------------------------
Person <- new_class("Person", properties = list(
 birth_date = new_property(
   class_Date,
   setter = function(self, value) {
     if(!is.null(self@birth_date)) {
       stop("@birth_date is read-only", call. = FALSE)
     }
     self@birth_date <- as.Date(value)
     self
   }
)))

person <- Person("1999-12-31")

try(person@birth_date <- "2000-01-01")

## -----------------------------------------------------------------------------
Range@constructor

## -----------------------------------------------------------------------------
Range <- new_class("Range",
  properties = list(
    start = class_numeric,
    end = class_numeric
  ),
  constructor = function(x) {
    new_object(S7_object(),
               start = min(x, na.rm = TRUE),
               end = max(x, na.rm = TRUE))
  }
)

Range(c(10, 5, 0, 2, 5, 7))

