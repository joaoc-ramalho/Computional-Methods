library("vegan")
library("FD")
library("ape")
library("phytools")


####### Data loading
cestes_files <- list.files(path = "data/raw/cestes",
                           pattern = "csv$",
                           full.names = TRUE)

cestes_names <- gsub(".csv", "", basename(cestes_files), fixed = TRUE)
names(cestes_files) <- cestes_names
data_list <- lapply(cestes_files, read.csv)

comm <- data_list$comm
splits <- data_list$splist
traits <- data_list$traits

################

# Understanding the data
head(comm)[,1:6]
head(traits)[,1:6]
rownames(comm)[1:6]

# Organizing our data by putting the sites names as the rownames
# (making our data tydi)

rownames(comm) <- paste0("Site", comm[,1])
comm <- comm[,-1] # removing the first collimn
head(comm)[,1:6]

# Making the same for trais

rownames(traits) <- traits$Sp
traits <- traits[,-1]
head(traits)

###########

# Calculating species richness using vegan package
library(vegan)
richness <- vegan::specnumber(comm)
head(richness)


# Calculating taxonomic diversity, also with vegan
shannon <- diversity(comm)
simpson <- diversity(comm, index = "simpson")


library(cluster)
library(FD)
gow <- cluster::daisy(traits, metric = "gower")
gow2 <- FD::gowdis(traits)
#implementations in R vary and the literature reports extensions and modifications
identical(gow, gow2) #not the same but why?


class(gow) #different classes


class(gow2)


plot(gow, gow2, asp = 1) #same values
###################

#install.packages(SYNCSA)
library(SYNCSA)
tax <- rao.diversity(comm)
fun <- rao.diversity(comm, traits = traits)
#plot(fun$Simpson,fun$FunRao, pch = 19, asp = 1)
#abline(a = 0, b = 1)

###################

library(FD)
#we can use the distance matrix to calculate functional diversity indices
FuncDiv1 <- dbFD(x = gow, a = comm, messages = F)
#the returned object has Villéger's indices and Rao calculation
names(FuncDiv1)

install.packages("taxize")
library(taxize)
classification_data <-  classification(splits$TaxonName, db = "ncbi")

library(dplyr)
tible_ex <- classification_data[[1]] %>%
  filter(rank == "family") %>%
  select(name)
