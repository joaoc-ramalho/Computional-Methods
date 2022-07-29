###############################################################################
###############################################################################
###################### Biodiversity Database Class ###########################
########################### #2022 - 07 - 27 ###################################

install.packages("rgbif")
install.packages("Taxonstand")
install.packages("CoordinateCleaner")
install.packages("maps")

library(rgbif)
library(Taxonstand)
library(CoordinateCleaner)
library(maps)
library(dplyr)


#------------------------------Data Processing---------------------------------

# Setting the species tha we are intrested in
species <- "Myrsine coriacea"

# And then saving the data related to this species present in the occ_search in
# a object named "occs"
occs <- occ_search(scientificName = species, limit = 100000)

names(occs)



#The occurrences are saved in occs$data. Let’s create a new object from this table
myrsine.data <- occs$data



#Column names returned from gbif follow the DarwinCore standard -> an standard
#notation to biodiversity data
colnames(myrsine.data)



#Saving our data as a cvs in th raw data file
write.csv(myrsine.data,
          "data/raw/myrsine_data.csv",
          row.names = FALSE)



#Now, we can check the ordered unique Scientific Names present in this dataset
#The sort() will, by default, order by alphabetic order
sort(unique(myrsine.data$scientificName))


# The collumn "taxonomicStatus", will tell us if the species are corectedly named
# (ACCEPTED) or not (SYNONYM)
#Using the table() in this collumn will tell us how many accepted and how many
#synonym do we have
table(myrsine.data$taxonomicStatus)

# We can also check which names are acccepted or not, also using the table() func

table(myrsine.data$scientificName, myrsine.data$taxonomicStatus)


#Let’s use the function TPL() from package taxonstand to check if the taxonomic
#updates in the gbif data are correct. This function receives a vector containing
#a list of species and performs both orthographical and nomenclature checking

#We will first generate a list with unique species names and combine it to the
# data. This is preferable because we do not need to check more than once the
# same name and, in the case of working with several species, it will make the
# workflow faster.

#Generating the unique name vector
species.names <- unique(myrsine.data$scientificName)
dim(species.names)
#NULL dimensions because it is just a vector, not a matrix or data.frame
class(species.names)

# Now we need to check up this species scientific names
tax.check <- TPL(species.names)
View(tax.check)
# The TPL() function will analyse each species name for updated versions, author
#name and all this type of thing. So, this function adds several new variables
#to the input data and creates columns such as New.Genus and New.Species with
# the accepted name of the initial names that we give to the function.
#We should adopt these names if the column New.Taxonomic.status is filled with
#“Accepted”

# creating new object w/ original and new names after TPL
new.tax <- data.frame(scientificName = species.names,
                      genus.new.TPL = tax.check$New.Genus,
                      species.new.TPL = tax.check$New.Species,
                      status.TPL = tax.check$Taxonomic.status,
                      scientificName.new.TPL = paste(tax.check$New.Genus,
                                                     tax.check$New.Species))
# now we are merging raw data and checked data
myrsine.new.tax <- merge(myrsine.data, new.tax, by = "scientificName")


# Now we can save our new correct/updated data base:

write.csv(myrsine.new.tax,
          "data/processed/data_taxonomy_check.csv",
          row.names = FALSE)



#--------------------------------Data Plotting----------------------------------

# If we want to use the R built function "plot" to show the position of our
# species of interest, we can just cross the latitude and longitude data.
plot(decimalLatitude ~ decimalLongitude, data = myrsine.data, asp = 1)

# Nonetheless, doing that, we just see the dots out of nowhere. If we want to see
#then in the world map, we shoul use the map() function of maps package

plot(decimalLatitude ~ decimalLongitude, data = myrsine.data, asp = 1)
map(, , , add = TRUE)

# We are using ", , ," in the beggining to tell that we want to use the default
#form of the 3 firsts arguments. It could also be done by:

plot(decimalLatitude ~ decimalLongitude, data = myrsine.data, asp = 1)
map(add = TRUE)

#Now we will use the the function clean_coordinates() from the CoordinateCleaner
#package to clean the species records. This function checks for common errors in
#coordinates such as institutional coordinates, sea coordinates, outliers, zeros,
#centroids, etc.

#This function does not accept not available information (here addressed as “NA”)
#so we will first select only data that have a numerical value for both
# latitude and longitude

myrsine.coord <- myrsine.data[!is.na(myrsine.data$decimalLatitude)
                              & !is.na(myrsine.data$decimalLongitude),]
# Now that we dont have NAs, we can do the clenning

# output w/ only potential correct coordinates:
geo.clean <- clean_coordinates(x = myrsine.coord,
                               lon = "decimalLongitude",
                               lat = "decimalLatitude",
                               species = "species",
                               value = "clean")

#Ploting the clean data

par(mfrow = c(1, 2))
plot(decimalLatitude ~ decimalLongitude, data = myrsine.data, asp = 1)
map(, , , add = TRUE)
plot(decimalLatitude ~ decimalLongitude, data = geo.clean, asp = 1)
map(, , , add = TRUE)
par(mfrow = c(1, 1))


myrsine.new.geo <- clean_coordinates(x = myrsine.coord,
                                     lon = "decimalLongitude",
                                     lat = "decimalLatitude",
                                     species = "species",
                                     value = "spatialvalid")

# merging w/ original data
myrsine.new.geo2 <- merge(myrsine.data, myrsine.new.geo,
                          all.x = TRUE,
                          by = "key")


