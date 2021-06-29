# permite utilizar as colunas sem especificar o nome do dataset
attach(sleep)
sleep

sleepboxplot = boxplot(data = sleep, extra ~ group,
                       main = "Duracao do sono",
                       col.main = "red",
                       ylab = "horas",
                       xlab = "droga")
#calculo da media
media = by(extra,group,mean)

points(media, col="red")

boxplot(data = sleep, extra ~ group,
        main = "Duracao do sono",
        col.main = "red",
        ylab = "horas",
        xlab = "droga",
        horizontal = T,
        col = c("blue","red"))
