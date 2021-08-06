setwd('Classificacao/')

#Definição do problema
# Previsão de ocorrência de cancer de mama

dados = read.csv('dataset.csv', stringsAsFactors = FALSE)
str(dados)
View(dados)

#excluido coluna id, porque nao sera utilizado, nao e uma caracteristica
dados$id = NULL

# alterando label do diagnistico
dados$diagnosis = sapply(dados$diagnosis, function(x){ifelse(x=='M','Maligno','Benigno')})

# Muitos classificadores requerem que as variáveis sejam do tipo fator
#criando tabela de contingencia usando table
table(dados$diagnosis)
dados$diagnosis = factor(dados$diagnosis, levels = c("Benigno","Maligno"), labels = c("Benigno","Maligno"))

#verificando a proporção
round(prop.table(table(dados$diagnosis)) * 100, digits = 1)

# Medidas de tendencia central
# foi detectado um problema de escala entre os dados, que então precisa ser normalizados
# O cálculo de distância feito pelo KNN é dependente das medicas de escala nos dados de entrada

summary(dados[c("radius_mean","area_mean","smoothness_mean")])

# criando uma função de normalizacão
normalizar = function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}


#Testando a função de normalização
normalizar(c(1,2,3,4,5,6))
normalizar(c(10,20,30,40,50))

# normalizando dados
dados_norm = as.data.frame(lapply(dados[2:31], normalizar))
View(dados_norm)

#Treinando o modelo com KNN Visinho mais proximo
library(class)

# criando dados de treino e dados de teste
dados_treino = dados_norm[1:469, ]
dados_teste = dados_norm[470:569, ]

# atribuindo os labels para os dados de treino e de teste
dados_treino_labels = dados[1:469, 1]
dados_teste_labels = dados[470:569, 1]

# criando o modelo
# o atributo k indica que o algoritmo irá olhar  os 21 de dadospontos mais proximos de cada ponto de dado (distancia euclidiana)
modelo_knn_v1 = knn(train = dados_treino,
                    test = dados_teste,
                    cl = dados_treino_labels,
                    k = 21)
summary(modelo_knn_v1)

# a função knn() retorna um objeto do tipo fator com as previsões

# Avaliando e interpretando o Modelo

library(gmodels)

# criando uma tabela cruzada dos dados previstos x dados atuais
#usaremos amostra com 100 observações (os dados_teste_labels)
CrossTable(x = dados_teste_labels, y = modelo_knn_v1, prop.chisq = FALSE)

# interpretando os resultados
# A tabela cruzada mostra 4 possíveis valores, que representams os falso/verdadeiro positivo e falso/verdadeiro negativo
# temos duas colunas listando os labels originais nos dados observados
# temos duas linhas listando as labels dos dados de teste

# Cenário 1: célula benigno (observado) x benigno (previsto) - 61 casos - true positive
# Cenário 2: células Maligno (Observado) x Benigno (Previsto) - 0 casos - false positive
# cenário 3: célula benigno ( Observado) x Maligno (Previsto) - 2 casos - false negative
# cenário 4: célula maligno (Observado) x Maligno (previsto) - 37 casos - true negative

# taxa de acerto do modelo: 98% (acertou 98 em 100)


# otimizando a performance do modelo

#usando a função scale() para padronizar o z-score
dados_z = as.data.frame(scale(dados[-1]))
summary(dados_z)

# criando dados de treino e dados de teste
dados_treino = dados_z[1:469, ]
dados_teste = dados_z[470:569, ]

# atribuindo os labels para os dados de treino e de teste
dados_treino_labels = dados[1:469, 1]
dados_teste_labels = dados[470:569, 1]

#reclassificando
modelo_knn_v2 = knn(train = dados_treino,
                    test = dados_teste,
                    cl = dados_treino_labels,
                    k = 21)
summary(modelo_knn_v2)

# criando novamente a tabela cruzada
CrossTable(x = dados_teste_labels, y = modelo_knn_v2, prop.chisq = FALSE)

# AS ALTERAÇÕES PIORARAM O RESULTADO, FAZENDO O ALGORITMO ERRAR MAIS


####################

# Usando SVM (suport vector machine) 

# separando os dados de treino e teste usando runif
dados['index'] = ifelse(runif(nrow(dados)) < 0.8,1,0)
View(dados)

trainSet = dados[dados$index==1,]
testSet = dados[dados$index==0,]

# removendo os indices criados

trainSet$index = NULL
testSet$index = NULL

# obter indice da coluna da variavel target usando a funcao grep 
typeColun = grep('diag', names(dados))

# criando nodelo
# Ajustando kernal para radial já que este conjunto de dados nao tem um plano linear
# que pode ser desenhado

library(e1071)
modelo_svm_v1 = svm(diagnosis ~ .,
                    data = trainSet,
                    type = 'C-classification',
                    kernel = 'radial')

# prevendo dados de treino
pred_train = predict(modelo_svm_v1, trainSet)

# percentual de previsoes corretas com dataset de treino
mean(pred_train == trainSet$diagnosis)

# prevendo dados de test
pred_test = predict(modelo_svm_v1, testSet)

# percentual de previsoes corretas com dataset de test
mean(pred_test == testSet$diagnosis)

table(pred_test, testSet$diagnosis)

############################

# usando Random forest
library(rpart)

modelo_rf_v1 = rpart(diagnosis ~ ., data = trainSet, control = rpart.control(cp =.0005))

tree_pred = predict(modelo_rf_v1, testSet, type = 'class')

mean(tree_pred == testSet$diagnosis)

table(tree_pred, testSet$diagnosis)


