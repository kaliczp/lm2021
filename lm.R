## Regresszió teszt
x <- sample(1:100, 200, replace = TRUE)
y <- -2 * x + rnorm(n = 200, mean = 1, sd = 100)

## adattábla létrehozás
adat <- data.frame(a = x, b = y)

## Ábrázolás adattáblával
plot(b ~ a, data = adat)

## Korreláció
cov(x,y)
cor(x,y)

lm(b ~ a, data = adat)
