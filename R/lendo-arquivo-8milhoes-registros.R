install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")

library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)

system.time(df_teste1 <- read.csv2("./data/TemperaturasGlobais.csv"))

system.time(df_teste2 <- read.table("./data/TemperaturasGlobais.csv"))

system.time(df_teste3 <- fread("./data/TemperaturasGlobais.csv"))

cidadesBrasil = subset(df_teste3, Country == 'Brazil')
cidadesBrasil = na.omit(cidadesBrasil)

head(cidadesBrasil)
nrow(df_teste3)
nrow(cidadesBrasil)
dim(cidadesBrasil)

cidadesBrasil$dt = as.POSIXct(cidadesBrasil$dt,format='%Y-%m-%d')
cidadesBrasil$Month = month(cidadesBrasil$dt)
cidadesBrasil$Year = year(cidadesBrasil$dt)

head(cidadesBrasil)

plm = subset(cidadesBrasil, City == 'Palmas')
plm = subset(plm, Year %in% c(1796,1846,1896,1946,1996,2012))

crt = subset(cidadesBrasil, City == 'Curitiba')
crt = subset(crt, Year %in% c(1796,1846,1896,1946,1996,2012))

recf = subset(cidadesBrasil, City == 'Recife')
recf = subset(recf, Year %in% c(1796,1846,1896,1946,1996,2012))

p_plm = ggplot(plm, aes(x=(Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mes") +
  ylab("Temperatura media") +
  scale_color_discrete("") + 
  ggtitle("Temperatura Media ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))
  
p_crt = ggplot(crt, aes(x=(Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mes") +
  ylab("Temperatura media") +
  scale_color_discrete("") + 
  ggtitle("Temperatura Media ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))
  
p_recf = ggplot(recf, aes(x=(Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mes") +
  ylab("Temperatura media") +
  scale_color_discrete("") + 
  ggtitle("Temperatura Media ao longo dos anos em Recife") +
  theme(plot.title = element_text(size = 18))

p_plm
p_crt
p_recf