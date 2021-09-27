################################################################################
# Avaliação de Risco de Crédito
# Objetivo é criar um modelo preditivo para classificar o risco de crédito de 
# clientes de uma instituição bancária
#
# Para mostrar o processo de construção de um modelo de classificação para 
# prever o risco de concessão de crédito a clientes de um banco
#
# Conjunto de dados da German Credit Data será usado para construir e treinar o
# modelo
# Dataset é baseado em dados reais gerados por um pesquisador da Universidade de
# Hamburgo na Alemanha
#
# Objetivo será prever o risco que cada cliente oferece para o banco ma hora 
# de conceder uma linha de credito
#
# https://archive.ics.uci.edu/ml/datasets/Statlog+(German+Credit+Data)
################################################################################

# setwd('../../../../data/')

# realizar atividade de engenharia de atributos
# atividade de quantizar algumas variaveis (converter de numérica para categorica)
# nesse exemplo será alterado as variáveis Duration, CreditAmount, age

Azure = FALSE

if(Azure){
  source("src/ClassTools.R")
  Credit = maml.mapInputPort(1)
}else{
  source("src/ClassTools.R")
  
  # obtendo dataset e adicionando suas labels 
  Credit = read.csv('German Credit Card UCI dataset.csv', stringsAsFactors = TRUE, header = FALSE )
  
 # install.packages('labelled')
  #library(labelled)
  
  # alterando nome das colunas
  colnames(Credit) =  c("CheckingAcctStat",
                        "Duration",
                        "CreditHistory",
                        "Purpose",
                        "CreditAmount",
                        "SavingsBonds",
                        "Employment",
                        "InstallmentRatePecnt",
                        "SexAndStatus",
                        "OtherDetorsGuarantors",
                        "PresentResidenceTime",
                        "Property",
                        "Age",
                        "OtherInstalments",
                        "Housing",
                        "ExistingCreditsAtBank",
                        "Job",
                        "NumberDependents",
                        "Telephone",
                        "ForeignWorker", "CreditStatus")
  #adicionando label as colunas
  var_label(Credit) = c('StatusChecking', 'Duration', 'HistoryCredit', 'Purpose', 'CreditAmount', 'SavingAccount', 'EmploymentSince', 'InstallmentRate', 'PersonalStatus', 'Guarantor', 'ResidenceSince', 'Property', 'Age', 'InstallmentPlans', 'housing', 'CreditsAtBank', 'Job', 'maintenance', 'Phone', 'ForeignWorker', 'CreditStatus')
  
  View(Credit)
}

# transformando variaveis numéricas em variáveis categoricas
toFactors = c("Duration","CreditAmount","Age")
maxVals = c(100, 1000000, 100)
fac_Names = unlist(lapply(toFactors, function(x) paste(x, "_f", sep="")))
Credit[,fac_Names] = Map(function(x,y) quantize.num(Credit[, x], maxval = y), toFactors, maxVals)

if(Azure) {
  maml.mapOutputPort('Credit')
} 

###############################################################################
###############################################################################
# Analise exploratória

if(Azure){
  source("src/ClassTools.R")
  Credit = maml.mapInputPort(1)
}else{
  source("src/ClassTools.R")
}
  
# criando plots usando ggplot2

library(ggplot2)
lapply(colNames2, function(x){
  if(is.factor(Credit[,x])){
    ggplot(Credit, aes_string(x)) +
      geom_bar() +
      facet_grid(. ~ CreditStatus) +
      ggtitle(paste("Total de Crédito bom/Ruim por ", x))
  }
})

# Plot CreditStatus vs StatusChecking
lapply(colNames2, function(x){
  if(is.factor(Credit[,x]) & x != "CheckingAcctStat") {
    ggplot(Credit, aes(CheckingAcctStat)) +
      geom_bar() +
      facet_grid(paste(x, " ~ CreditStatus")) +
      ggtitle(paste("Total de Crédito bom/Ruim CheckingAcctStat e ", x))
  }
})

###############################################################################
###############################################################################
# Seleção de variáveis

if(Azure){
  source("src/ClassTools.R")
  Credit = maml.mapInputPort(1)
}else{
  source("src/ClassTools.R")
}

library(randomForest)
modelo = randomForest(
  CreditStatus ~ .
  - Duration
  - Age
  - CreditAmount
  - ForeignWorker
  - NumberDependents
  - Telephone
  - ExistingCreditsAtBank
  - PresentResidenceTime
  - Job
  - Housing
  - SexAndStatus
  - InstallmentRatePecnt
  - OtherDetorsGuarantors
  - Age_f
  - OtherInstalments,
  data = Credit,
  ntree = 100, 
  nodesize = 10, importance = T)

varImpPlot(modelo)

outFrame - serList(list(Credit.model = modelo))
