# Solução Lista de Exercícios - Capítulo 12

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/FCD/BigDataRAzure/Cap12")
getwd()

# Usaremos o dataset iris neste exemplo
# O dataset iris possui observações de 3 especies de flores (Iris setosa, Iris virginica e Iris versocolor)
# Para cada flor, 4 medidas sao usadas: 
# comprimento (length) e largura (width) do caule (sepal) e comprimento e largura da petala (petal)
library(datasets)
head(iris)

# Análise exploratoria de dados com ggplot2
library(ggplot2)

# Veja que os dados claramente possui grupos com caracteristcas similares
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point(size = 3)

# Agora usarmeos o K-Means para tentar agrupar os dados em clusters
set.seed(101)
help(kmeans)

# Exercício 1 - Usando a função kmeans(), crie um modelo de clustering (aprendizagem não supervisionada). 
# Use a documentação, para fazer sua pesquisa.
# Neste caso, ja sabemos quantos grupos (clusters) existem em nossos dados (3)
# Perceba que o dataset iris possui 5 colunas, mas estamos usando as 4 primeiras

df_iris = iris
df_iris$Species = NULL
modelo = kmeans(df_iris, centers = 3)

summary(modelo)
table(modelo$cluster, iris$Species)

# Obtendo informação sobre os clusters
# Foram criados 3 clusters: cluster 1, 2 e 3
# Perceba que apesar o algoritmo ter feito a divisão dos dados em clusters, houve problema em dividir alguns dos dados, 
# que apesar de terem caracteristicas diferentes, ficaram no mesmo cluster


# Visualizando os clusters
install.packages("cluster")
library(cluster)
help(clusplot)

# Plot
clusplot(iris, modelo$cluster, color = TRUE, shade = TRUE, labels = 0, lines = 0, )





