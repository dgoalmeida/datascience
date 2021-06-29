
library(dplyr)
library(readr)

sono_df = read.csv('./data/sono.csv')
View(sono_df)

head(sono_df)
class(sono_df)
str(sono_df)

# glimpse é simular ao str para exibir os tipos de dados no seu data frame
# mutate adiciona ou atualiza uma coluna existente no seu data frame
?mutate
glimpse(mutate(sono_df,peso_libras = sono_total / 0.453359237))

#contagem
count(sono_df,"cidade")
hist(sono_df$sono_total)

#amostragem
sample(sono_df, size = 10, replace = TRUE)


# funcao select
?select
dplyr::select(sono_df, "sono_total","cidade")
dplyr::select(sono_df, nome:pais)


# usando a funcao filter
dplyr::filter(sono_df, sono_total > 16)
dplyr::filter(sono_df, sono_total > 16, peso > 80)
dplyr::filter(sono_df, cidade %in% c("Recife","Curitiba") )

# arrange para ordenacao
sono_df %>% arrange(cidade) %>% head

# selecionando colunas, ordenando e exibindo apenas o head

sono_df %>%
  dplyr::select(nome, cidade, sono_total) %>%
  dplyr::arrange(nome, cidade) %>%
  head

sono_df %>%
  dplyr::select(nome, cidade, sono_total) %>%
  dplyr::arrange(nome, cidade) %>%
  dplyr::filter(sono_total > 16) %>%
  head


# ordenando de forma decrecente
sono_df %>%
  dplyr::select(nome, cidade, sono_total) %>%
  dplyr::arrange(desc(nome), cidade) %>%
  dplyr::filter(sono_total > 16) %>%
  head

# usando a funcao mutate
sono_df %>%
  dplyr::mutate(novo_indice = sono_total / peso) %>%
  head
head(sono_df)

# usando a funcao sumaize para ter um resumo

sono_df %>%
  dplyr::summarise(media_sono = mean(sono_total))

sono_df %>%
  dplyr::summarise(media_sono = mean(sono_total), 
                   min_sono = min(sono_total), 
                   max_sono = max(sono_total),
                    total = n())
