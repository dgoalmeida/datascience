
# configurando conexão com api do twitter
# configurando token de acesso
#install.packages('twitteR')
library(twitteR)

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
twitteR::setup_twitter_oauth()


# fazendo buscas na api do Twitter
?twitteR::dmFactory
tw = twitteR::searchTwitter('@pagseguro + conta + -filter:retweets', n=500)
df = twitteR::twListToDF(tw)
View(df)

# Analise Exploratória
install.packages('tm')

#criando vetor com os dados retornados da pesquisa ao twitter
df_corpus = tm::Corpus(tm::VectorSource(df[,1]))

#Criando uma função para substituir caracrer po espaço
toSpace <- tm::content_transformer(function (x , pattern ) gsub(pattern, " ", x))
# alterando dados para menusculo
df_corpus = tm::tm_map(df_corpus, tm::content_transformer(tolower))
# removendo caracteres especiais por espaço
df_corpus = tm::tm_map(df_corpus, toSpace, "/")
df_corpus = tm::tm_map(df_corpus, toSpace, "@")
df_corpus = tm::tm_map(df_corpus, toSpace, "\\|")
#removendo numeros
df_corpus = tm::tm_map(df_corpus, tm::removeNumbers)
# removendo pontuação
df_corpus = tm::tm_map(df_corpus, tm::removePunctuation)
# removendo stopwords 
df_corpus = tm::tm_map(df_corpus, tm::removeWords, tm::stopwords('portuguese'))
# removendo espaço em branco
df_corpus = tm::tm_map(df_corpus, tm::stripWhitespace)
# removendo palavras que ficaram após executar o stopwords
df_corpus = tm::tm_map(df_corpus, tm::removeWords, c('pagseguro','pagbank','https','tco','...', 'vlrtffnvff','dlobmdpjex'))
# efetuando a lemantização (alterar palavra para o seu radical simples )
df_corpus = tm::tm_map(df_corpus, tm::stemDocument)


# Build a term-document matrix
df_dtm <- tm::TermDocumentMatrix(df_corpus)
dtm_m <- as.matrix(df_dtm)
# Sort by descearing value of frequency
dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)
# Display the top 5 most frequent words
tail(dtm_d, 5)


# Plot com as palavras mais frequentes
barplot(dtm_d[1:5,]$freq, las = 2, names.arg = dtm_d[1:5,]$word,
        col ="lightgreen", main ="Palavras mais frequentes",
        ylab = "Frequencia")

# criando nuvem de palavras
#install.packages('RColorBrewer')
library(RColorBrewer)

wordcloud::wordcloud(words = dtm_d$word, freq = dtm_d$freq, min.freq = 2,
          max.words=50, random.order=FALSE, rot.per=1.0, 
          colors=brewer.pal(8, "Dark2"))

#Verificando associção de palavras
# verificando a correlação ente palavras
tm::findAssocs(df_dtm, terms = c('pagseguro', 'acessar'), corlimit = 0.30)

tm::findAssocs(df_dtm, terms = tm::findFreqTerms(df_dtm, lowfreq = 3), corlimit = 0.25)

# Análise de sentimentos
install.packages('syuzhet')
library(syuzhet)

result_vector = get_sentiment(df, language = 'Portuguese')

head(result_vector, 10)
summary(result_vector)

# Classificando emoções - lista de palavras que estão associadas a emoções
# (anger, fear, anticipation, trust, surprise, sadness, joy, and disgust)
# e sentimentos  (negative and positive).
print_sentiment = function(text){
  print(text)
  print(get_nrc_sentiment(text, language = 'portuguese'))
}

for (x in df[,1]){
  print_sentiment(x)
}

df_sent = get_nrc_sentiment(df[,1], language = 'portuguese')
td = data.frame(t (df_sent))
td_new <- data.frame(rowSums(td[2:50]))
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
str(df_sent)

library(ggplot2)

?barplot(count ~ sentiment,  data = td_new)
quickplot(sentiment, data=td_new, weight=count, geom="bar", fill=sentiment, ylab="count")+ggtitle("Pagseguro Conta sentiments")

###############################################################################
# Referencias:
# https://cran.r-project.org/web/packages/twitteR/twitteR.pdf
# https://rstudio-pubs-static.s3.amazonaws.com/132792_864e3813b0ec47cb95c7e1e2e2ad83e7.html
# https://www.red-gate.com/simple-talk/databases/sql-server/bi-sql-server/text-mining-and-sentiment-analysis-with-r/
# http://www.labape.com.br/rprimi/ds/text_mining.html