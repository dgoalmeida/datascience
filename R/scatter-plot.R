set.seed(67)

# definindo os dados
x = rnorm(10,5,7)
y = rpois(10,7)
z = rnorm(10,6,7)
t = rpois(10,9)

# criando plot
plot(x,y,col = "blue", pch=10, main = "Multi scatterplot",
     col.main = "red", cex.main = 1.5, xlab = "Variavel independente",
     ylab = "Variavel dependente")

# adicionando outros pontos ao plot
points(z,t, col="green", pch=4)

# criando legendas
legend(-6,5.9, legend=c("Nivel1","Nivel2","Nivel3"),
       col=c("blue","green",777), pch=c(10,4,9),
       cex=0.65, bty="n")
