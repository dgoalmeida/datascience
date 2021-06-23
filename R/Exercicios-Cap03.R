# Lista de Exercícios - Capítulo 3

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
# setwd("C:/FCD/BigDataRAzure/Cap02")
getwd()

# Exercício 1 - Pesquise pela função que permite listar todos os arquivo no diretório de trabalho
list.files(".")

# Exercício 2 - Crie um dataframe a partir de 3 vetores: um de caracteres, um lógico e um de números
cr = c("a","b","c","d","e","f")
lo = c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE)
num = c(1:6)

df = data.frame(letra = cr, logico = lo, numerico = num )
df

# Exercício 3 - Considere o vetor abaixo. 
# Crie um loop que verifique se há números maiores que 10 e imprima o número e uma mensagem no console.

# Criando um Vetor
vec1 <- c(12, 3, 4, 19, 34)
vec1
for(i in vec1) {
  if(i > 10){
    print(paste(i,"Maior que 10"))
  }
  else{
    print(paste(i, "Menor que 10"))
  }
}

# Exercício 4 - Conisdere a lista abaixo. Crie um loop que imprima no console cada elemento da lista
lst2 <- list(2, 3, 5, 7, 11, 13)
lst2

for(i in lst2) {
    print(i)
}

# Exercício 5 - Considere as duas matrizes abaixo. 
# Faça uma multiplicação element-wise e multiplicação normal entre as materizes
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1
mat2 <- t(mat1)
mat2

# Multiplicação element-wise
mat3 = mat1 + mat2
mat3

# Multiplicação de matrizes
mat4 = mat1 %*% mat2
mat4

# Exercício 6 - Crie um vetor, matriz, lista e dataframe e faça a nomeação de cada um dos objetos

vetor = c(1:5)
names(vetor) = c('a', 'b','c','d','e')
vetor

matrix1 = matrix( c(1:4), nrow = 2)
matrix1
dimnames(matrix1) = list(c('a','b'))
matrix1

list1 = list(c(1:3),c(1:2))
list1
names(list1) = list(c('dim1'),c('dim2'))
list1

df = data.frame( c(1:3))
df
colnames(df) = c('col1')
rownames(df) = c('r1','r2','r3')
df

# Exercício 7 - Considere a matriz abaixo. Atribua valores NA de forma aletória para 50 elementos da matriz
# Dica: use a função sample()
mat2 <- matrix(1:90, 10)
mat2

mat2[sample(1:50, 10)] = NA
mat2
# Exercício 8 - Para a matriz abaixo, calcule a soma por linha e por coluna
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1

colSums(mat1)
rowSums(mat1)

# Exercício 9 - Para o vetor abaixo, ordene os valores em ordem crescente
a <- c(100, 10, 10000, 1000)
a

sort(a, decreasing = TRUE)

# retorna apenas o index
order(a)
a[order(a)]

# # Exercício 10 - Imprima no console todos os elementos da matriz abaixo que forem maiores que 15
mat1 <- matrix(c(1:50), nrow = 5, ncol = 5, byrow = T)
mat1

for(i in mat1) {
  for(j in i){
    if(j > 15)
      print(paste(j,'Maior que 15'))
  }
}