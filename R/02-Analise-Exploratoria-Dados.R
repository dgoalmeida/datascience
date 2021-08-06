# Análise Exploratória de Dados

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("/Users/dgoalmeida/Documents/datascience/dsa/formacao-dsa/modulo1-r/3-Arquivos-Cap11/")
getwd()


# Carregando o pacote readr
library(readr)

# Carregando o dataset
carros <- read_csv("carros-usados.csv")

# Resumo dos dados
View(carros)
str(carros)

# Medidas de Tendência Central
summary(carros$ano)
summary(carros[c('preco', 'kilometragem', 'ano')])


##### Análise Exploratória de Dados Para Variáveis Numéricas ##### 

# Usando as funções
mean(carros$preco)
median(carros$preco)
quantile(carros$preco)
quantile(carros$preco, probs = c(0.01, 0.99))
quantile(carros$preco, seq( from = 0, to = 1, by = 0.20))
IQR(carros$preco) #Diferença entre Q3 e Q1
range(carros$preco)
diff(range(carros$preco))

# Plot

# Boxplot
# Leitura de Baixo para Cima - Q1, Q2 (Mediana) e Q3
boxplot(carros$preco, main = "Boxplot para os Preços de Carros Usados", ylab = "Preço (R$)",)
boxplot(carros$kilometragem, main = "Boxplot para a Km de Carros Usados", ylab = "Kilometragem (R$)")

# Histograma
# Indicam a frequência de valores dentro de cada bin (classe de valores)
hist(carros$preco, main = "Histograma para os Preços Carros Usados", xlab = "Preço (R$)")
hist(carros$kilometragem, main = "Histograma para a Km de Carros Usados", ylab = "Kilometragem (R$)")
hist(carros$kilometragem, main = "Histograma para a Km de Carros Usados", breaks = 5, ylab = "Kilometragem (R$)")

# Scatterplot Preço x Km
# Usando o preço como variável dependente (y)
plot(x = carros$kilometragem, y = carros$preco,
     main = "Scatterplot - Preço x Km",
     xlab = "Kilometragem",
     ylab = "Preço (R$)")

# Medidas de Dispersão
# Ao interpretar a variância, números maiores indicam que 
# os dados estão espalhados mais amplamente em torno da 
# média. O desvio padrão indica, em média, a quantidade 
# de cada valor diferente da média.
var(carros$preco)
sd(carros$preco)
var(carros$kilometragem)
sd(carros$kilometragem)


##### Análise Exploratória de Dados Para Variáveis Categóricas ##### 

# Criando tabelas de contingência - representam uma única variável categórica
# Lista as categorias das variáveis nominais
?table
str(carros)
table(carros$cor)
table(carros$modelo)
table(carros$ano)
str(carros)

# Calculando a proporção de cada categoria
model_table <- table(carros$modelo)
prop.table(model_table)

round(prop.table(table(carros$ano)) * 100, digits = 1)

# Arrendondando os valores
model_table <- table(carros$modelo)
model_table <- prop.table(model_table) * 100
round(model_table, digits = 1)

# Criando uma nova variável indicando cores conservadoras 
# (que as pessoas compram com mais frequência)
head(carros)
carros$conserv <- carros$cor %in% c("Preto", "Cinza", "Prata", "Branco")
head(carros)

# Checando a variável
table(carros$conserv)
round(prop.table(table(carros$conserv)) * 100, digits = 1)

# Verificando o relacionamento entre 2 variáveis categóricas
# Criando uma crosstable 
# Tabelas de contingência fornecem uma maneira de exibir 
# as frequências e frequências relativas de observações 
# (lembra do capítulo de Estatística?), que são classificados 
# de acordo com duas variáveis categóricas. Os elementos de 
# uma categoria são exibidas através das colunas; 
# os elementos de outra categoria são exibidas sobre as linhas.
install.packages("gmodels")
library(gmodels)
?CrossTable
CrossTable(x = carros$modelo, y = carros$conserv)


## Teste do Qui-quadrado

# Qui Quadrado, simbolizado por χ2 é um teste de 
# hipóteses que se destina a encontrar um valor da 
# dispersão para duas variáveis nominais, avaliando a 
# associação existente entre variáveis qualitativas.

# É um teste não paramétrico, ou seja, não depende dos 
# parâmetros populacionais, como média e variância.

# O princípio básico deste método é comparar proporções, 
# isto é, as possíveis divergências entre as frequências 
# observadas e esperadas para um certo evento.
# Evidentemente, pode-se dizer que dois grupos se 
# comportam de forma semelhante se as diferenças entre 
# as frequências observadas e as esperadas em cada 
# categoria forem muito pequenas, próximas a zero.

# Ou seja, Se a probabilidade é muito baixa, ele fornece 
# fortes evidências de que as duas variáveis estão 
# associadas.

CrossTable(x = carros$modelo, y = carros$conserv, chisq = TRUE)
chisq.test(x = carros$modelo, y = carros$conserv)


# Trabalhamos com 2 hipóteses:
# Hipótese nula: As frequências observadas não são diferentes das frequências esperadas.
# Não existe diferença entre as frequências (contagens) dos grupos.
# Portanto, não há associação entre os grupos

# Hipótese alternativa: As frequências observadas são diferentes das frequências esperadas, 
# portanto existe diferença entre as frequências.
# Portanto, há associação entre os grupos.


# Neste caso, o valor do Chi = 0.15  
# E graus de liberdade (df) = 2
# Portanto, não há associação entre os grupos
# O valor alto do p-value confirma esta conclusão.





