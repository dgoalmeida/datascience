
getwd()

# obtendo os dados para analise
despesas = read.csv('Regressao/despesas.csv')

# visualizando os dados para entender 
View(despesas)
str(despesas)

summary(despesas)

#criando graficos para ententer os dados de forma visual

hist(despesas$gastos, main = 'Histograma', xlab = 'gastos')
boxplot(despesas$gastos, main = 'boxplot de gastos', ylab='gastos')

# usando table para ver os dados agruppado
?table
table(despesas$regiao)

# usando prop.table para ver percentualmente os dados agrupados com table
round(prop.table(table(despesas$regiao)) * 100, digits = 1)

# vendo a correlação entres as features

cor(despesas[c('idade','bmi','filhos','gastos')])

install.packages('psych')
library(psych)

pairs.panels(despesas[c('idade','bmi','filhos','gastos')])

# gerando modelo de regração a partir dos dados. 
# gastos é a feature target (que está tentando prever)
modelo = lm(gastos ~ .,data = despesas)

despesasTeste = read_csv('Regressao/despesas-teste.csv')

# usando modelo treinado para prever 
previsao = predict(modelo, despesasTeste)
previsao

despesasPrevisao = despesasTeste
despesasPrevisao['despesas'] = previsao
View(despesasPrevisao)

# visualizando os dados do modelo
summary(modelo)

despesas$idade2 = despesas$idade ^ 2
View(despesas)

despesas$bmi30 = ifelse(despesas$bmi <= 30, 2, 0)

modelo2 = lm(gastos ~ idade + idade2 + filhos + bmi + sexo + bmi30 * fumante + regiao, data = despesas)

summary(modelo2)

despesasPrevisao['despesas'] = predict(modelo2, despesasTeste)

View(despesasPrevisao)
