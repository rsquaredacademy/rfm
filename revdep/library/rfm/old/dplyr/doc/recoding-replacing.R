## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(dplyr)

## -----------------------------------------------------------------------------
set.seed(123)
racers <- tibble(
  id = seq_len(100),
  time = round(sample(1200:2100, size = 100, replace = TRUE) / 60, 2)
)
racers

## -----------------------------------------------------------------------------
tiers <- racers |>
  mutate(
    tier = case_when(
      time < 23 ~ "A",
      time < 27 ~ "B",
      time < 30 ~ "C",
      time < 33 ~ "D"
    )
  )

tiers

## -----------------------------------------------------------------------------
racers |>
  mutate(
    tier = case_when(
      time < 23 ~ "A",
      time < 27 ~ "B",
      time < 30 ~ "C",
      time < 33 ~ "D",
      .default = "unknown"
    )
  )

## ----error = TRUE-------------------------------------------------------------
try({
racers |>
  mutate(
    tier = case_when(
      time < 23 ~ "A",
      time < 27 ~ "B",
      time < 30 ~ "C",
      time < 33 ~ "D",
      .unmatched = "error"
    )
  )
})

## -----------------------------------------------------------------------------
id_banned_shoes <- c(2, 10, 15, 32, 65)
id_false_start <- c(1, 2, 5, 20, 55, 74, 91)

## -----------------------------------------------------------------------------
racers |>
  mutate(
    time = case_when(
      id %in% id_banned_shoes ~ NA,
      id %in% id_false_start ~ time + 1 / 3,
      .default = time
    )
  )

## -----------------------------------------------------------------------------
racers |>
  mutate(time = if_else(id %in% id_banned_shoes, NA, time)) |>
  mutate(time = if_else(id %in% id_false_start, time + 1 / 3, time))

## -----------------------------------------------------------------------------
racers |>
  mutate(
    time = time |>
      replace_when(
        id %in% id_banned_shoes ~ NA,
        id %in% id_false_start ~ time + 1 / 3
      )
  )

## ----eval = FALSE-------------------------------------------------------------
# racers |>
#   mutate(time = base::replace(time, id %in% id_banned_shoes, NA)) |>
#   mutate(time = base::replace(time, id %in% id_false_start, time + 1 / 3))

## -----------------------------------------------------------------------------
racers |>
  mutate(time = base::replace(time, id %in% id_banned_shoes, NA)) |>
  mutate(time = {
    loc <- id %in% id_false_start
    base::replace(time, loc, time[loc] + 1 / 3)
  })

## -----------------------------------------------------------------------------
id_with_malfunction <- c(1, 5, 20, 50)

tiers <- racers |>
  mutate(
    tier = case_when(
      time < 23 ~ "A",
      time < 27 ~ "B",
      time < 30 ~ "C",
      time < 33 ~ "D",
      .default = "unknown"
    ) |>
      factor(levels = c("A", "B", "C", "D", "unknown"))
  )

tiers

## -----------------------------------------------------------------------------
tiers |>
  mutate(
    tier = case_when(id %in% id_with_malfunction ~ "unknown", .default = tier)
  )

## -----------------------------------------------------------------------------
tiers |>
  mutate(
    tier = tier |> replace_when(id %in% id_with_malfunction ~ "unknown")
  )

## -----------------------------------------------------------------------------
likert <- tibble(
  score = c(1, 2, 3, 4, 5, 2, 3, 1, 4)
)

## -----------------------------------------------------------------------------
likert |>
  mutate(
    score = case_when(
      score == 1 ~ "Strongly disagree",
      score == 2 ~ "Disagree",
      score == 3 ~ "Neutral",
      score == 4 ~ "Agree",
      score == 5 ~ "Strongly agree"
    )
  )

## -----------------------------------------------------------------------------
likert |>
  mutate(
    score = score |>
      recode_values(
        1 ~ "Strongly disagree",
        2 ~ "Disagree",
        3 ~ "Neutral",
        4 ~ "Agree",
        5 ~ "Strongly agree"
      )
  )

## -----------------------------------------------------------------------------
lookup <- tribble(
  ~from , ~to                 ,
      1 , "Strongly disagree" ,
      2 , "Disagree"          ,
      3 , "Neutral"           ,
      4 , "Agree"             ,
      5 , "Strongly agree"
)

## -----------------------------------------------------------------------------
likert |>
  mutate(score = recode_values(score, from = lookup$from, to = lookup$to))

## ----eval = FALSE-------------------------------------------------------------
# lookup <- readr::read_csv("lookup.csv")

## ----error = TRUE-------------------------------------------------------------
try({
likert <- tibble(
  score = c(0, 1, 2, 2, 4, 5, 2, 3, 1, 4)
)

# Missed the `0`
likert |>
  mutate(
    score = score |>
      recode_values(
        from = lookup$from,
        to = lookup$to,
        unmatched = "error"
      )
  )
})

## -----------------------------------------------------------------------------
schools <- tibble(
  name = c(
    "UNC",
    "Chapel Hill",
    NA,
    "Duke",
    "Duke University",
    "UNC",
    "NC State",
    "ECU"
  )
)

## -----------------------------------------------------------------------------
schools |>
  mutate(
    name = recode_values(
      name,
      c("UNC", "Chapel Hill") ~ "UNC Chapel Hill",
      c("Duke", "Duke University") ~ "Duke",
      default = name
    )
  )

## -----------------------------------------------------------------------------
schools |>
  mutate(
    name = name |>
      replace_values(
        c("UNC", "Chapel Hill") ~ "UNC Chapel Hill",
        c("Duke", "Duke University") ~ "Duke"
      )
  )

## -----------------------------------------------------------------------------
lookup <- tribble(
  ~from             , ~to               ,
  "UNC"             , "UNC Chapel Hill" ,
  "Chapel Hill"     , "UNC Chapel Hill" ,
  "Duke"            , "Duke"            ,
  "Duke University" , "Duke"
)

schools |>
  mutate(name = replace_values(name, from = lookup$from, to = lookup$to))

## -----------------------------------------------------------------------------
# Condensed lookup table with a `many:1` mapping per row
lookup <- tribble(
  ~from                        , ~to               ,
  c("UNC", "Chapel Hill")      , "UNC Chapel Hill" ,
  c("Duke", "Duke University") , "Duke"
)

# Note that `from` is a list column
lookup

lookup$from

# Works the same as before
schools |>
  mutate(name = replace_values(name, from = lookup$from, to = lookup$to))

## ----eval = FALSE-------------------------------------------------------------
# if_else(condition, true, false, missing)
# 
# case_when(
#   condition ~ true,
#   !condition ~ false,
#   is.na(condition) ~ missing
# )

## ----eval = FALSE-------------------------------------------------------------
# x <- if_else(x > 5, new, x)
# 
# # Type stable on `x`.
# # Intent of "partially updating" `x` is clear.
# # Pipe friendly.
# x <- x |> replace_when(x > 5 ~ new)

## -----------------------------------------------------------------------------
x <- c(1, 2, NA, 3, NA, 5)
y <- c(0, 3, 1, 4, 6, 7)

coalesce(x, 0)
replace_values(x, NA ~ 0)

coalesce(x, y)
replace_values(x, NA ~ y)

## -----------------------------------------------------------------------------
x <- c(1, 2, 0, -99, 12)

# To convert `0` and `-99` to `NA`, you have to do it in two calls
x |> na_if(0) |> na_if(-99)

x |> replace_values(from = c(0, -99), to = NA)

