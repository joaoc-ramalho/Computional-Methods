# Scientific programming course ICTP-Serrapilheira July-2022
# Class #03: Scientific workflows
# Reading raw data, writing processed data, functions of apply family, for loop, writing outputs: tables and figs

# Reading data -----------------------------------------------------------------


# Listing a list named "cestes_files" with all files that are under the path
#"data/raw/cestes" (the path its just from the file which the current project
# is, to the data), which finish with "csv", with theirs full names.
cestes_files <- list.files(path = "data/raw/cestes",
                           pattern = "csv$",
                           full.names = TRUE)


# gsub will change the pattern presented as a first argument to the second
# the third argument  is the data in which the function will work. In this
# case we are using the function "basename()", which will analyze all the
# names (paths) and keep just the part that differs each sample.
# take a look in the difference:
cestes_files
basename(cestes_files)
# fixed = TRUE" means that the fixation part, the dot".", will be changed too
cestes_names <- gsub(".csv", "", basename(cestes_files), fixed = TRUE)

# Just reading the "envir" excel(.csv) table
envir <- read.csv(cestes_files[3])

data_list <- lapply(cestes_files, read.csv)
##### Why to make a list?

## Putting the names that we created with gsub() as the list names
names(data_list) <- cestes_names

length(data_list)

# Inspecting data
head(data_list$envir)
dim(data_list$envir)
summary(envir$envir)



# Output 1: summary table ------------------------------------------------------

# Creating summary table for all environmental variables
sd(envir$Clay)


#aplying the mean function to each column (second argument = 2) except by the
# one (index -1)
envir_mean <- apply(envir[, -1], 2, mean)


#aplying the sd function to each column except by the one
envir_sd <- apply(envir[, -1], 2, sd)

# Creating a function in R -----------------------------------------------------

#Here we are creating a function to give us the standard error (standard
# deviation divided by the square root of the size of the samples) in which
# are acceptable the function round() as an argument [if (round) std <- round(std, ...)]
# the thre points "..." are telling to the std function to accept the arguments
# from round function

std <- function(x, round = FALSE, ...) {
  std <- sd(x) / sqrt(length(x))
  if (round) std <- round(std, ...)
  return(std)
}

#The "if (round) std <- round(std, ...)" means that, if the argument round is
#true, the std will be the round (std) - rounded std
--- Why to use return and not print?


std(envir$Clay, round = TRUE, digits = 2)

# When we are putting a function inside of a loop function, the arguments of
#the function to be aplied can be like this:

envir_std <- apply(envir[, -1], 2, std, round = TRUE, digits = 2)

#creating a data_frame with the variable names, mean rounded by two digits and
#standar error

envir_tbl <- data.frame(variable = names(envir_mean),
                        mean = round(envir_mean, 2),
                        std = envir_std, row.names = NULL)

# Writing summary table

if (!dir.exists("output/")) dir.create("output/", recursive = TRUE)
write.csv(envir_tbl,
          "output/02_envir_summary.csv", row.names = FALSE)

#That code basically says that if the directory "output/" do not exist:
# ["if(!dir.exists("output/")) -- remembering that "!" makes that what comes
# next means the opposite], its to create it [dir.create("output/", recursive = TRUE)]

# Then the next line are saving the data_frame "envir_tbl" we created.
# Thats being saved into a excel table (write.csv()), whith the name
# 02_envir_summary.csv", inside of the "output/" directory

---- Ask Sara about the result

# Output 2: figure -------------------------------------------------------------

# Species vs sites table
head(data_list$comm)

comm <- data_list$comm

head(comm)

# Sum of species abundances across sites

# As each column is an  specie and each number the the number of individuals we
# can find of each specie in each site, the sum by column will give us the total
#of individual per specie, and the sum by row will give us the sum of individuals
#per site
#we can do this two operations by two different forms:

# using a loop:
comm_sum <- apply(comm[, -1], 2, sum)
comm_row_sum <- apply(comm[, -1], 1, sum)

# Or usin the functions colSum() and rowSumm()
comm_sum <- colSums(comm[, -1])


# Plotting a species abundance curve
plot(sort(comm_sum, decreasing = TRUE), las = 1, bty = "l",
     xlab = "Species", ylab = "Abundance")
#Here we are first using the sort function to ordering the values of "comm_sum"
#by The biggest to the lower (decreasing = TRUE). Then we are putting this data
# as first argument of the "plot" function, meaning that this is the data in that
# function should work

---- Ask about x axis

de_comm_sum <- sort(comm_sum, decreasing = TRUE)
ggplot()+
  geom_point(aes(, de_comm_sum))
if(de_comm_sum[] == de_comm_sum[])
  equals <- sum(de_comm_sum)
# Exporting the figure
res <- 300
fig_size <- (res * 240) / 72

if (!dir.exists("figs")) dir.create("figs")
png("figs/02_species_abundance.png",
    res = res,
    height = fig_size,
    width = 1.5 * fig_size)
plot(sort(comm_sum, decreasing = TRUE), las = 1, bty = "l",
     xlab = "Species", ylab = "Abundance")
text(substitute(paste(italic("Bolboschoenus maritimus"))), x = 14, y = 126,
     cex = 0.8)
text(substitute(paste(italic("Phalaris coerulescens"))), x = 14, y = 80,
     cex = 0.8)
dev.off()

# for loop in R ----------------------------------------------------------------
comm_df <- as.data.frame(comm_sum)
comm_df$TaxonName <- NA
for (sp in rownames(comm_df)) {
  comm_df[sp, "TaxonName"] <- data_list$splist$TaxonName[data_list$splist$TaxCode == sp]
}
