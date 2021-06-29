library('tidyr')
library(ggplot2)

dados = data.frame(
  nome = c("Geografia", "Literatura", "Biologia"),
  Regiao_a = c(97,80,84),
  Regiao_b = c(86,91,91)
)
dados

dados %>%
  gather(Regiao, Nota_final, Regiao_a:Regiao_b)

####
set.seed(10)
df2 = data.frame(
  id = 1:4,
  acao = sample(rep(c("controle","tratamento"), each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
)
df2

# reshape 1
df_organizador1 = df2 %>%
  # aplica a pivotagem em todas as colunas exeto id e acao
  gather(key, time, -id, -acao)

head(df_organizador1)

# rechape 2

df_organizador2 = df_organizador1 %>%
  separate(key, into = c("localidade","tempo"), sep = "\\.")

df_organizador2 %>% head(8)

# reshape 3

df3 = data.frame(
  participante = c("p1","p2","p3","p4","p5","p6"),
  info = c("g1m","g1m","g1f","g1f","g2m","g2m"),
  day1score = rnorm(n=6,mean = 80, sd = 15),
  day2score = rnorm(n=6, mean=88, sd = 8)
)

df3

df3 %>% gather(day, score, c(day1score, day2score))

# fazendo o reshape e voltando ao estado anterior
df3 %>% 
  gather(day, score, c(day1score, day2score)) %>%
  spread(day, score)

# separate para criar coluna group e gender a partir da coluna info
df3 %>% 
  gather(day, score, c(day1score, day2score)) %>%
  separate(col=info, into = c("group","gender"),sep = 2)


# separate para criar coluna group e gender a partir da coluna info e juntando novamente
df3 %>% 
  gather(day, score, c(day1score, day2score)) %>%
  separate(col=info, into = c("group","gender"),sep = 2) %>%
  unite(infoAgain, group, gender)

# separate para criar coluna group e gender a partir da coluna info e juntando novamente
df3 %>% 
  gather(day, score, c(day1score, day2score)) %>%
  separate(col=info, into = c("group","gender"),sep = 2) %>%
  ggplot(aes(x=day, y=score)) +
  geom_point() +
  facet_wrap(~group) + 
  geom_smooth(method = "lm", aes(group=1),se = F)
