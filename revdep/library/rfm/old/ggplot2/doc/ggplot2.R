## -----------------------------------------------------------------------------
#| label: cake
#| echo: false
#| fig.alt: "Scatterplot of city versus highway miles per gallon, for many cars
#|  coloured by engine displacement. The plot has six panels in a 2-row, 
#|  3-column layout, showing the combinations of three types of drive train and
#|  year of manifacture. Every panel has an individual trendline."
library(ggplot2)
ggplot(mpg, aes(cty, hwy)) +
  geom_point(aes(colour = displ)) +
  geom_smooth(formula = y ~ x, method = "lm") +
  scale_colour_viridis_c() +
  facet_grid(year ~ drv) +
  coord_fixed() +
  theme_minimal() +
  theme(panel.grid.minor = element_blank())


## -----------------------------------------------------------------------------
#| label: overview_graphic
#| echo: false
#| fig.alt: "A schematic displaying seven overlaying rhombuses indicating the
#|  different composable parts. From bottom to top, the labels read 'Data', 
#|  'Mapping', 'Layers', 'Scales', 'Facets', 'Coordinates' and 'Theme'."
n <- 7
x <- outer(c(-2, 0, 2, 0), rep(1, n))
y <- outer(c(0, 1, 0, -1), seq(0, 2.309, length.out = n), FUN = `+`)

df <- data.frame(
  x = as.vector(x),
  y = as.vector(y),
  group = as.vector(col(x))
)

ggplot(df, aes(x, y, group = group, fill = factor(group))) +
  geom_polygon(alpha = 0.9) +
  coord_equal() +
  scale_y_continuous(
    breaks = seq(0, 2.309, length.out = n),
    labels = c("Data", "Mapping", "Layers", "Scales",
               "Facets", "Coordinates", "Theme")
  ) +
  scale_fill_manual(
    values = c("#E69F00", "#56B4E9", "#009E73", "#F0E442",
               "#0072B2", "#D55E00", "#CC79A7"),
    guide = "none"
  ) +
  theme_void() +
  theme(axis.text.y = element_text(face = "bold", hjust = 1))



## -----------------------------------------------------------------------------
#| label: example_data
#| fig-show: hide
ggplot(data = mpg)


## -----------------------------------------------------------------------------
#| label: example_mapping
#| fig-show: hide
ggplot(mpg, mapping = aes(x = cty, y = hwy))


## -----------------------------------------------------------------------------
#| label: example_layer
#| fig-show: hold
#| fig.alt: "A scatterplot showing city versus highway miles per gallon for 
#|  many cars. The plot has a blue trendline with a positive slope."
ggplot(mpg, aes(cty, hwy)) +
  # to create a scatterplot
  geom_point() +
  # to fit and overlay a loess trendline
  geom_smooth(formula = y ~ x, method = "lm")


## -----------------------------------------------------------------------------
#| label: example_scales
#| fig.alt: "A scatterplot showing city versus highway miles per gallon for 
#|  many cars. The points are coloured according to seven classes of cars."
ggplot(mpg, aes(cty, hwy, colour = class)) +
  geom_point() +
  scale_colour_viridis_d()


## -----------------------------------------------------------------------------
#| label: example_facets
#| fig.alt: "Scatterplot of city versus highway miles per gallon, for many cars.
#|  The plot has six panels in a 2-row, 3-column layout, showing the 
#|  combinations of three types of drive train and year of manifacture."
ggplot(mpg, aes(cty, hwy)) +
  geom_point() +
  facet_grid(year ~ drv)


## -----------------------------------------------------------------------------
#| label: example_coords
#| fig.alt: "A scatterplot showing city versus highway miles per gallon for 
#|  many cars. The aspect ratio of the plot is such that units on the x-axis
#|  have the same length as units on the y-axis."
ggplot(mpg, aes(cty, hwy)) +
  geom_point() +
  coord_fixed()


## -----------------------------------------------------------------------------
#| label: example_theme
#| fig.alt: "A scatterplot showing city versus highway miles per gallon for 
#|  many cars. The points are coloured according to seven classes of cars. The
#|  legend of the colour is displayed on top of the plot. The plot has thick
#|  axis lines and the bottom axis line is blue."
ggplot(mpg, aes(cty, hwy, colour = class)) +
  geom_point() +
  theme_minimal() +
  theme(
    legend.position = "top",
    axis.line = element_line(linewidth = 0.75),
    axis.line.x.bottom = element_line(colour = "blue")
  )


## -----------------------------------------------------------------------------
#| label: outro
#| fig.alt: "Scatterplot of city versus highway miles per gallon, for many cars
#|  coloured by engine displacement. The plot has six panels in a 2-row, 
#|  3-column layout, showing the combinations of three types of drive train and
#|  year of manifacture. Every panel has an individual trendline."
ggplot(mpg, aes(cty, hwy)) +
  geom_point(mapping = aes(colour = displ)) +
  geom_smooth(formula = y ~ x, method = "lm") +
  scale_colour_viridis_c() +
  facet_grid(year ~ drv) +
  coord_fixed() +
  theme_minimal() +
  theme(panel.grid.minor = element_blank())

