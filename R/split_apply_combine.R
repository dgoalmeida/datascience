install.packages("gapminder")

library(plyr)
library(gapminder)

# separando o dataframe por continente e max de expectativa de vida
head(gapminder)
df = ddply(gapminder, ~ continent,
      summarize,
      max_le = max(lifeExp))
levels(df$continent)

# separando o dataframe por continente e total de paises
ddply(gapminder, ~ continent,
      summarise,
      n_uniq_countries = length(unique(country)))

ddply(gapminder, ~ continent,
      summarise,
      min = min(lifeExp),
      max = max(lifeExp),
      median = median(gdpPercap))
