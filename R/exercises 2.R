############################
install.packages("vegan")
library(vegan)


community.A <- c(10, 6, 4, 1)
community.B <- c(17, rep(1, 7))
#rep(1, 7) = replication of one, seven times

diversity(community.A, "shannon")
diversity(community.B, "shannon")
diversity(community.A, "invsimpso")
diversity(community.B, "invsimpso")

ren_comA <- renyi(community.A)
ren_comB <- renyi(community.B)
ren_AB <- cbind(ren_comA, ren_comB)
matplot(ren_AB)
matplot(ren_AB, type = "l")

matplot(ren_AB,
        type = "l",
        axes = FALSE)
box()
axis(side = 2)
axis(side = 1,
     labels = c(0, 0.25, 0.50, 1, 2, 4, 8, 16, 32, 64, "Inf"),
     at = 1:11)
legend("topright",
       legend = c("Community A", "Community B"),
       lty = c(1, 2),
       col = c(1, 2))
#lty is the line type, which will be used to adress the legends to the lines
#The line "1", will always be the full one, and the line "2" the dash one



#Functional traits: traites that are related to the morphologie of the species
#which allows then to live in a certain enviroment
