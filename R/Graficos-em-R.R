getwd()
search()

#demo
demo("graphics")

# Plot basico

x = 1:10
y = 41:50
plot(x,y)
?plot

altura = c(145, 180, 176, 160, 158)
largura = c(51, 55, 70, 42, 80)
plot(altura, largura)

# plotando um dataframe
?lynx
plot(lynx)
plot(lynx, ylab="Plot om Dataframes", xlab="")
plot(lynx, ylab="Plot om Dataframes", xlab="Observacoeas")
plot(lynx, ylab="Plot om Dataframes", xlab="Observacoes", col = "red")
plot(lynx, main="Plot om Dataframes", 
     ylab="Plot om Dataframes", 
     xlab="Observacoes", 
     col = "red", 
     col.main = 52,
     cex.main = 1.5)

#histograma
library(datasets)
hist(warpbreaks$breaks)

#boxplot
airquality
transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

## alterando atributos do plot

# alterando imagem do ponto
plot(x,y, pch="&")

par(mfrow = c(2,2), col.axis = "red")
plot(1:8, las = 0, xlab="xlab", ylab = "ylab", main = "LAS 0")
plot(1:8, las = 0, xlab="xlab", ylab = "ylab", main = "LAS 1")
plot(1:8, las = 0, xlab="xlab", ylab = "ylab", main = "LAS 2")
plot(1:8, las = 0, xlab="xlab", ylab = "ylab", main = "LAS 3")
legend("topright", pch = 1, col = c("blue","red"), legend = c("var1","var2"))

par(mfrow = c(1,1), col.axis = "cyan3")

# corees disponiveis
colors()

#salvando em png
png("Grafico1.png", width = 500, height = 500, res = 72)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species,
     main = "Grafico gerado a partir do iris")

dev.off()

# salvando em pdf
pdf("Grafico2.pdf")
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species,
     main = "Grafico gerado a partir do iris")

dev.off()

# estendendo as funcoes do plot com o plotrix

install.packages("plotrix")
library("plotrix")

par(mfrow = c(1,1), col.axis = "red")
plot(1:6, las = 3, xlab = "lty 1:6", ylab ="", main = "Mais opcoes de plot")
ablineclip(v=1, lty=1, col="sienna2", lwd =2)
ablineclip(v=3, lty=1, col="sienna2", lwd =2)
ablineclip(v=5, lty=1, col="sienna2", lwd =2)


plot(lynx)
plot(lynx, type="p", main="Type P")
plot(lynx, type="l", main="Type l")
plot(lynx, type="b", main="Type b")
plot(lynx, type="o", main="Type o")
plot(lynx, type="h", main="Type h")
plot(lynx, type="s", main="Type s")

title("")
