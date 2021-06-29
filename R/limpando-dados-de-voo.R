# tratando dados de voos do aeroporto de houston

install.packages("hflights")
library(hflights)
library(dplyr)
?hflights
flyghts = dplyr::tbl_df(hflights)
flyghts
class(flyghts)

# resumindo os tipos das variaveis
str(flyghts)
glimpse(flyghts)

# visualisando como data frame
data.frame(flyghts)

# filtrando dados com slice
flyghts[flyghts$Month == 1 & flyghts$DayofMonth == 1,]
flyghts[flyghts$Month == 1 & flyghts$DayofMonth == 1, 1:4]

# aplicando filter

dplyr::filter(flyghts, Month == 1, DayofMonth == 1)
dplyr::filter(flyghts, UniqueCarrier == 'AA' | UniqueCarrier == 'UA')
dplyr::filter(flyghts, UniqueCarrier %in% c('AA','UA'))

# filtrando colunas 
dplyr::select(flyghts, Year:DayofMonth, contains("Taxi"), contains("Delay"))

# organizando os dados
flyghts %>%
  dplyr::select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

flyghts %>%
  dplyr::select(Distance, AirTime) %>%
  dplyr::mutate(Speed = Distance / AirTime * 60)

flyghts %>%
  with(
  tapply(ArrDelay, Dest, mean, na.rm = TRUE)) %>%
  head

head(aggregate(ArrDelay ~ Dest, flyghts, mean))

flyghts %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = FALSE)

?tally  