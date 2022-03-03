#### Get packages ####
if (!require("pacman"))
  install.packages("pacman")
library(pacman)

pacman::p_load(tidyverse, alphahull, ragg, plotly)

#### Draw Koch snowflake ####
### Generate list of vertices ###
vertices <- koch(side = 2,
                 niter = 5) %>%
  as_tibble()

vertices <- rbind(vertices,
                  head(vertices, 1))

### Draw convex hull (shape bound by vertices) ###
plot <- ggplot(vertices,
               aes(x = `V1`, y = `V2`)) +
  geom_point(size = 0.5) +
  geom_path() +
  theme_bw() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(), ) +
  coord_fixed(ratio = 1)

ggplotly(plot)
