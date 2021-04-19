## Idősor osztály
ts(1:10)
plot(ts(1:10))

co2
?co2
tsp(co2)
time(co2)

plot(co2)

## Látványosabb ábra
plot(co2,main="Szén-dioxid koncentráció (1959-1997)",xlab="",ylab="[ppm]",xaxs="i",typ="n")
grid(col="grey")
lines(co2,lwd=2)

co2.lm = lm(as.numeric(co2) ~ time(co2))
abline(co2.lm)
summary(co2.lm)
plot(co2.lm)

co2para.lm = lm(as.numeric(co2) ~ time(co2) + I(time(co2)^2))
?predict.lm
lines(as.numeric(predict(co2para.lm)) ~ as.numeric(time(co2)), col=2)

### Idősor soros függés
## Illeszkedési hiány
plot(co2.lm, 1)
plot(co2.lm$fitted.values, co2.lm$residuals)
lines(loess.smooth(co2.lm$fitted.values, co2.lm$residuals))
coef(co2.lm)
coef(co2para.lm)
## Függénnyel
plot(fitted(co2.lm),residuals(co2.lm))
lines(loess.smooth(fitted(co2.lm),residuals(co2.lm)))
## 
plot(time(co2),residuals(co2.lm))
plot(time(co2),residuals(co2.lm), type="l")


## Mozgóátlag modell
plot(co2)
co2.ma3=filter(co2,c(1/3,1/3,1/3)) #Mozgó átlag 3 e. ablak
lines(co2.ma3, col=3)
co2.ma4=filter(co2,c(rep(1/4,4))) #Mozgó átlag 4 e. ablak
lines(co2.ma4, col=4)
co2.ma4jav=filter(co2,c(1/8,rep(1/4,3),1/8)) #Mozgó átlag javított 4 e. ablak
lines(co2.ma4jav, col=4)
co2.ma12=filter(co2,c(1/24,rep(1/12,11),1/24)) #Mozgó átlag 12 e. ablak
lines(co2.ma12,col=4)

##Dekompozíció mozgóátlaggal
co2.dec <- decompose(co2)
plot(co2.dec)
plot(co2.dec$trend)
plot(co2.dec$seasonal)
co2.maradek = na.omit(co2.dec$random)
plot(co2.maradek)

## Fehér zaj
zaj <- rnorm(length(co2.maradek),mean(co2.maradek),sd(co2.maradek))
plot(ts(zaj, c(1959,7), freq=12),ylim=c(-1,1))
lines(co2.maradek, col=2)

## Autokorreláció
acf(zaj)
lag.plot(zaj, lags=4, layout = c(2,2))

acf(co2.maradek)
lag.plot(co2.maradek, lags=4, layout = c(2,2))

## Trendmentesítés
co2.notrend <- na.omit(co2 - co2.dec$trend)
plot(co2.notrend)
mean(co2.notrend)
co2.notrend.acf <- acf(co2.notrend)
co2.notrend.acf$acf

## Regresszió maradékok az idő függvényében
acf(residuals(co2.lm))
acf(residuals(co2para.lm))

co2.stl <- stl(co2, "period")
co2.stl.maradek <- co2.stl$time.series[,"remainder"]
co2.stlmarade.ts <- ts(co2.stl.maradek,start=1959, freq=12)
plot(co2.stlmarade.ts)
acf(co2.stlmarade.ts)     

## Spektrum
spectrum(co2.stlmarade.ts, spans = 5)
