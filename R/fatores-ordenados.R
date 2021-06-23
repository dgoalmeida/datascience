animais = c("Zebra",'Rinoceronte',"Tigre")
animais
fac_animais = factor(animais)
fac_animais
class(fac_animais)


grad = c("Mestrado","Doutorado","Bacharelado","Mestrado","Mestrado")
grad
fac_graf = factor(grad, ordered = TRUE, levels = c("Doutorado","Mestrado","Bacharelado"))
is.ordered(fac_graf)
fac_graf
levels(fac_graf)

summary(fac_graf)
summary(grad)

vec2 = c('M','M','M','F','F','M','F','F','F','M','M','F','M','M')
vec2
fac_vec2 = factor(vec2)
fac_vec2
levels(fac_vec2) <- c("Femea","Macho")
fac_vec2
summary(fac_vec2)


# exemplo com data
data = c(1,2,3,1,2,3,1,2,3,1,2,3)
fData = factor(data)
fData

rData = factor(data, labels = c("I","II","III"))
is.ordered(rData)
rData
