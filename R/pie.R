fatias = c(40,20,40)

paises = c("Brasil","Argentina","Chile")

#juntando os dois vetores
paises = paste(paises, fatias)
paises

paises = paste(paises, "%", sep = "")
paises

pie(fatias, labels = paises, col = c("darksalmon", "gainsboro", "lemonchiffon4"),
    main = 'Distribuicao de vendas')
