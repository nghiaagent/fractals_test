#### Get packages ####
if (!require("pacman"))
  install.packages("pacman")
library(pacman)

pacman::p_load(tidyverse, alphahull, ragg, plotly)

#### Draw Koch snowflake ####
### Generate background triangle ###
vertices_BG <- koch(side = 2,
                 niter = 1) %>%
  as_tibble()

vertices_BG <- rbind(vertices_BG,
                  head(vertices_BG, 1)) %>%
  mutate(type = "BG") %>%
  mutate(alpha = 0.4)

### Generate list of vertices ###
vertices <- koch(side = 2,
                 niter = 5) %>%
  as_tibble()

vertices <- rbind(vertices,
                  head(vertices, 1)) %>%
  mutate(type = "Koch") %>%
  mutate(alpha = 0.9) %>%
  rbind(vertices_BG)

### Draw convex hull (shape bound by vertices) ###
plot <- ggplot(vertices,
               aes(x = `V1`, 
                   y = `V2`,
                   color = type,
                   alpha = alpha)) +
  geom_point(size = 0.5) +
  geom_path() +
  theme_bw() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(), ) +
  coord_fixed(ratio = 1)

ggplotly(plot)
