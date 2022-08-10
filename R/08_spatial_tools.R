library("sf")
library("ggplot2")
library("tmap")
library(dplyr)

data(World)

# package tmap has a syntax similar to ggplot. We can just write things down
# the main plot command to add things in the plot

tm_shape(World) +
  tm_borders()

# Data examination:
names(World)
class(World)
dplyr::glimpse(World)

# We can plot by any classification
#Ex:1
#Like the fourth collumn of Wordl is the continent classification of each country,
#if we plot World[4] we will see the map devided by continents
plot(World[4])

#Ex2
plot(World[1,])

#Ex3
plot(World["pop_est"])

#A key difference between data frames and sf objects is the presence of geometry,
#that looks like a column when printing the summary of any sf object
head(World[, 1:4])


# creating a filtered plot

#Ex1
World %>%
  filter(World$continent == "South America") %>%
  tm_shape() +
  tm_borders()

#Ex2
World %>%
  mutate(our_countries = if_else(iso_a3 %in% c("COL","BRA", "MEX"), "red", "grey")) %>%
  tm_shape() +
  tm_borders() +
  tm_fill(col = "our_countries") +
  tm_add_legend("fill",
                "Countries",
                col = "red")

###########

install.packages("rnaturalearth")
install.packages("remotes")
remotes::install_github("ropensci/rnaturalearthhires")
library(rnaturalearth)
library(rnaturalearthhires)
bra <- ne_states(country = "brazil", returnclass = "sf")
plot(bra)


####
dir.create("data/shapefiles", recursive = TRUE)
st_write(obj = bra, dsn = "data/shapefiles/bra.shp", delete_layer = TRUE)

bra2 <- read_sf("data/shapefiles/bra.shp")
class(bra)
class(bra2)

plot(bra2)


library(raster)
dir.create(path = "data/raster/", recursive = TRUE)
tmax_data <- getData(name = "worldclim", var = "tmax", res = 10, path = "data/raster/")
plot(tmax_data)

is(tmax_data) #the data are a raster stack, several rasters piled


