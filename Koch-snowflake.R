#### Get packages ####
if (!require("pacman"))
  install.packages("pacman")
library(pacman)

pacman::p_load(tidyverse, alphahull)

#### Draw Koch snowflake ####
### Generate list of vertices ###
vertices <- koch(side = 2,
                 niter = 3) %>%
  as_tibble()

vertices <- rbind(vertices,
                  head(vertices, 1))

### Draw convex hull (shape bound by vertices) ###
ggplot(vertices,
       aes(x = `V1`, y = `V2`)) +
  geom_point() +
  geom_path() +
  theme_bw() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),) +
  coord_fixed(ratio = 1)
