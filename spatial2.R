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

library(sp)
coordinates(topo) <- ~x+y
class(topo)
topo
plot(topo)
axis(1)
axis(2)
box()

library(gstat)
hscat(z ~ 1, topo, 0:7)
var.z <- variogram(z ~ 1, topo)
plot(var.z)

var.zcloud <- variogram(z ~ 1, topo, cloud = TRUE)
plot(var.zcloud)

var.res <- variogram(z ~ x + y, topo)
plot(var.res)

data(meuse)
hist(meuse$zinc)
qqnorm(meuse$zinc)
qqline(meuse$zinc)
boxplot(meuse$zinc)
boxplot(log(meuse$zinc))
qqnorm(log(meuse$zinc))
qqline(log(meuse$zinc))
hist(log(meuse$zinc))
