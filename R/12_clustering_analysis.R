library(vegan)
library(cluster)

data(dune)
data(dune.env)
table(dune.env$Management)


################## Hierarchical Clustering ##################################


bray_distance <- vegdist(dune)
# Chord distance, euclidean distance normalized to 1.
chord_distance <- dist(decostand(dune, "norm")) #every point are standarised
#to be in a sphere and then the euclidean distance is calculated

b_cluster <- hclust(bray_distance, method = "average")
c_cluster <- hclust(chord_distance, method = "average")

par(mfrow = c(1, 2))
plot(b_cluster)
plot(c_cluster)
par(mfrow = c(1, 1))

par(mfrow = c(1, 2))
plot(b_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
plot(c_cluster, hang = -1, main = "", axes = F)
axis(2, at = seq(0, 1, 0.1), labels = seq(0, 1, 0.1), las = 2)
par(mfrow = c(1, 1))

###############

chord_distance <- dist(decostand(dune, "norm"))

norm <- decostand(dune, "norm")
pca <- rda(norm)
plot(pca)

summary(pca)
