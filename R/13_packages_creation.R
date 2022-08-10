install.packages("devtools")
install.packages("usethis")
install.packages("available")
install.packages("roxygen2")

library(devtools)
library(usethis)
library(available)
library(roxygen2)

devtools::has_devel()

usethis::create_package("../foo")
#this command will create a full work space, with files to scripts
#gitignore,readme, a project...

usethis::use_mit_license()

# Then we can now create each script inside the "R" file as a functio
# and save it.
#to load the packae we can just use:
devtools::load_all()

#and now the functions inside the package are now free to be
#used
my_shannon(1)
my_shannon(c(1, 2, 3))

#-----------Creating the documentatio

#Open the file, put the cursor at the beginning of the file
#Go to the menu Code>Insert roxygen skeleton

# Documentation reference:
#-----#' @param x A vector with values of abundance in the community
#-----#' @return A numeric vector of length 1 with the value of the Shannon diversity
#-----#' @examples
      #' com <- c(1, 2, 3)
      #' my_shannon(com)
# After writing the documentatio we can assign it with the following function:
devtools::document()

#And then we can confirm if every thing is working right, by typing
?Function_name


# Checking if the function is workking well (by simulating CRAN check)
devtools::check()
