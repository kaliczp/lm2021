## Adat generálás
x.co <- rep(0:10/10,11)
y.co <- rep(0:10/10,length=121,each=11)
plot(x.co,y.co, asp=T)

surf.df <- data.frame(x=x.co,y=y.co)

## Rács megjelenítése
plot(surf.df, asp = TRUE)
plot(surf.df$x,surf.df$y, asp = TRUE)

## Térbeli adatok a rácson
surf.df$surf <- 4 * surf.df$x - surf.df$y + rnorm(nrow(surf.df), sd=0.05)

## Adat mátrix
surf.mat <- matrix(surf.df$surf, nrow=11)

## Felület ábrázolása
plot(surf.df[,1:2], asp = TRUE)
contour(surf.mat, add = TRUE)

surf.lm <- lm(surf ~ x + y -1 , surf.df)
summary(surf.lm)
plot(surf.lm)
