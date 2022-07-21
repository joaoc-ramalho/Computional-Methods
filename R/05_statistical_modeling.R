# --------------------------------------------------#
# Scientific computing
# ICTP/Serrapilheira 2022
# Script to fit linear model in R
# First version 2022-07-18
# --------------------------------------------------#

# loading packages
library(ggplot2)

# reading data
cat <- read.csv("data/raw/crawley_regression.csv")

# Do leaf chemical compounds affect the growth of caterpillars? ----------------

# the response variable
#using the boxplot to see if there is any outlier
boxplot(cat$growth, col = "darkgreen")

# the predictor variable
#using the unique() to see the possible values of cat$tannin without the
#duplicates
unique(cat$tannin)

# creating the lm
mod_cat <- lm(growth ~ tannin, data = cat)

summary(mod_cat)
anova(mod_cat)

## ----lm-plot------------------------------------------------------------------
#defining the axis by "Yaxis ~ Xaxis"
#pch argument?
plot(growth ~ tannin, data = cat, bty = 'l', pch = 19)
#then we can see our model by plotting with abline()
abline(mod_cat, col = "red", lwd = 2)

#abline() needs to be always right after the background graph code

## ----lm-ggplot----------------------------------------------------------------
ggplot(data = cat, mapping = aes(x = tannin, y = growth)) +
  geom_point() +
  geom_smooth(method = lm) +
  theme_classic()

# if we dont specify the geom_smoth() as our linear model, the ggplot will create
# a non linear model

ggplot(data = cat, mapping = aes(x = tannin, y = growth)) +
  geom_point() +
  geom_smooth() +
  theme_classic()


## AOV table
summary.aov(mod_cat)


## fitted values
predict(mod_cat)
cat$fitted <- predict(mod_cat)

# Comparing fitted vs. observed values
ggplot(data = cat) +
  geom_point(aes(x = growth, y = fitted)) +
  geom_abline(aes(slope = 1,  intercept = 0)) +
  theme_classic()


## Model diagnostics -----------------------------------------------------------
par(mfrow = c(2, 2))
plot(mod_cat)
par(mfrow = c(1, 1))

#Residual vs fitted: values should be just spreaded, without any pattern

#normal Q-Q: shows us if the residuals follows a normal distribution. every residues
#should be close to the line --- The residues should follow a normal distribution
# ins a good linear model

#scale-locomotion: how standar deviation are distributed

#residual vs leverage:


# Comparing statistical distributions ------------------------------------------
library(fitdistrplus)

data("groundbeef")
?groundbeef
str(groundbeef)

plotdist(groundbeef$serving, histo = TRUE, demp = TRUE)
#shows the empirical density distribution of the data and the cdf, but without
#fit the data to any specified distribution, just the data itselfs

descdist(groundbeef$serving, boot = 1000)
#cullen and frey graph

fw <- fitdist(groundbeef$serving, "weibull")
summary(fw)
#the fitdist(data, distribution) will evaluate if the data fits in the distribution
#gived as argument. Then, it will give us a lot of parameters and, among then,
# the "logLikelihood" wich will tell us if the distributions fits well our data


fg <- fitdist(groundbeef$serving, "gamma")
fln <- fitdist(groundbeef$serving, "lnorm")

par(mfrow = c(2, 2))
plot_legend <- c("Weibull", "lognormal", "gamma")
denscomp(list(fw, fln, fg), legendtext = plot_legend)
qqcomp(list(fw, fln, fg), legendtext = plot_legend)
cdfcomp(list(fw, fln, fg), legendtext = plot_legend)
ppcomp(list(fw, fln, fg), legendtext = plot_legend)


gofstat(list(fw, fln, fg))








###----------------------
#My annotations

#We search for the minimal and suitable model ( the simplier which suit our data)

#Maximum likehood = given the data, what are the parameters values that make
# this data more plausible

#Occam's Razor = Principle os Parsimony = if a lot of models fits, we should
#always use the simplest (less parameters) --> we dont need a model that fits
#exactly our data, because all models are wrong (not the reality, just a
#representation of it.)

##----STATISTICAL DISTRIBUTIONS

df_n <- data.frame(val = rnorm(1000, mean = 0, sd = 1)) #normal distribution
df_ln <- data.frame(val = exp(rnorm(1000)))#log-normal distributio

library(ggplot2)

ggplot()+
  geom_histogram(aes(dnorm(1000, mean = 0, sd = 1)))

dnorm(1, 0, 1)

# Prediction = trying to find the value in some are betwen points in which we
# have data about

#Extrapolation: trying to predict beyong the data

# In a model, the relation among X (predictor) and Y (respondse) should be linear

#Least Squares method -> strategy to try to find the curve ( linear ) that fits
#our data. It will start in a point named fulcrum, which its the mean Xaxis x the
#mean of Yaxis. Then, R will make a lot of lines passing throught the fulcrum and
# calculates the distance from the line to our data. The line with smallest
#distance will be choosed as ous model.
# it can be done by the ln() function (linear model)
# the measurement of how distance our model is from our data is named the "residues"

#Why we should use the sum of squares as a measurement?

# anova() give us the sum of squares

#Coefficiene of determination (R**2) tells us how much our model are explaning the data
# in other words, how much our model fits the data

# Tidy modeling with R
