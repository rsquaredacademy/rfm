## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  gganimate = list(
    nframes = 50,
    width = 1000,
    height = 650,
    units = "px",
    res = 144
  ),
  out.width = '100%'
)

## -----------------------------------------------------------------------------
library(gganimate)

# We'll start with a static plot
p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point()

plot(p)

## -----------------------------------------------------------------------------
anim <- p +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

anim

## -----------------------------------------------------------------------------
anim +
  ease_aes('cubic-in-out') # Slow start and end for a smoother look

## -----------------------------------------------------------------------------
anim +
  ease_aes(y = 'bounce-out') # Sets special ease for y aesthetic

## -----------------------------------------------------------------------------
anim +
  ggtitle('Now showing {closest_state}',
          subtitle = 'Frame {frame} of {nframes}')

## -----------------------------------------------------------------------------
ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_line(aes(group = rep(1:50, 3)), colour = 'grey') +
  geom_point()

## -----------------------------------------------------------------------------
ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(aes(colour = Species)) +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

## -----------------------------------------------------------------------------
ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(aes(group = seq_along(Species))) +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

## -----------------------------------------------------------------------------
ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(aes(colour = Species, group = 1L)) +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

## -----------------------------------------------------------------------------
anim <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(aes(colour = Species), size = 2) +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

anim +
  enter_fade() +
  exit_shrink()

## -----------------------------------------------------------------------------
anim +
  enter_fade() + enter_drift(x_mod = -1) +
  exit_shrink() + exit_drift(x_mod = 5)

## ----eval=requireNamespace('av', quietly = TRUE)------------------------------
# Video output
animate(
  anim + enter_fade() + exit_fly(y_loc = 1),
  renderer = av_renderer()
)

## ----out.width=NULL-----------------------------------------------------------
# Different size and resolution
animate(
  anim + ease_aes(x = 'bounce-out') + enter_fly(x_loc = -1) + exit_fade(),
  width = 400, height = 600, res = 35
)

