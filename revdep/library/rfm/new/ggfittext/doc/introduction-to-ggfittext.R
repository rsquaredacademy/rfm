## ----fig.width = 4, fig.height = 4--------------------------------------------
library(ggplot2)
library(ggfittext)
ggplot(animals, aes(x = type, y = flies, label = animal)) +
  geom_tile(fill = "white", colour = "black") +
  geom_fit_text()

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(animals, aes(x = type, y = flies, label = animal)) +
  geom_tile(fill = "white", colour = "black") +
  geom_fit_text(reflow = TRUE)

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(animals, aes(x = type, y = flies, label = animal)) +
  geom_tile(fill = "white", colour = "black") +
  geom_fit_text(reflow = TRUE, grow = TRUE)

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(animals, aes(x = type, y = flies, label = animal)) +
  geom_tile(fill = "white", colour = "black") +
  geom_fit_text(place = "topleft", reflow = TRUE)

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(altitudes, aes(x = craft, y = altitude, label = altitude)) +
  geom_col() +
  geom_bar_text()

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(beverages, aes(x = beverage, y = proportion, label = ingredient,
                    fill = ingredient)) +
  geom_col(position = "stack") +
  geom_bar_text(position = "stack", reflow = TRUE)

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(beverages, aes(x = beverage, y = proportion, label = ingredient,
                    fill = ingredient)) +
  geom_col(position = "dodge") +
  geom_bar_text(position = "dodge", grow = TRUE, reflow = TRUE, 
                place = "left") +
  coord_flip()

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(presidential, aes(ymin = start, ymax = end, x = party, label = name)) +
  geom_fit_text(grow = TRUE) +
  geom_errorbar(alpha = 0.5)

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(animals_rich, aes(x = type, y = flies, label = animal)) +
  geom_tile(fill = "white", colour = "black") +
  geom_fit_text(reflow = TRUE, grow = TRUE, rich = TRUE)

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(gold, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, 
                 fill = linenumber, label = line)) +
  coord_polar() +
  geom_rect() +
  geom_fit_text(min.size = 0, grow = TRUE) +
  scale_fill_gradient(low = "#fee391", high = "#238443")

## ----fig.width = 4, fig.height = 4--------------------------------------------
ggplot(animals, aes(x = type, y = flies, fill = mass, label = animal)) +
  geom_tile() +
  geom_fit_text(reflow = TRUE, grow = TRUE, contrast = TRUE)

## ----echo = FALSE, fig.width = 4, fig.height = 0.5----------------------------
ggplot(data.frame(label = "fullheight = TRUE", xmin = 0.25, xmax = 0.75, ymin = 0.25, ymax = 0.75), 
       aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, label = label)) +
  geom_rect() +
  geom_fit_text(grow = TRUE, fullheight = TRUE, family = "mono") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(), panel.background = element_blank(), plot.title = element_text(hjust = 0.5))

## ----echo = FALSE, fig.width = 4, fig.height = 0.5----------------------------
ggplot(data.frame(label = "fullheight = FALSE", xmin = 0.25, xmax = 0.75, ymin = 0.25, ymax = 0.75), 
       aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, label = label)) +
  geom_rect() +
  geom_fit_text(grow = TRUE, fullheight = FALSE, family = "mono") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(), panel.background = element_blank(), plot.title = element_text(hjust = 0.5))

