#### Get packages ####
if (!require("pacman")) install.packages("pacman")
library(pacman)

pacman::p_load(tidyverse, alphahull)
#### Define a stat for ggplot2 that draws convex hulls ####
StatChull <- ggproto("StatChull", Stat,
                     compute_group = function(data, scales) {
                       data[chull(data$x, data$y), , drop = FALSE]
                     },
                     required_aes = c("x", "y")
)

stat_chull <- function(mapping = NULL, data = NULL, geom = "polygon",
                       position = "identity", na.rm = FALSE, show.legend = NA, 
                       inherit.aes = TRUE, ...) {
  layer(
    stat = StatChull, data = data, mapping = mapping, geom = geom, 
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
#### Draw Koch snowflake ####
### Generate list of vertices ###
vertices <- koch(side = 2, niter = 3) %>%
  as_tibble()

vertices <- rbind(vertices,
            head(vertices, 1)
            )

### Draw convex hull (shape bound by vertices) ###
ggplot(vertices,
       aes(x = `V1`, y = `V2`)
       ) +
  geom_point() +
  geom_path() +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),) +
  coord_fixed(ratio = 1)
  