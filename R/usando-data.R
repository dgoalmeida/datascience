hoje = Sys.Date()
hoje

class(hoje)
Sys.time()
Sys.timezone()

?strptime

# formatando datas
# %d dia do mes
# %m mes 
# %y ano
# %Y ano com 4 digitos
# %A dia da semana
# %a dia da semana abreviado
# %B mes 
# %b mes abreviado

as.Date("2018-06-28")
as.Date("Jun-28-18", format="%b-%d-%y")
as.Date("28 June, 2018", format = "%d %B, %Y")

format(Sys.Date(), format= "%d %B, %Y")
format(Sys.Date(), format= "hoje e %d %B, %Y")

# usando posixct para trabalhar com data/hora

as.POSIXct(Sys.Date())+1

data_de_hoje =  as.Date("2016-06-25")
data_de_hoje

my_time = as.POSIXct("2021-05-14 11:24:134")

data_de_hoje - as.Date(my_time)
data_de_hoje - my_time # erro de compatibilidade


# usando lubridate
install.packages("lubridate")
require(lubridate)

ymd("20180604")
dmy("04062020")
mdy("06042020")

chegada = ymd_hms("2016-01-01 12:00:00", tz = "Pacific/Auckland")
partida = ymd_hms("2011-01-01 14:00:00", tz = "Pacific/Auckland")

chegada
partida

second(chegada)
second(chegada) = 23
chegada

wday(chegada)
wday(chegada, label = TRUE)

interval(chegada, partida)
