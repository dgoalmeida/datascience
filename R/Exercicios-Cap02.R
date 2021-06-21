# Lista de Exercícios - Capítulo 2

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("../dgoalmeida/Documents/formacao-dsa/modulo1-r/")
getwd()

# Exercício 1 - Crie um vetor com 30 números inteiros
v30 = c(seq(1:30))
v30

# Exercício 2 - Crie uma matriz com 4 linhas e 4 colunas preenchida com números inteiros
m = matrix(c(1,2,3,4,5,6,7,8), nr = 4, nc = 4)
m

# Exercício 3 - Crie uma lista unindo o vetor e matriz criados anteriormente
l = list(v30,m)
l

# Exercício 4 - Usando a função read.table() leia o arquivo do link abaixo para uma dataframe
# http://data.princeton.edu/wws509/datasets/effort.dat
d = read.table(url('http://data.princeton.edu/wws509/datasets/effort.dat'))
d
class(d)
# Exercício 5 - Transforme o dataframe anterior, em um dataframe nomeado com os seguintes labels:
# c("config", "esfc", "chang")
names(d) = c("config", "esfc", "chang")
d

# Exercício 6 - Imprima na tela o dataframe iris, verifique quantas dimensões existem no dataframe iris e imprima um resumo do dataset
dim(iris)
head(iris)
tail(iris)
summary(iris)
str(iris)

# Exercício 7 - Crie um plot simples usando as duas primeiras colunas do dataframe iris
plot(iris$Sepal.Length, iris$Sepal.Width)

# Exercício 8 - Usando a função subset, 
# crie um novo dataframe com o conjunto de dados do dataframe iris em que Sepal.Length > 7
# Dica: consulte o help para aprender como usar a função subset()
help("subset")
rm(iris2)
iris2 = subset(iris, Sepal.Length > 7)
iris2
# Exercícios 9 (Desafio) - Crie um dataframe que seja cópia do dataframe iris e usando a função slice(), 
# divida o dataframe em um subset de 15 linhas
# Dica 1: Você vai ter que instalar e carregar o pacote dplyr
# Dica 2: Consulte o help para aprender como usar a função slice()

df = data.frame(iris)
head(df)
library('dplyr')

slice(df, 1:15)
class(slice(df, 1:15))
# Exercícios 10 - Use a função filter no seu novo dataframe criado no item anterior e retorne apenas valores em que Sepal.Length > 6
# Dica: Use o RSiteSearch para aprender como usar a função filter

?filter
filter(df, Sepal.Length > 7.1)
