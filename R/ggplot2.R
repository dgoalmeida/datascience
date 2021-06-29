install.packages('ggplot2')
library("ggplot2")

data(tips, package = 'reshape2')
View(tips)
qplot(total_bill, tip, data = tips, geom = "point")

# adicionando uma camada

camada1 = geom_point(
  mapping = aes(x=total_bill, y = tip, color = sex),
  data = tips,
  size = 3
)
ggplot() + camada1

# construindo modelo de regrecao

modelo_base = lm(tip ~ total_bill, data = tips)
modelo_fit = data.frame(
  total_bill = tips$total_bill,
  predict(modelo_base, interval = "confidence")
)

# camada 2

camada2 = geom_line(
  mapping = aes(x = total_bill, y = fit),
  data = modelo_fit,
  color = "red"
)

ggplot() + camada1 + camada2

head(modelo_fit)


# camada 3 (intervalo de confianca )

camada3 = geom_ribbon(
  mapping = aes(x=total_bill, ymin = lwr, ymax=upr),
  data = modelo_fit,
  alpha= 0.3
)

ggplot() + camada1 + camada2 + camada3

# gerando o mesmo plot com apenas um comando
myplot = ggplot(tips, aes(x=total_bill,y=tip)) +
  geom_point(aes(color=sex)) +
  geom_smooth(method = 'lm')

class(myplot)
print(myplot)

# scatterPlot com linha de regressao

#dados

data = data.frame(cond = rep(c("Obs1","Obs2"),
                             each=10), var1 = 1:100 +
                    rnorm(100,sd=9), var2 = 1:100 +
                    rnorm(100,sd=16))

ggplot(data, aes(x=var1,y=var2)) +
  geom_point(shape = 1) + 
  geom_smooth(method = lm, color="red", seq = FALSE)

# barplot
data = data.frame(grupo = c("A","B","C","D"),
                  valor = c(33,62,56,67),
                  num_obs = c(100,500,459,342))

data$right = cumsum(data$num_obs) + 30 * c(0:(nrow(data)-1))
data$left = data$right - data$num_obs

ggplot(data, aes(ymin = 0)) +
  geom_rect(aes(xmin = left, xmax = right,
                ymax = valor, colour = grupo, fill = grupo)) +
                xlab("numero de observacoes") + ylab("valor")

# usando mtcars (dispersao)

ggplot(data = mtcars,
       aes(x=disp,y=mpg,
           colour = as.factor(am))) + geom_point()

ggplot(data = mtcars,
       aes(x=disp,y=mpg,
           colour = cyl)) + geom_point()

#definindo tamanho dos pontos
ggplot(data = mtcars,
       aes(x=disp,y=mpg,
           colour = cyl, size = wt)) + geom_point()

# definindo forma geometrica usando os geoms
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + geom_boxplot()

ggplot(mtcars, aes(x=mpg), binwidth=30) + geom_histogram()

ggplot(mtcars, aes(x = as.factor(cyl))) + geom_bar()


# personalizando os graficos

ggplot(mtcars, aes(x=as.factor(cyl), y = mpg,
                   colour = as.factor(cyl))) + geom_boxplot()
       
ggplot(mtcars, aes(x=as.factor(cyl), y = mpg,
                   fill = as.factor(cyl))) + geom_bar()

# adicionando legendas

ggplot(mtcars, aes(x=as.factor(cyl),
                   fill = as.factor(cyl))) + 
                  geom_bar()+
                  labs(fill = "cyl") +
                  theme(legend.position = "top")
