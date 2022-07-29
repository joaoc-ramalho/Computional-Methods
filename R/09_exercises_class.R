##########################################
###################################
#    Exercises Class
####################################

data <- read.csv("data/raw/cestes/comm.csv")

View(data)

#Trying to find the most abundance species

ab <- apply(data, 2, sum)
head(sort(ab, decreasing = TRUE))


# ########Diversity per site

data$Sites <- NULL

# first we need to transform the matrix to binomial

non_zero <- function(a){
  ifelse(a>0, TRUE, FALSE)
}

#Checking the function
non_zero(1)
non_zero(0)
num <- c(1:10)
non_zero(num)
# aplying the function
ab_site <- apply(data, 2, non_zero)
#suming the rows
sort(apply(ab_site, 1, sum), decreasing = TRUE)
richness <- rowSums(ab_site)
richness

#####-------- Shannon diversity



shanno_mul <- function(x){
  H = x * log(x)
  return(H)
}

sh_table <- apply(data, 2, shanno_mul)
shann_div_index <- rowSums(sh_table, na.rm = TRUE)
names(shann_div_index) <- paste("site", 1:97)
