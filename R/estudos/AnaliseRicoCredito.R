
setwd("Documents/datascience/data/")

# Objetivo desse mini projeto é avaliar o risco de concessão de credito a clientes em uma instituição financeira

# Obtendo os dados que serão analisados.
credit_df = as.data.frame(read.csv('credit_dataset.csv'))

# convertendo a variavel target em fator (como vou usar algoritmos de suport vector machine, ele precisa que o t
#arget seja  um fator para executar como modelo de classificação)
credit_df$credit.rating = as.factor(credit_df$credit.rating)

str(credit_df)
summary(credit_df)

# Analisando dataset

#credit_df$credit.rating                  # avaliação de credito (variavel target)
#credit_df$account.balance                # possui saldo
#credit_df$credit.duration.months         # meses do emprestimo (duração)
#credit_df$previous.credit.payment.status # status do pagamento anterior
#credit_df$credit.purpose                 # propósito do credito
#credit_df$credit.amount                  # valor do credito
#credit_df$savings                        # ?
# credit_df$employment.duration           # tempo empregado
#credit_df$installment.rate               # taxa de parcelamento
#credit_df$marital.status                 # estqado civil
#credit_df$guarantor                      # possui fiador
#credit_df$residence.duration             # tempo na mesma residencia
#credit_df$current.assets                 # quantidade ativos correntes
#credit_df$age                            # idade
#credit_df$other.credits                  # possui outros creditos 
#credit_df$apartment.type                 # tipo de apartamento
#credit_df$bank.credits                   # possui credito no banco
#credit_df$occupation                     # tipo  de ocupação (trabalho)
#credit_df$dependents                     # quantidade dependentes
#credit_df$telephone                      # possui telefone
#credit_df$foreign.worker                 # trabalha fora

###############################################################################
# Análise exploratória dos dados

#verificando se possuem dados NA
any(is.na(credit_df))

#criando um grafico para verificar a relação das variáveis com a variavel target
library(ggplot2)

# executando a função lapply  que receve um vetor com o nome das features e  uma função  para plotar um grafico
lapply(colnames(credit_df), function(x){
    ggplot(credit_df, aes_string(x)) +
      geom_bar() +
      facet_grid(. ~ credit.rating) +
      ggtitle(paste("Total de Crédito bom/Ruim por ", x))
  
})

# criando um grafico de correlação
corrplot::corrplot(cor(credit_df))

###############################################################################
#Normalizando dados que estão com escala diferente

credit_df$credit.duration.months = scale(credit_df$credit.duration.months, center = T, scale = T)
credit_df$age = scale(credit_df$age, center = T, scale = T)
credit_df$credit.amount = scale(credit_df$credit.amount, center = T, scale = T)

###############################################################################
# efetuando seleção de variaveis. verifica quais são mais importantes para o modelo

# usar randomForest para verogicar variaveis mais relevantes
# definindo numero de arvores igual a 100
#definindo tamanho dos nos = 10 
# definindo importance = TRUE para retornar grau de importancia de uma variavel
library(randomForest)
modelo = randomForest(
  credit.rating ~ .,
  data = credit_df,
  ntree = 100, 
  nodesize = 10, importance = T)


importance = as.data.frame(modelo$importance)

# pegando apenas as variaveis mais relevantes para o experimento, de acordo com a 
row_names = rownames(importance[importance$MeanDecreaseAccuracy >= mean(importance$MeanDecreaseAccuracy),])
library(stringr)

formula = as.formula(paste('credit.rating ~',str_c(row_names, collapse = ' + ')))


# função para gerar dados de treino e de test
splitData = function(dataframe, seed = NULL){
  if(!is.null(seed)) set.seed(seed)
  index = 1:nrow(dataframe)
  trinindex = sample(index, trunc(length(index)/2))
  trainset = dataframe[trinindex,]
  testset = dataframe[-trinindex,]
  list(trainset = trainset, testset = testset)
}

# gerando dados de treino e test
split = splitData(credit_df, seed = 808)

#separando dados
dados_treino = split$trainset
dados_test = split$testset

###############################################################################
# Usando modelo de classificação SVM

library(e1071)
svm_model = svm(formula, data = dados_treino)

###############################################################################
# Treinando modelo
pred = predict(svm_model, newdata = dados_test,  type = 'prob')

# Analisando resultado do treinamento
table(dados_test$credit.rating, pred)
round(prop.table(table(dados_test$credit.rating, pred)
) * 100, digits = 1)

# verificando acuracia
mean(pred == dados_test$credit.rating)

#Gerando confusion matrix com library caret
library(caret)
caret::confusionMatrix(as.factor(dados_test$credit.rating), as.factor(pred))


###############################################################################
# Usando modelo de classificação randonforest
library(randomForest)

modelo_r_forest = randomForest(formula, data = dados_treino)


###############################################################################
# Treinando modelo
pred_forest = predict(modelo_r_forest, newdata = dados_test)


# Analisando resultado do treinamento
table(dados_test$credit.rating, pred_forest)
round(prop.table(table(dados_test$credit.rating, pred_forest)
) * 100, digits = 1)

# verificando acuracia
mean(pred_forest == dados_test$credit.rating)

#Gerando confusion matrix com library caret
#library(caret)
caret::confusionMatrix(as.factor(dados_test$credit.rating), as.factor(pred_forest))

model_glm = glm(formula, data = as.factor(dados_treino),family = "binomial")
pred_glm = predict(model_glm, newdata = dados_test)

# Analisando resultado do treinamento
table(dados_test$credit.rating, pred_forest)
round(prop.table(table(dados_test$credit.rating, pred_forest)
) * 100, digits = 1)

caret::confusionMatrix(as.factor(dados_test$credit.rating), as.factor(pred_glm))

