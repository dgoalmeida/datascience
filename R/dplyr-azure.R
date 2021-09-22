setwd('/Users/dgoalmeida/Documents/datascience/data/')

Azure = FALSE

if(Azure){
  restaurantes = maml.mapImputPort(1)
  ratings = maml.mapImputPort(2)
}else{
  restaurantes = read.csv('Restaurant feature data.csv',header = T, sep = ',', stringsAsFactors = F)
  ratings = read.csv('Restaurant ratings.csv', header = T, sep = ',', stringsAsFactors = F)
}

head(restaurantes)
#execuntando condição no dataset restaurantes
restaurantes = restaurantes[restaurantes$franchise=='f' & restaurantes$alcohol=='No_Alcohol_Served',]

require(dplyr)

df = as.data.frame(restaurantes %>%
                inner_join(ratings, by = 'placeID') %>%
                select(name, rating) %>%
                group_by(name) %>%
                summarise(ave_Ratings = mean(rating)) %>%
                arrange(desc(ave_Ratings)))

df              

if(Azure) maml.mapOutputPort("df")