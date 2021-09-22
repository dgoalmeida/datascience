# Lista de Exercícios Parte 2 - Capítulo 11

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("/Users/dgoalmeida/Documents/datascience/data/")
getwd()


# Regressão Linear
# Definição do Problema: Prever as notas dos alunos com base em diversas métricas
# https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Dataset com dados de estudantes
# Vamos prever a nota final (grade) dos alunos

# Carregando o dataset
df <- read.csv2('student/student-por.csv')

# Explorando os dados
head(df)
summary(df)
str(df)
any(is.na(df))

# install.packages("ggplot2")
# install.packages("ggthemes")
# install.packages("dplyr")
library(ggplot2)
library(ggthemes)
library(dplyr)

View(df)

# verificando se tem dados null
sum(is.na(df))

# obtendo as variaveis numéricas
numerics = sapply(df, is.numeric)
numerics

# obtendo colunas que contem correlação
numerics_corr = cor(df[,numerics])

# utilizando pacotes para visualizar análise de correlaçao
install.packages('corrgram')
library(corrplot)

# visualizando correlação com o corrplot
corrplot(numerics_corr, method = 'color')

# criando um histograma para verificar como a variavel trarget está distribuida
ggplot(df, aes(x = G3)) +
  geom_histogram(bins = 20,
                 alpha = 0.5, fill = 'blue') +
  theme_minimal()

# treinando e interpretando modelo
install.packages('caTools')
library(caTools)

set.seed(101)
amostra = sample.split(df$age, SplitRatio = 0.70)
amostra

# estraindo amostras de treino e teste

treino = subset(df, amostra == TRUE)
teste = subset(df, amostra == FALSE)


# treinando modelo
modelo = lm(G3 ~ .,  data = treino)

summary(modelo)

# fazendo previsoes
prevendo_G3 = predict(modelo, teste)

# visualizando resultados
resultados = cbind(prevendo_G3, teste$G3)
colnames(resultados) = c('Previsto','Real')
resultados = as.data.frame(resultados)
resultados

# tratando valores negativos

tratar_zero = function(x){
  if(x < 0){
    return(0)
  }else {
    return(x)
  }
}

resultados$Previsto = sapply(resultados$Previsto, tratar_zero)
resultados
