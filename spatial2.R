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

coordinates(meuse) <- ~x+y
plot(meuse)

hscat(log(zinc)~1, meuse, c(0, 80, 120, 250, 500, 1000))

var.res <- variogram(log(zinc) ~x+y, meuse)
plot(var.res)

var.res <- variogram(log(zinc) ~x+y, meuse, alpha = c(0,45,90,135))
plot(var.res)

v <- variogram(log(zinc) ~x+y, meuse)
## Variogram modellek
show.vgms()

v.fit <- fit.variogram(v, vgm(1, "Sph", 700, 1))
plot(v,v.fit)

data("meuse.grid")
gridded(meuse.grid) <- ~x+y
plot(meuse.grid)
points(meuse.grid)

m = vgm(.39, "Sph", 1100, 0.08)
plot(v,m)
m.k1 <- krige(log(zinc) ~1, meuse, meuse.grid, model = m)
plot(m.k1)
spplot(m.k1["var1.pred"])

m.k2 <- krige(log(zinc)~1, meuse, meuse.grid, model=m, beta=5.9)
m.k3 <- krige(log(zinc) ~x+y, meuse, meuse.grid, model = m)
plot(m.k3)
