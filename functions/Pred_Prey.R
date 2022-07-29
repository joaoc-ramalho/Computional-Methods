###################
#####2022-07-22####
## Modeling species that, in early ages are mutulism and when older, are
# competitors

library(ggplot2)
library(deSolve)
library(tidyr)

# the diferential equation

pred_prey <- function(t, y, p){
  N <- y
  with(as.list(p), {
    dNdt <-  r*N[1] - c*N[1]*N[2]
    dPdt <-  b*N[1]*N[2] - m*N[2]
    return(list(c(dPdt, dNdt)))
  })
}



# named vector with parameters
p <- c(b = 3, m = 0.4, r = 1 , c = 2.5 )
# initial condition
y0 <- c(20, 2)

# time steps
t <- seq(1, 100, 0.1)



out_lv <- ode(y = y0, times = t, func = pred_prey, parms = p)
head(out_lv)

df_lv <- pivot_longer(as.data.frame(out_lv), cols = 2:3)

prey <- subset(df_lv, name == 1)
predator <-  subset(df_lv, name == 2)

ggplot() +
  geom_line(aes(x = predator$value, y = prey$value)) +
  labs(x = "Predator", y = "Prey") +
  theme_classic()


#----------------------------------

pred_prey2 <- function(t, y, p){
  N <- y
  with(as.list(p), {
    dudt <-  r*N[1]*(1-N[2])
    dvdt <-  m*N[2]*(N[1]-1)
    return(list(c(dudt, dvdt)))
  })
}

p <- c(r = 1.8 , m = 0.3)
y0 <- c(20, 2)
t <- seq(1, 100, 0.1)

out_lv <- ode(y0, times = t, func = pred_prey2, parms = p)
head(out_lv)

df_lv <- pivot_longer(as.data.frame(out_lv), cols = 2:3)
df_lv

prey <- subset(df_lv, name == 1)
predator <-  subset(df_lv, name == 2)

ggplot() +
  geom_line(aes(x = predator$value, y = prey$value)) +
  labs(x = "Predator", y = "Prey") +
  theme_classic()

