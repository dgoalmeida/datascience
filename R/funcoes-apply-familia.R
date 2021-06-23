# se estiver trabalhando com list, nuemrioc, character (list/vector) utilize sapply() ou lapply()
# se estiver trabalhando com matrix, data.frame (agregacao por coluna) utilize by() ou tapply()
# se estiver trabalhando com operacoes por linha ou operacoes especificas use apply()

#usando loop simples

lista1 = list(a= (1:20), b = (35:67))
valor_a = 0
valor_b = 0

for (i in lista1$a){
  valor_a = valor_a +i
}
valor_a

for(j in lista1$b){
  valor_b = valor_b+j
}
valor_b

#usando sapply
?sapply

sapply(lista1,sum)
sapply(lista1, mean)

# apply para matrix
x = matrix(c(20,13,32,65,45,12,76,49,82), nrow = 3,byrow = T)
x
apply(x, mean) # vai dar erro porque esta faltando o atributo de orientacao
apply(x, 1, mean) # executando com orientacao de linha
apply(x, 2, mean) # execurtando com orientacao decoluna
apply(x, 1, plot)

escola = data.frame(Aluno = c('Bob','Tereza','Marta','Felipe','Diego','Leticia'),
                    Fisica = c(91,82,75,97,62,74),
                    Matematica = c(99,100,86,92,91,87),
                    Quimica = c(56,72,49,68,59,77))
escola

#criando campo para media e deixando valor preenchido
escola$Media = NA
escola

#usando apply para pegar todas as linhas do df escole e, apenas as colunas 2,3,4 (slice) e aplicando a media
escola$Media = apply(escola[,c(2,3,4)],1,mean)

escola
escola$Media = round(escola$Media)
escola

# usando tapply()

?gl
?runif
tabela_basquete = data.frame(equipe = gl(5,5,labels = paste("Equipe", LETTERS[1:5])),
                             jogador = sample(letters,25),
                             num_cestas = floor(runif(25, min=0,max=50)))
head(tabela_basquete)
summary(tabela_basquete)

tapply(tabela_basquete$num_cestas, tabela_basquete$equipe, sum)
tapply(tabela_basquete$num_cestas, tabela_basquete$equipe, mean)

#usando by()
?sample
dat = sample(iris,size = 5, replace = TRUE)

dat$Species = factor(dat$Species)
dat
dat$c
by(dat, dat$Species, function(x) {
  mean.pl <- mean(x$Petal.Length)
})

#lapply()

lista1 = list(a=(1:10),b=(45:77))
lapply(lista1, sum)
sapply(lista1, sum)

# vapply()

vapply(lista1, fivenum, c(Min. = 0,
                          "1stqu."=0,
                          Median = 0,
                          "3rd Qu." = 0,
                          Max=0))

# replicate()

replicate(7,runif(10))

#mapply() 
mapply(rep, 1:4, 4:1)

#rapply()
lista2 = list(a=c(1:5), b=(6:10))

rapply(lista2, sum)
rapply(lista2, sum, how = "list")
