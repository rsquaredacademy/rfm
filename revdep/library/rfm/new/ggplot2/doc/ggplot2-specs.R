## -----------------------------------------------------------------------------
#| include: false
library(ggplot2)


## -----------------------------------------------------------------------------
munsell::mnsl("5PB 5/10")


## -----------------------------------------------------------------------------
#| fig.alt: "A series of 6 horizontal lines with different line types.
#|  From top-to-bottom they are titled 'solid', 'dashed', 'dotted',
#|  'dotdash', 'longdash', 'twodash'."
lty <- c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash")
linetypes <- data.frame(
  y = seq_along(lty),
  lty = lty
)
ggplot(linetypes, aes(0, y)) +
  geom_segment(aes(xend = 5, yend = y, linetype = lty)) +
  scale_linetype_identity() +
  geom_text(aes(label = lty), hjust = 0, nudge_y = 0.2) +
  scale_x_continuous(NULL, breaks = NULL) +
  scale_y_reverse(NULL, breaks = NULL)


## -----------------------------------------------------------------------------
#| fig.alt: "A series of 9 horizontal lines with different line types.
#|  Each line is titled by two hexadecimal digits that determined the
#|  lengths of dashes and gaps."
lty <- c("11", "18", "1f", "81", "88", "8f", "f1", "f8", "ff")
linetypes <- data.frame(
  y = seq_along(lty),
  lty = lty
)
ggplot(linetypes, aes(0, y)) +
  geom_segment(aes(xend = 5, yend = y, linetype = lty)) +
  scale_linetype_identity() +
  geom_text(aes(label = lty), hjust = 0, nudge_y = 0.2) +
  scale_x_continuous(NULL, breaks = NULL) +
  scale_y_reverse(NULL, breaks = NULL)


## -----------------------------------------------------------------------------
#| out-width: 30%
#| fig-show: hold
#| fig.alt:
#| - "A plot showing a line with an angle. A thinner red line is placed over
#|  a thicker black line. The black line ends where the red line ends."
#| - "A plot showing a line with an angle. A thinner red line is placed over
#|  a thicker black line. The black line ends past where the red line ends,
#|  and ends in a semicircle."
#| - "A plot showing a line with an angle. A thinner red line is placed over
#|  a thicker black line. The black line ends past where the red line ends,
#|  and ends in a square shape."
df <- data.frame(x = 1:3, y = c(4, 1, 9))
base <- ggplot(df, aes(x, y)) + xlim(0.5, 3.5) + ylim(0, 10)
base +
  geom_path(linewidth = 10) +
  geom_path(linewidth = 1, colour = "red")

base +
  geom_path(linewidth = 10, lineend = "round") +
  geom_path(linewidth = 1, colour = "red")

base +
  geom_path(linewidth = 10, lineend = "square") +
  geom_path(linewidth = 1, colour = "red")


## -----------------------------------------------------------------------------
#| out-width: 30%
#| fig-show: hold
#| fig.alt:
#| - "A plot showing a thin red line on top of a thick black line shaped like
#|  the letter 'V'. The corner in the black V-shape is rounded."
#| - "A plot showing a thin red line on top of a thick black line shaped like
#|  the letter 'V'. The corner in the black V-shape is sharp."
#| - "A plot showing a thin red line on top of a thick black line shaped like
#|  the letter 'V'. A piece of the corner is cut off so that the two
#|  straight parts are connected by a horizontal part."
df <- data.frame(x = 1:3, y = c(9, 1, 9))
base <- ggplot(df, aes(x, y)) + ylim(0, 10)
base +
  geom_path(linewidth = 10) +
  geom_path(linewidth = 1, colour = "red")

base +
  geom_path(linewidth = 10, linejoin = "mitre") +
  geom_path(linewidth = 1, colour = "red")

base +
  geom_path(linewidth = 10, linejoin = "bevel") +
  geom_path(linewidth = 1, colour = "red")


## -----------------------------------------------------------------------------
#| fig.alt: "A 5-by-5 grid of point symbols annotated by the numbers
#|  that can be used to represent the symbols. From left to right, the
#|  first 15 symbols are lines or open shapes, the next 5 symbols are solid
#|  shapes and the last 5 symbols are filled shaped."
shapes <- data.frame(
  shape = c(0:19, 22, 21, 24, 23, 20),
  x = 0:24 %/% 5,
  y = -(0:24 %% 5)
)
ggplot(shapes, aes(x, y)) +
  geom_point(aes(shape = shape), size = 5, fill = "red") +
  geom_text(aes(label = shape), hjust = 0, nudge_x = 0.15) +
  scale_shape_identity() +
  expand_limits(x = 4.1) +
  theme_void()


## -----------------------------------------------------------------------------
#| out-width: 90%
#| fig-asp: 0.4
#| fig-width: 8
#| fig.alt: "An irregular 6-by-7 grid of point symbols annotated by the
#|  names that can be used to represent the symbols. Broadly, from top to
#|  bottom, the symbols are circles, squares, diamonds, triangles and
#|  others. Broadly from left to right, the symbols are solid shapes,
#|  open shapes, filled shapes and others."
shape_names <- c(
  "circle", paste("circle", c("open", "filled", "cross", "plus", "small")), "bullet",
  "square", paste("square", c("open", "filled", "cross", "plus", "triangle")),
  "diamond", paste("diamond", c("open", "filled", "plus")),
  "triangle", paste("triangle", c("open", "filled", "square")),
  paste("triangle down", c("open", "filled")),
  "plus", "cross", "asterisk"
)

shapes <- data.frame(
  shape_names = shape_names,
  x = c(1:7, 1:6, 1:3, 5, 1:3, 6, 2:3, 1:3),
  y = -rep(1:6, c(7, 6, 4, 4, 2, 3))
)

ggplot(shapes, aes(x, y)) +
  geom_point(aes(shape = shape_names), fill = "red", size = 5) +
  geom_text(aes(label = shape_names), nudge_y = -0.3, size = 3.5) +
  scale_shape_identity() +
  theme_void()


## -----------------------------------------------------------------------------
#| fig.alt: "A plot showing a 4-by-4 grid of red points, the top 12 points with
#|  black outlines. The size of the points increases horizontally. The stroke of
#|  the outlines of the points increases vertically. A white diagonal line with
#|  a negative slope marks that the 'stroke' versus 'size' trade-off has
#|  similar total sizes."
sizes <- expand.grid(size = (0:3) * 2, stroke = (0:3) * 2)
ggplot(sizes, aes(size, stroke, size = size, stroke = stroke)) +
  geom_abline(slope = -1, intercept = 6, colour = "white", linewidth = 6) +
  geom_point(shape = 21, fill = "red") +
  scale_size_identity()


## -----------------------------------------------------------------------------
#| fig.alt: "A plot showing three text labels arranged vertically. The top
#|  label is 'sans' and is displayed in a sans-serif font. The middle label is
#|  'serif' and is displayed in a serif font. The bottom label is 'mono' and
#|  is displayed in a monospaced font."
df <- data.frame(x = 1, y = 3:1, family = c("sans", "serif", "mono"))
ggplot(df, aes(x, y)) +
  geom_text(aes(label = family, family = family))


## -----------------------------------------------------------------------------
#| fig.alt: "A plot showing four text labels arranged vertically. The top
#|  label is 'bold.italic' and is displayed in bold and italic. The next three
#|  labels are 'italic', 'bold' and 'plain' and are displayed in their
#|  respective styles."
df <- data.frame(x = 1:4, fontface = c("plain", "bold", "italic", "bold.italic"))
ggplot(df, aes(1, x)) +
  geom_text(aes(label = fontface, fontface = fontface))


## -----------------------------------------------------------------------------
#| fig.alt: "A 3-by-3 grid of text on top of points, with horizontal text
#|  justification increasing from 0 to 1 on the x-axis and vertical
#|  justification increasing from 0 to 1 on the y-axis. The points make it
#|  easier to see the relative placement of text."
just <- expand.grid(hjust = c(0, 0.5, 1), vjust = c(0, 0.5, 1))
just$label <- paste0(just$hjust, ", ", just$vjust)

ggplot(just, aes(hjust, vjust)) +
  geom_point(colour = "grey70", size = 5) +
  geom_text(aes(label = label, hjust = hjust, vjust = vjust))

