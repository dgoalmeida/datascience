library(lattice)

head(iris)

# distribuindo os dados verticalmente
iris_modif = reshape(iris, varying = 1:4, v.names = "Medidas",
                     timevar = "Dimensoes", times = names(iris)[1:4],
                     idvar = "ID", direction = "long")

head(iris_modif)

bwplot(Medidas ~ Species | Dimensoes, data = iris_modif)

head(iris)

iris_modif_sp = reshape(iris,
                        varying = list(c(1,3),c(2,4)),
                        v.names = c("Comprimento","Largura"),
                        timevar = "Parte",
                        times = c("Sepal","Petal"),
                        idvar = "ID",
                        direction="long")
head(iris_modif_sp)

xyplot(
  Comprimento ~ Largura | Species, groups = Parte,
  data = iris_modif_sp, auto.key = list(space="right"))


xyplot(
  Comprimento ~ Largura | Parte, groups = Species,
  data = iris_modif_sp, auto.key = list(space="right"))

library(reshape2)

df = data.frame(
  nome = c("Zico", "Pele"),
  chuteira = c(40,42),
  idade = c(34,NA),
  peso = c(93,NA),
  altura = c(175,178)
)
head(df)

# usando a funcao melt para o reshape
df_wide = melt(df, id = c("nome","chuteira"))
head(df_wide)

#removendo valores NA
df_wide = melt(df, id = c("nome","chuteira"), na.rm = TRUE)
head(df_wide)
