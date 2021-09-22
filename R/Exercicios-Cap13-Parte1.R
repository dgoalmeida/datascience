# Solução Lista de Exercícios - Capítulo 13

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/FCD/BigDataRAzure/Cap14")
getwd()

# Para este script, vamos usar o mlbench (Machine Learning Benchmark Problems)
# https://cran.r-project.org/web/packages/mlbench/mlbench.pdf
# Este pacote contém diversos datasets e usaremos um com os dados 
# de votação do congresso americano 

# Seu trabalho é prever os votos em republicanos e democratas (variável Class)

# Import
install.packages("mlbench")
library(mlbench)
?mlbench

# Carregando o dataset
?HouseVotes84
data("HouseVotes84")
View(HouseVotes84)

# Analise exploratória de dados
plot(as.factor(HouseVotes84[,2]))
title(main = "Votes cast for issue", xlab = "vote", ylab = "# reps")
plot(as.factor(HouseVotes84[HouseVotes84$Class == 'republican', 2]))
title(main = "Republican votes cast for issue 1", xlab = "vote", ylab = "# reps")
plot(as.factor(HouseVotes84[HouseVotes84$Class == 'democrat',2]))
title(main = "Democrat votes cast for issue 1", xlab = "vote", ylab = "# reps")

# Funções usadas para imputation
# Função que retorna o numeros de NA's por voto e classe (democrat or republican)
na_by_col_class <- function (col,cls){return(sum(is.na(HouseVotes84[,col]) & HouseVotes84$Class==cls))}

?sum
p_y_col_class <- function(col,cls){
  sum_y <- sum(HouseVotes84[,col] == 'y' & HouseVotes84$Class == cls, na.rm = TRUE)
  sum_n <- sum(HouseVotes84[,col] == 'n' & HouseVotes84$Class == cls, na.rm = TRUE)
  return(sum_y/(sum_y+sum_n))}

# Testando a função
p_y_col_class(2,'democrat')
p_y_col_class(2,'republican')
na_by_col_class(2,'democrat')
na_by_col_class(2,'republican')

runi
# Impute missing values
for (i in 2:ncol(HouseVotes84)) {
  if(sum(is.na(HouseVotes84[,i])>0)) {
    c1 <- which(is.na(HouseVotes84[,i]) & HouseVotes84$Class == 'democrat',arr.ind = TRUE)
    c2 <- which(is.na(HouseVotes84[,i]) & HouseVotes84$Class == 'republican',arr.ind = TRUE)
    HouseVotes84[c1,i] <- ifelse(runif(na_by_col_class(i,'democrat'))<p_y_col_class(i,'democrat'),'y','n')
    HouseVotes84[c2,i] <- ifelse(runif(na_by_col_class(i,'republican'))<p_y_col_class(i,'republican'),'y','n')}
}

# Gerando dados de treino e dados de teste
HouseVotes84[,"train"] <- ifelse(runif(nrow(HouseVotes84)) < 0.80,1,0)
trainColNum <- grep("train",names(HouseVotes84))

# Gerando os dados de treino e de teste a partir da coluna de treino
trainHouseVotes84 <- HouseVotes84[HouseVotes84$train == 1, -trainColNum]
testHouseVotes84 <- HouseVotes84[HouseVotes84$train == 0, -trainColNum]

# Invocando o método NaiveBayes
install.packages("e1071")
library(e1071)

# Exercício 1 - Crie o modelo NaiveBayes e faça as previsões

# Treine o modelo
?naiveBayes

modelo = naiveBayes(Class ~ ., data = trainHouseVotes84)
summary(modelo)

# prevendo dados e plotando em uma matriz de confusão
result_predict = predict(modelo, as.data.frame(testHouseVotes84))
table( pred = result_predict, true = testHouseVotes84$Class)
prop.table(table( pred = result_predict, true = testHouseVotes84$Class))

#media de acertos
mean(result_predict == testHouseVotes84$Class)
