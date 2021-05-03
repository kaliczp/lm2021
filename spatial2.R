library(MASS)
library(spatial)
data(topo)
topo
class(topo)
View(topo)
plot(topo)
plot(topo[,1:2])
plot(topo[,c("x","y")], asp=T)
text(topo$x, topo$y, topo$z, adj = c(0,0))

topo.ls <- surf.ls(2, topo)
trsurf <- trmat(topo.ls, 0, 6.5, 0, 6.5, 50)
contour(trsurf, asp = TRUE)

correlogram(topo.ls, 30)
variogram(topo.ls, 30)
