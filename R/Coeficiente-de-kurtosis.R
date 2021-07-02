# Coeficiente de curtose

# é uma medida que caracteriza o achatamento da curva da funcao de distribuicao

# dados abaixo representando o numero de acidentes diarios em um complexo industrial

dados = c(18,20,20,21,22,24,25,25,26,27,29,29,
          30,30,31,31,32,33,34,35,36,36,37,37,
          37,37,38,38,38,40,41,43,44,44,45,45,
          45,46,47,48,49,50,51,53,54,54,56,58,62,65)

ck = kurtosis(dados)
ck

# ck =~0: Distriuição normal, chamda curtose Mesocúrtica
# ck < 0: cauda mais leve que a normal. Para um coeficiente de curtose negativo, tem-se uma curtose Platicúrtica
# ck > 0: cauda mais pesada que a normal. Para um coeficiente de Cirtpse positivo, tem-se uma curtose Leptocúrtica

# no exemplo a curtose é gual a 2.37, logo, como o valor de ck é maior que 0, a curva é Leptocúrtica

# outro exemplo
s.sample = rnorm(n = 1000, mean = 55, sd = 4.5)

skewness(s.sample)
kurtosis(s.sample)


datasim = data.frame(s.sample)
ggplot(datasim, aes(x= s.sample), binwidth = 2) +
  geom_histogram(aes(y=..density..), fill='red', alpha = 0.5) +
  geom_density(colour='blue') + xlab(expression(bold('Dados'))) +
  ylab(expression(bold('Densidade')))