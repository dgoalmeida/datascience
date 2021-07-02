# Coeficiente de Assimetria

# é oque permit4 dizer se uma determinada distribuicao e assimetrica ou nao

# dados abaixo representando o numero de acidentes diarios em um complexo industrial

dados = c(18,20,20,21,22,24,25,25,26,27,29,29,
          30,30,31,31,32,33,34,35,36,36,37,37,
          37,37,38,38,38,40,41,43,44,44,45,45,
          45,46,47,48,49,50,51,53,54,54,56,58,62,65)

hist( dados, main = "Humero de Acidentes Diarios", xlab = "Acidentes", ylab = "Frequencia")

mean(dados)
sd(dados)
median(dados)

install.packages("moments")
library(moments)

sk = skewness(dados)
sk

# sk =~ 0: dados assimetricos. tanto a cauda do lado direito quando a do lado esquerdo da funcao densidade estao proximo de 0 (sao iguais)
# sk <  0: assimetria negativa. A cauda do lado esquerdo da funcao de densidade de probabilidade é maior que a do lado direito
# sk >  0: assimetria positiva. A cauda do lado direito da funcao de densidade de probabilidade é maior quew a do lado esquerdo 

# nesse exemplo, o coeficiente de assimetria é maior que 0, diz-se que a curva apresenta assimetria positiva
# a cauda do lado direito da funcao densidade de probabilidade é maior que a do lado esquerdo

#outro exemplo
set.seed(1234)
x = rnorm(1000)
hist(x)
skewness(x)
