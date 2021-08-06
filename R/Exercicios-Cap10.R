# Solução Lista de Exercícios - Capítulo 10

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("Documents/datascience/git/datascience/R/")
getwd()


# Pacotes
install.packages("dplyr")
install.packages('nycflights13')
library('ggplot2')
library('dplyr')
library('nycflights13')
library("data.table")
View(flights)
?flights

# Definindo o Problema de Negócio
# Crie um teste de hipótese para verificar se os voos da Delta Airlines (DL)
# atrasam mais do que os voos da UA (United Airlines)


##### ATENÇÃO #####
# Você vai precisar do conhecimento adquirido em outros capítulos do curso 
# estudados até aqui para resolver esta lista de exercícios!


# Exercício 1 - Construa o dataset pop_data com os dados de voos das 
# companhias aéreas UA (United Airlines) e DL (Delta Airlines). 
# O dataset deve conter apenas duas colunas, nome da companhia e atraso nos voos de chegada.
# Os dados devem ser extraídos do dataset flights para construir o dataset pop_data
# Vamos considerar este dataset como sendo nossa população de voos

pop_data = flights %>%
  filter(carrier == 'DL' |  carrier == 'UA', arr_delay >= 0) %>%
  select(carrier, arr_delay)

View(data.frame(pop_data))
# Exercício 2  - Crie duas amostras de 1000 observações cada uma a partir do 
# dataset pop_data apenas com dados da companhia DL para amostra 1 e apenas dados 
# da companhia UA na amostra 2
?sample



tail(pop_data)
dl = na.omit(pop_data) %>%
  filter(carrier == 'DL') %>%
  dplyr::sample_n(1000)

View(dl)


ua = na.omit(pop_data) %>%
  filter(carrier == 'UA') %>%
  dplyr::sample_n(1000)

# Dica: inclua uma coluna chamada sample_id preenchida com número 1 para a primeira 
# amostra e 2 para a segunda amostra

dl["sample_id"] = 1
ua["sample_id"] = 2



# Exercício 3 - Crie um dataset contendo os dados das 2 amostras criadas no item anterior. 
?rbind
df2 = rbind(dl,ua)
View(df2)

# Exercício 4 - Calcule o intervalo de confiança (95%) da amostra1

m1_mean = mean(dl$arr_delay)
m1_mean

erro_padrao_amostra1 = sd(dl$arr_delay) / sqrt(nrow(dl))

alpha = 0.04
t.score = qt(p=alpha/2, df=length(dl)-1, lower.tail = F)

margin.error = 1.96 * erro_padrao_amostra1

lower.bound = m1_mean - margin.error
upper.bound = m1_mean + margin.error
ic_1 = c(lower.bound, upper.bound)

# Usamos a fórmula: erro_padrao_amostra1 = sd(amostra1$arr_delay) / sqrt(nrow(amostra1))

# Esta fórmula é usada para calcular o desvio padrão de uma distribuição da média amostral
# (de um grande número de amostras de uma população). Em outras palavras, só é aplicável 
# quando você está procurando o desvio padrão de médias calculadas a partir de uma amostra de 
# tamanho n𝑛, tirada de uma população.

# Digamos que você obtenha 10000 amostras de uma população qualquer com um tamanho de amostra de n = 2.
# Então calculamos as médias de cada uma dessas amostras (teremos 10000 médias calculadas).
# A equação acima informa que, com um número de amostras grande o suficiente, o desvio padrão das médias 
# da amostra pode ser aproximado usando esta fórmula: sd(amostra) / sqrt(nrow(amostra))
  
# Deve ser intuitivo que o seu desvio padrão das médias da amostra será muito pequeno, 
# ou em outras palavras, as médias de cada amostra terão muito pouca variação.

# Com determinadas condições de inferência (nossa amostra é aleatória, normal, independente), 
# podemos realmente usar esse cálculo de desvio padrão para estimar o desvio padrão de nossa população. 
# Como isso é apenas uma estimativa, é chamado de erro padrão. A condição para usar isso como 
# uma estimativa é que o tamanho da amostra n é maior que 30 (dado pelo teorema do limite central) 
# e atende a condição de independência n <= 10% do tamanho da população.

# Erro padrão
erro_padrao_amostra1 = sd(dl$arr_delay) / sqrt(nrow(dl))
erro_padrao_amostra1
# Limites inferior e superior
# 1.96 é o valor de z score para 95% de confiança


# Intervalo de confiança



# Exercício 5 - Calcule o intervalo de confiança (95%) da amostra2

m2_mean = mean(ua$arr_delay)
m2_mean

erro_padrao_amostra2 = sd(ua$arr_delay) / sqrt(nrow(ua))

alpha = 0.05
t.score = qt(p=alpha/2, df=length(dl)-1, lower.tail = F)

margin.error = 1.96 * erro_padrao_amostra2

lower.bound = m2_mean - margin.error
upper.bound = m2_mean + margin.error
ic_2 = c(lower.bound, upper.bound)

# Exercício 6 - Crie um plot Visualizando os intervalos de confiança criados nos itens anteriores
# Dica: Use o geom_point() e geom_errorbar() do pacote ggplot2
toPlot = summarise(group_by(df2, sample_id), mean = mean(arr_delay))
toPlot = mutate(toPlot, lower = ifelse(sample_id == 1, ic_1[1],ic_2[1]))
toPlot = mutate(toPlot, upper = ifelse(sample_id == 1, ic_1[2],ic_2[2]))
ggplot(toPlot, aes(x = sample_id, y=mean, colour = sample_id))+
  geom_point() +
  geom_errorbar(aes(ymin=lower, ymax=upper), width=.1)

# Exercício 7 - Podemos dizer que muito provavelmente, as amostras vieram da mesma população? 
# Por que?



# Exercício 8 - Crie um teste de hipótese para verificar se os voos da Delta Airlines (DL)
# atrasam mais do que os voos da UA (United Airlines)

# H0 e H1 devem ser mutuamente exclusivas.

# O teste t (de student) foi desenvolvido por Willian Sealy Gosset em 1908 que usou
# pesudônimo "student" em função da confidencialidade requerida por seu empregador
# (cervejaria guinnes) que considerava o uso da estatistica na manutenção da qualidade como 
# uma vantagem competitiva
# o teste t de student tem diversas  variações de aplicação e pode ser usado na comparação
# de duas (e somente duas) médias e as suas variações dizem respeito as hipoteses que são testadas

t.test(dl$arr_delay, ua$arr_delay, alternative = "greater")

# valor-p é uma quantificação da probabilidade de se errar ou rejeitar H0 e a mesma
# decorre da distribuição estatistica adotada
# se o valor-p é menor que o nivel de significancia, conclui-se que o correto é rejeitar a 
# hipotesi de nulidade

# valor p é a probabilidade de que a estatistica do teste assuma um valor extremo em relação
# ao valor observado quando H0 é verdadeira

# estamos trabalhando com alfa igual a 0.05 (95% de confiança)

# regra
# baixo valor p: forte evidencia empirica contra h0
# alto valor p: pouca ou nenhuma  evidência empirica contra h0

# falhamos em rejeitar a hipótese nula, pois o p-value é maior que o nivel de significancia
# isso quer dizer que há uma probabilidade alta de nao haver diferença significativa entre os atrasos
# para os nossos dados, não há evidencia de que a DL atrase mais de a UA