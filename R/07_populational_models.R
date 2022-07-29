###############################################################################
###############################################################################

#### Populational models

library(ggplot2)
library(deSolve)
library(tidyr)

#ECOLOGY MODELS

#----------------------Creating a function for logistic growth
source("./fuctions/logGrowth.R")


# named vector with parameters
p <- c(r = 1, a = 0.001)
# initial condition
y0 <- c(N = 10)
# time steps
t <- seq(1, 200, 0.1)

# give the function and the parameters to the ode function
out_log <- ode(y = y0, times = t, func = logGrowth, parms = p)

head(out_log)

df_log <-  as.data.frame(out_log)

df_log <- as.data.frame(out_log)
ggplot(df_log) +
  geom_line(aes(x = time, y = N)) +
  theme_classic()


# --------- Lotka - Voolterra competition model

LVComp <- function(t, y, p) {
  N <- y
  with(as.list(p), {
    dN1.dt <- r[1] * N[1] * (1 - a[1, 1] * N[1] - a[1, 2] * N[2])
    dN2.dt <- r[2] * N[2] * (1 - a[2, 1] * N[1] - a[2, 2] * N[2])
    return(list(c(dN1.dt, dN2.dt)))
  })
}
# LV parameters
a <- matrix(c(0.02, 0.01, 0.01, 0.03), nrow = 2)
r <- c(1, 1)
p2 <- list(r, a)
N0 <- c(10, 10)
t2 <- seq(1, 50, 0.1)

out_lv <- ode(y = N0, times = t2, func = LVComp, parms = p2)
head(out_lv)

#we have to convert out data in a format in which every variable is represented
# in a column and every observation is represented in a row. We will use the
#function pivot_longer() from the package tidyr.

df_lv <- pivot_longer(as.data.frame(out_lv), cols = 2:3)

ggplot(df_lv) +
  geom_line(aes(x = time, y = value, color = name)) +
  labs(x = "Time", y = "N", color = "Species") +
  theme_classic()



# NON-ECOLOGY MODELS

library(dplyr)
library(ggplot2)
library(lubridate)
library(zoo)

covid <- read.csv("data/raw/covid19-dd7bc8e57412439098d9b25129ae6f35.csv")

# First checking the class
class(covid$date)

# Changing to date format
covid$date <- as_date(covid$date)
# Checking the class
class(covid$date)

# Now we can make numeric operations
range(covid$date)

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal()

# when loading the name of the full data base as the argument in ggplot(), like
# ggplot(data), when using the aes() we can just tell which column of our data
#base we want to be in each axis, like aes(x = colum_name, y = column_name)

# the graph showed to us negative confirmed new cases, inidicatind errors in our
#data base. To correct thet, we will turn every negative observation of
#"new_confirmed" column in zero
covid$new_confirmed[covid$new_confirmed < 0] <- 0

#and then trying to plot again
ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  labs(x = "Date", y = "New cases")

# Calculating the Rolling Mean

covid$roll_mean <- zoo::rollmean(covid$new_confirmed, 14, fill = NA)

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed), col = "black") +
  # col dentro do aes() separa as cores por grupo. Para só pintas deve-se colocar fora
  geom_line(aes(x = date, y = roll_mean), col = "red", size = 1.2) +
  theme_minimal() +
  labs(x = "Date", y = "New cases")

----- Why it isnt woking?
