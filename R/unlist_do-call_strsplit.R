# usando unlist

list1 = list(1,"a",TRUE)
list1

class(list1)
vec1 = unlist(list1)
vec1
class(vec1)

list2 = list(v1 = 6, v2=list1, v3=vec1)
list2

vec2 = unlist(list2)
vec2

# usando do.call

data = list()
n=100

for (i in 1:n){
  data[[i]] = data.frame(index = i, char = sample(letters,1), z=rnorm(1))
}

data

do.call(rbind, data)

# comparando do.call e lapply

y = list(1:3,4:6,7:9)
y

lapply(y, sum)
do.call(sum,y)


# usando strsplit

texto = "Data Scoence academy"
strsplit(texto, " ")

dates = c("1998-11-01","2015-10-10","2021-12-12")
temp = strsplit(dates,"-")

# transformando uma lista em um matriz e fazendo um unlist

matrix(unlist(temp),ncol = 3, byrow = TRUE)


frase = "Muitas vezes temos que repetir algo diversas vezes e essas diveras vezes parece estraho"
palavras = strsplit(frase," ")[[1]]
unique(tolower(palavras))

# strsplit com data.frame
antes = data.frame(attr = 
                     c(1,20,4,6), 
                   tipo = c('pao_e_agua','agua_e_vinho','cafe_e_leite','chocolate_e_dente'))
antes

unlist(strsplit(as.character(antes$tipo),'_e_'))

# usndo stringr

str_split_fixed(antes$tipo,"_e_",2)
