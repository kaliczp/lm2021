## Regresszió teszt
x <- sample(1:100, 200, replace = TRUE)
y <- -2 * x + rnorm(n = 200, mean = 1, sd = 100)

plot(x,y)

cov(x,y)
cor(x,y)
