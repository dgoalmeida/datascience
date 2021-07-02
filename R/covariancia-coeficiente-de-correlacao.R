# Covariancia

# covariancia entre duas variaveis (x,y) é uma medida de variabilidade conjunta dessas dusa variaveis aleatorias
# Quando a covariância entre essas variáveis  é positiva, os dados apresentam tendencia positiva na dispersão
# Quando o valor da covariância é negativo, o comportamento é analogo e os dados apresentam tendências negativas

# Covariância é uma medida de como as alterações em uma variável estão associadas a mudanças em uma segunda variável
# Especificamente, mede o grau em que duas variáveis estão linearmente associadas.

# Coeficiente de correlação
# é uma versão em escala da covariância que assume valores entre [-1,1]
# com uma correlação  de 0 ou 1 indicando associação linear perfeita e 0 indicando nenhuma relação linear
# # A constante de escala é o produtro dos desvios padrão das duas variáveis

# Portanto, mede o grau de correlação entre duas variáveis

# para p = 1, tem-se uma correlação perfeita entre as duas variáveis
# para p = -1 há uma correlação perfeita entre as duas variaveis, no entando é uma correlação negativa
# caso p = 0, as duas variáveis não dependem linearmente uma da outra

#explicando de outra forma
# Para p = -1 indica uma forte correlação negativa: toda vez que x aumenta, y diminui
# Para p = 0 significa que não há associação entre as duas variaveis
# Para p = 1 indica forte correlação positiva, isso significa que y aumenta com x


# ex. analisar a covariância e correlação entre as variáveis milhas/galão e peso de um veiculo

my_data = mtcars

install.packages("ggpubr")
library("ggpubr")

# plot que cria um scatterplot com mais algumas informações, como o coeficiente de correlação
ggscatter(my_data,x="mpg", y="wt", add="reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = 'pearson',
          xlab = "Autonomia", ylab = "Peso do veículo")

#covariancia
cov(my_data$mpg, my_data$wt)

#correlação
cor(my_data$mpg, my_data$wt)


# OBs
# a correlação não implica causalidade. não podemos afirmar que o peso do veiculo é o responsavel direto pela queda de autonomia
# precisamos buscar outras variaveis.
# estamos apresentando apenas uma correlação e não uma relação de causa