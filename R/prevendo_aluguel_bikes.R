
setwd("Documents/datascience/dsa/formacao-dsa/modulo1-r/1-Arquivos-Cap14/")

#obtendo dados para analise
source('Projeto/src/Tools.R')
df = read.csv('Projeto/bikes.csv', stringsAsFactors = FALSE)
head(df)
View(df)
str(df)


# após analisar os dados, verificou que existem dados em escalas diferentes portanto precisa de uma normalização

df_norm = subset(df, select = c(temp, atemp, hum, windspeed))
df_norm = as.data.frame(normalize(df_norm, method = 'standardize'))

View(df_norm)


df[,c('temp', 'atemp', 'hum', 'windspeed')] = df_norm

df = month.count(df)

df = na.omit(df)

# transformar objeto data
df$dteday = char.toPOSIXct(df)

# indicar dia da semana
df$isworking = ifelse(df$workingday & !df$holiday, 1, 0)

## criando fator ordenado do dia da semana
df$dayweek =  as.factor(weekdays(df$dteday))

# criando uma variavel de horario 
df$worktime = ifelse(df$isworking, df$hr, df$hr + 24)


df$instant = NULL

# verificando os dados após a normalizacao
View(df)

hist(df_norm$registered)
plot(df_norm$weathersit)

numeric_coluns = unlist(lapply(df, is.numeric))
df_numeric = df[,numeric_coluns]

# verificando correlação entre as variaveis
# utilizando metodo de PERSON e SPEARMAN

correlacao = lapply(c('pearson','spearman'), function(method)(
  cor(df_numeric, method = method)))
head(correlacao)

library(corrplot)
lapply(correlacao, function(x)(corrplot(as.matrix(x))))

#verificando o aluguel de bikes atravez do tempo
tempo = c(5,7,9,11,15,18,20,22)

library('ggplot2')
tms.plot = function(times){
ggplot(df[df$worktime == times,], aes(x=dteday, y=cnt))+
  geom_line() +
  ylab("numero de bikes") +
  labs(title = paste("demande de bikes as ", as.character(times), ":00", sep = "")) +
  theme(text = element_text(size = 20))
}

lapply(tempo, tms.plot)

# criando um boxplot para identificar os outliers 

labels = list("boxplot - demanda de bikes por hora",
              'boxplot - demandas de bikes por estação',
              'boxplot - demandas de bikes por dia util',
              'boxplot - demandas de bikes por dia da semana')

xaxis = list("hr","weathersit","isworking","dayweek")

plot.boxes = function(X, label) {
  ggplot(df, aes_string(x = X, y = 'cnt', group = X)) +
    geom_boxplot() +
    title(label) +
    theme(text = element_text(size = 20))
}

Map(plot.boxes, xaxis, labels)

# visualisando relacionamento entre as variaveis usando grafico de densidade

labels = list("demande de bikes x temperatura",
              "demanda de bikes x humidade",
              "demanda de bikes x velocidade do vento",
              "demanda de bikes x hora")

xaxis = list("temp", "hum","windspeed","hr")

plot.scatter = function(X, labels){
  ggplot(df, aes_string(x = X, y = 'cnt')) +
    geom_point(aes_string(colour = 'cnt'), alpha = 0.1) +
    scale_colour_gradient(low='green', high = 'blue') +
    geom_smooth(method = "loess") +
    ggtitle(labels) +
    theme(text = element_text(size = 20))
}

Map(plot.scatter, xaxis, labels)

# Selecao de vareiaveis
# analisando as variaveis mais importantes usando randomforest
library(randomForest)
any(is.na(df))
modelo = randomForest(cnt ~ ., data = df, ntree = 100, nodesize = 10, importance = TRUE)

varImpPlot(modelo)

# salvando valores selecionados
df_saida = df[,c('cnt', rownames(modelo$importance))]

# separando em dados de treino e teste
install.packages('caTools')
library(caTools)
amostra = sample.split(df$cnt, SplitRatio = 0.80)

treino = subset(df, amostra == TRUE)
teste = subset(df, amostra == FALSE)


# treinando modelo
modelo = lm( cnt ~ ., data = treino)
summary(modelo)

# validando
result = predict(modelo, teste)
result

table(result, teste$cnt)
round(prop.table(table(despesas$regiao)) * 100, digits = 1)
