# Estudo Dirigido - Balanceamento de Classes em Dados de Fraudes Financeiras com ROSE (Random OverSampling Examples) 

# Todos os detalhes sobre este trabalho de análise, incluindo a definição do problema e link para download do dataset,
# estão no manual em pdf do Estudo Dirigido no Capítulo 11 do Curso:
# Big Data Analytics com R e Microsoft Azure Machine Learning, Versão 2.0

# Definindo o diretório de trabalho
getwd()
setwd("/Users/dgoalmeida/Documents/datascience/data/")

# Pacotes (se algum pacote não estiver instalado na sua máquina, é simples: instale o pacote!)
install.packages("data.table")
install.packages("C50")
install.packages("ROSE")
install.packages("caret")
library(data.table)
library(C50)
library(caret)
library(ROCR)
library(pROC)
library(ROSE)

# Carregando os dados
?fread
# https://www.kaggle.com/mlg-ulb/creditcardfraud
dados <- fread("../data/creditcard.csv", stringsAsFactors = F, sep = ",", header =T)

# Visualizando os dados
# A coluna Class indica se a transação foi fraudulenta ou não, sendo portanto nossa variável target
# 0 indica que a transação não é fraudulenta
# 1 indica que a transação é fraudulenta
View(dados)
dim(dados)
str(dados)

# Verificando se temos valores ausentes
sum(is.na(dados))

# Distribuição de classe
# A classe está completamente desbalanceada. 
# Temos cerca de 99% de registros para a classe 0 e menos de 1% para a classe 1
prop.table(table(dados$Class))

# Graficamente a diferença fica clara
barplot(prop.table(table(dados$Class)))

# Vamos dividir os dados em treino e teste, sendo 70% para dados de treino e 30% para dados de teste
set.seed(7)
linhas <- sample(1:nrow(dados), 0.7 * nrow(dados))
dados_treino <- dados[linhas,]
dados_teste <- dados[-linhas,]

# Vejamos como está agora a distribuição da nossa classe nos dados de treino e de teste
prop.table(table(dados_treino$Class))
prop.table(table(dados_teste$Class))

# A diferença está lá. 
# Em geral, não devemos entregar os dados assim a um modelo de Machine Learning 
# (a menos que tenhamos um objetivo para isso).

# Vamos primeiro criar um modelo de Machine Learning com os dados desbalanceados e comparar com o 
# resultado depois do balanceamento de classe.

# Vamos converter a classe para o tipo fator, pois isso é necessário para o treinamento do modelo de classificação.
# Se não fizermos a conversão, a variável fica como tipo int e o algoritmo vai achar que queremos criar um modelo de regressão.
str(dados_treino$Class)
str(dados_teste$Class)
dados_treino$Class <- as.factor(dados_treino$Class)
dados_teste$Class <- as.factor(dados_teste$Class)
str(dados_treino$Class)
str(dados_teste$Class)

# Vamos criar um modelo antes de aplicar o balanceamento de classe.
# O algoritmo C5.0 cria um modelo de árvore de decisão e é estudado em detalhes no curso de Machine Learning da FCD
?C5.0

# Cria o modelo com dados de treino
modelo_v1 <- C5.0(Class ~ ., data = dados_treino)

# Agora fazemos previsões com o modelo usando dados de teste
previsoes_v1 <- predict(modelo_v1, dados_teste)

# Criamos a Confusion Matrix e analisamos a acurácia do modelo
# O parâmetro positive = '1' indica que a classe 1 é a positiva, ou seja, indica que sim, a transação é fraudulenta
?caret::confusionMatrix
caret::confusionMatrix(dados_teste$Class, previsoes_v1, positive = '1')

# Agora criamos a Curva ROC para encontrar a métrica AUC, conforme indicado no manual em pdf
roc.curve(dados_teste$Class, previsoes_v1, plotit = T, col = "red")

# Como resultados, nós temos:

# Acurácia = 0.999
# Score AUC = 0.759

# Como base somente na acurácia, o modelo estaria excelente, certo? Mas o Score AUC mostra que não é bem assim.
# Vamos chamar a ROSE para nos ajudar.

# Aplicando ROSE (Random OverSampling Example) 

# Com ROSE conseguimos balancear as clases usando a técnica de Oversampling, conforme explicamos no manual em pdf.
# O help oferece informações adicionais preciosas.
?ROSE

# ATENÇÃO: O IDEAL É SEMPRE APLICAR O DESBALANCEAMENTO DEPOIS DE FAZER A DIVISÃO DOS DADOS EM TREINO E TESTE.
# Se fazemos antes, o padrão usado para aplicar o oversampling será o mesmo nos dados de treino e de teste e, assim,
# a avaliação do modelo fica comprometida. 

# Aplicando ROSE em dados de treino e checando a proporção de classes
rose_treino <- ROSE(Class ~ ., data = dados_treino, seed = 1)$data
prop.table(table(rose_treino$Class))

# Conseguimos uma proporção quase 50/50 para as duas classes. Não pecisa ser exatamente assim, mas ficou muito bom!

# Aplicando ROSE em dados de teste e checando a proporção de classes
rose_teste <- ROSE(Class ~ ., data = dados_teste, seed = 1)$data
prop.table(table(rose_teste$Class))

# Agora criamos o modelo usando dados de treino balanceados
modelo_v2 <- C5.0(Class ~ ., data = rose_treino)

# E fazemos previsões usando dados de teste balanceados
previsoes_v2 <- predict(modelo_v2, rose_teste)

# Vamos verificar a acurácia
caret::confusionMatrix(rose_teste$Class, previsoes_v2, positive = '1')

# Calculamos o Score AUC
roc.curve(rose_teste$Class, previsoes_v2, plotit = T, col = "green", add.roc = T)

# Notou a diferença?

# Mantivemos quase a mesma acurácia (praticamente 99% nos dois modelos), mas aumentamos o Score AUC de 
# forma considerável, de 76% para 99%. Isso comprova que o modelo_v2 é muito melhor e mais estável que o modelo_v1.

# Isso apenas porque balanceamos as classes!



