# Lista de Exercícios Parte 4 - Capítulo 11

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("/Users/dgoalmeida/Documents/datascience/data/")
getwd()



# Definindo o Problema: OCR - Optical Character Recognition
# Seu modelo deve prever o caracter a partir do dataset fornecido. Use um modelo SVM

## Explorando e preparando os dados
letters <- read.csv("letterdata.csv")
str(letters)
View(letters)

letters$letter = as.factor(letters$letter)
# Criando dados de treino e dados de teste
letters_treino <- letters[1:16000, ]
letters_teste  <- letters[16001:20000, ]

## Treinando o Modelo
install.packages("kernlab")
library(kernlab)

# Criando o modelo com o kernel vanilladot
letter_classifier = ksvm(letter ~ .  ,data = letters_treino, kernel = "vanilladot")

summary(letter_classifier)

pred = predict(letter_classifier, letters_teste)
pred

table(pred, letters_teste$letter)

# criando um vetor de true false

vetor = pred == letters_teste$letter
vetor
table(vetor)
prop.table(table(vetor))
