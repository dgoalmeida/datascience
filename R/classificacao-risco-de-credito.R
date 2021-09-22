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

# Coletando os dados

setwd('../../../../data/')

# obtendo dataset e adicionando suas labels 
df = as.data.frame(read.csv('German Credit Card UCI dataset.csv', stringsAsFactors = TRUE, header = FALSE ))

install.packages('labelled')
library(labelled)

# alterando nome das colunas
colnames(df) =  c('StatusChecking', 'Duration', 'HistoryCredit', 'Purpose', 'CreditAmount', 'SavingAccount', 'EmploymentSince', 'InstallmentRate', 'PersonalStatus', 'Guarantor', 'ResidenceSince', 'Property', 'Age', 'InstallmentPlans', 'housing', 'CreditsAtBank', 'Job', 'maintenance', 'Phone', 'ForeignWorker', 'CreditStatus')

#adicionando label as colunas
var_label(df) = c('StatusChecking', 'Duration', 'HistoryCredit', 'Purpose', 'CreditAmount', 'SavingAccount', 'EmploymentSince', 'InstallmentRate', 'PersonalStatus', 'Guarantor', 'ResidenceSince', 'Property', 'Age', 'InstallmentPlans', 'housing', 'CreditsAtBank', 'Job', 'maintenance', 'Phone', 'ForeignWorker', 'CreditStatus')

str(df)
View(df)

