# Scientific programming course ICTP-Serrapilheira July-2022
# Class #01: Introduction to R
# Introdutory script to play with R data types

# See where you are working at
getwd()

# Setting your working area ----------------------------------------------------

# When using R, we should not set our workspace using just "setwd()" function.It
# makes our scripts less organized and more difficult to reproduct.

# When doing that we should first use the "setwd()" to get on where we whant to
# code but, after that, we should create a "Project", using the arrow signal
# in the right superior area, right above the environment window.
# After creating the project we will no more need to use "setwd()", just change
# the current project in the same butom that we created it and this will lead us
# to the directory where the project is.

# The project should be created in the same file that is our data


# Exploring R ------------------------------------------------------------------
sqrt(10)
round(3.14159)
args(round)

# We uses "?" to get help about something
?round

print("Hi!")
print("Hello, world!")


## ----datatypes----------------------------------------------------------------
animals  <- c("mouse", "rat", "dog", "cat")
weight_g <- c(50, 60, 65, 82)


## ----class1-------------------------------------------------------------------
class(animals)


## ----class2-------------------------------------------------------------------
class(weight_g)


## ---- vectors-----------------------------------------------------------------
animals
animals[2]
# Indexation of R starts counting by one.It means that, if you type "X[2]" in
# your console, it will give you the exactly second character of this vector


## ----subset-------------------------------------------------------------------
animals[c(3, 2)]

# The output will follow the order determined by the concatenated vector


## ----subset-logical-----------------------------------------------------------

#we can change data of an already existent vector by combining the concatenate
# function and the typical arrow " <- "
weight_g <- c(21, 34, 39, 54)

# To aggregate data in an already existent vector, we use the "cbind()" function

weight_s <- cbind(weight_g, c(65, 67, 90, 21))


# We can select the data also based in logical operators. An operation that will
# return TRUE make its corespondent charcter to be printed
weight_g[c(TRUE, FALSE, FALSE, TRUE)]

# An application of this:
weight_g[weight_g > 35]


# the "[]" will always be used to subset an vector, matrix or data.frame


## ----recycling----------------------------------------------------------------
more_animals <- c("rat", "cat", "dog", "duck", "goat")
animals %in% more_animals
# the "%in%" function means "which of A is inside of B" (A%in%B), which returns
# logical outputs (TRUE if the character of A is inside B and FALSE if not)

animals[animals %in% more_animals]
# When putting this into "[]" after my vector, it will return the the characters
# corresponding to TRUE output. In another words, it will print the characters
# that are actually inside the "A"


## subset with grep ------------------------------------------------------------

#the grepl function helps select regular expressions/structures
grepl("^d", more_animals)
#the "^" symbol stands for "starts with"
# So, this code line will give us a logical output of which characters from
# "more_animals" starts with the letter "d"

# To see the exactly character we need to, again, put into in "[]" after our
# base vector
more_animals[grepl("^d", more_animals)]

#usind the "grep" function (same than before, but without the "l"), the output
# will be the indexs


## ----recycling2---------------------------------------------------------------
animals
more_animals
animals == more_animals
# Its always important to remember that one equal sine " = "stands for an
# affirmation, just like the arrow " <- ", but two equal sines " == " its a
# question if two objects "A == B" are equal, returning an logical output
# comparing each one of A to B by the same index (A[1] is compared to B[1], A[2]
# is compared to B[2], and that goes.


# To see what are in a vector that isn't in another, we use the "setdiff" function
# if you run setdiff(A, B) the output will what character that is in A that isn't
# in B

setdiff(animals, more_animals)


## ----na-----------------------------------------------------------------------
heights <- c(2, 4, 4, NA, 6)
mean(heights)
max(heights)
# none mathematical operation can be done with "NAs" in your data, so me need to
# remove. A lot of functions responds to "na.rm = TRUE" to do it (na remove)
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

# Data structures --------------------------------------------------------------

# Factor
animals
animals_cls <- factor(c("small", "medium", "medium", "large"))
# the factor type of date is broadly usage as a "list of qualifiers"
# A factor object can be examined by the "levels" function, which will show the
# different qualifiers that are inside this factor (whithout repeat)
levels(animals_cls)
levels(animals_cls) <- c("small", "medium", "large")
animals_cls

# Matrices

#before generate random numbers we should "set our seed". Thats a manner to make
# tell our computer "how to count", in a manner of allow that anyone could create
# the same random sequence if set the same seed.
set.seed(42)

# Now we are going to use a random uniform number generation, based on the
# function "runif()" to create our matrix data.

matrix(runif(20), ncol = 2)

matrix(nrow = 4, ncol = 3)

nums <- 1:12

# if we just use the "matrix()" function the data will be organized by column,
# which means that characters "A[1], A[2], A[3]..." will be putted one above the
# other until all the rows of the first column are completed, then the data go
# to next column
matrix(data = nums, nrow = 3)

# If you wanna organize your data by row, you just need to put "byrow = TRUE"
# as an argument of your matrix function

matrix(data = nums, nrow = 3, byrow = T)

# When dealing with matrixs, the organization will be always first rows and
# after columns

names_matrix <- list(c("row1", "row2", "row3"),
                     c("col1", "col2", "col3", "col4"))
names_matrix

matrix(data = nums, nrow = 3, byrow = T, dimnames = names_matrix)

m <- matrix(data = nums, nrow = 3, byrow = T, dimnames = names_matrix)


dim(m)
# The dimentions will be putted again in first rows and after columns

# dimnames function will show the rownames and colnames
dimnames(m)

df <- data.frame(m)
class(df)
class(m)


# Data frames
animals_df <- data.frame(name = animals,
                         weight = weight_g,
                         weight_class = animals_cls)


# The indexation in matrixs works a little bit different. If you put just one
# number in bracklets, it will return the hole column correspondent to that
# index
animals_df[2]
# in this case the output were the hole second column

# In the othr hand, when you put 2 numbers inside of "[]", you are telling to R
# that want the character occupying the index "A[row_x, column_y]"
animals_df[2, 1]

# The selection of data based on logical values still work on data frames
animals_df[animals_df$weight_class == "medium", ]
animals_df[animals_df$weight_class == "medium", "weight"]

# List
animals_list <- list(animals_df, animals)
animals_list[[1]]

# Importing data ---------------------------------------------------------------

# Reading data using read.csv
# if your data is the same file that your project, you don't need to tell the
# hole pathway that came before, just put a dot "." that will symbolize it.

surveys <- read.csv(file = "./data/raw/portal_data_joined.csv")

head(surveys)

# Reading data using read.table
# when using this, we need to specify the spacer of our data using "sep =" argument
# The best oprtion will always be "sep = "," "
surveys_check <- read.table(
  file = "./data/raw/portal_data_joined.csv",
  sep = ",",
  header = TRUE)
head(surveys_check)

# Checking if both files are equal
all(surveys == surveys_check)

# inspecting

# the "str()" function gives us an overview of data structure
str(surveys) #structure
dim(surveys)
nrow(surveys)
ncol(surveys)

head(surveys)
tail(surveys)

names(surveys)
rownames(surveys)
length(surveys)

# if you wanna select all columns of a determined number of rows, you just needs
# to put all rows you want inside of "[]", write an "," and let the columns
# space empty, like this:
sub <- surveys[1:10, ]
# The opposite can also be done
try <-  surveys[ ,1:12]

sub[1, 1]
sub[1, 6]

# Other way to select an especific data frame column than "A$column" is using
# A[["column]]
sub[["record_id"]]
sub$record_id

sub[1:3, 7]

sub[3, ]

# [row, columns]

surveys[ , 6]
surveys[1, ]
surveys[4, 13]

surveys[1:4, 1:3]

surveys[, -1]
nrow(surveys)
surveys[-(7:34786), ]
head(surveys)
surveys[-(7:nrow(surveys)), ]

surveys["species_id"]
surveys[["species_id"]]

da <- surveys["species_id"]

surveys[ ,"species_id"]
surveys$species_id

##
sub <- surveys[1:10,]
str(sub)

sub$hindfoot_length

sub$hindfoot_length == NA

is.na(sub$hindfoot_length)
!is.na(sub$hindfoot_length)

sub$hindfoot[!is.na(sub$hindfoot_length)]

mean(sub$hindfoot_length)
mean(sub$hindfoot_length, na.rm = T)

non_NA_w <- surveys[!is.na(surveys$weight),]
dim(non_NA_w)
dim(surveys)


non_NA <- surveys[!is.na(surveys$weight) &
                    !is.na(surveys$hindfoot_length), ]
dim(non_NA)

complete.cases(surveys)

surveys1 <- surveys[complete.cases(surveys) , ]
dim(surveys1)

surveys2 <- na.omit(surveys)
dim(surveys2)

if (!dir.exists("data/processed")) dir.create("data/processed")
write.csv(surveys1, "data/processed/01_surveys_mod.csv")
