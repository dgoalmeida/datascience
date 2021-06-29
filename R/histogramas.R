hist(cars$speed)


hist(cars$speed, breaks = 10, main = "Histograma de velocidades")
hist(cars$speed, breaks = c(0,5,10,20,30), main = "Histograma de velocidades", labels = T)
hist(cars$speed, breaks = 10, main = "Histograma de velocidades", labels = T)
hist(cars$speed, breaks = 10, main = "Histograma de velocidades", labels = T, ylim = c(0,10))
hist(cars$speed, breaks = median(cars$speed), main = "Histograma de velocidades", labels = T, ylim = c(0,10))


# adicionando linhas ao historgrama

grafico = hist(cars$speed, breaks = 10, main = "Histograma de velocidades", labels = T)

xaxis = seq(min(cars$speed),max(cars$speed), length = 10)
yaxis = dnorm(xaxis, mean = mean(cars$speed), sd = sd(cars$speed))
yaxis = yaxis*diff(grafico$mids)*length(cars$speed)

lines(xaxis, yaxis, col="red")

# usando dataframes
attach(iris)
values = table(Species)
View(values)
labels = paste(names(values))
labels
pie(values, labels =labels, main = "Distribuicao de especies")


#grafico 3d

install.packages("plotrix")
library("plotrix")

pie3D(fatias, labels = paises, explode = 0.05,
      col = c("steelblue1","tomato2","tan3"),
      main = "Distribuicao de vendas")
