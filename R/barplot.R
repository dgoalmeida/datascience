dados = matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67), nrow = 3, byrow = T)
dados

# nomeando linhas e colunas da matrix
colnames(dados) = c("0", "1-150","151-300",">300")
rownames(dados) = c("Joven","Adulto","Idoso")
dados

barplot(dados)
barplot(dados, beside = T)

barplot(dados, col= c("steelblue2","tan2","seagreen4"), beside = T, legend.text =  c("Joven","Adulto","Idoso") )

#adicionando legendas
barplot(dados, col= c("steelblue2","tan2","seagreen4"), beside = T)
legend("topright", pch=5, col = c("steelblue2","tan2","seagreen4"), legend = c("Joven","Adulto","Idoso"))

?legend

# barplot da transposta da matrix
barplot(t(dados), col= c("steelblue2","tan2","seagreen4","tan4"), beside = T, legend.text =  c("0", "1-150","151-300",">300") )
