library(tidyverse)
gapminder_data <- read.csv("data/gapminder_data.csv")

summarise(gapminder_data, averageLifeExp = mean(lifeExp), medianLifeExp = median(lifeExp))

#Learning to Pipe [%>%]

gapminder_data%>%
  summarise(averageLifeExp = mean(lifeExp))

#Saving the data of my summary by asigning an object

gapminder_summary <-gapminder_data%>%
  summarise(averageLifeExp = mean(lifeExp))

#Filtering for specific rows

gapminder_summary_2007<- gapminder_data%>%
  filter(year==2007)%>%
  summarise(average = mean(lifeExp))

#challenge: average gdp for first year in data set

gapminder_data%>%
  summarise(Firstyear = min(year))

gdp_average_1952 <- gapminder_data%>%
  filter(year==1952)%>%
  summarise(average = mean(gdpPercap))


#Using group_by()

gapminder_data%>%
  group_by(year, continent)%>%
  summarise(average = mean(lifeExp),
          error = sd(lifeExp))

# Mutate function to add a new column

gapminder_data%>%
  mutate(gdp = pop * gdpPercap)

#Challenge: mutate a new column which is population in millions

gapminder_data%>%
  mutate(pop_in_millions = (pop / 1000000))

#Only selecting or removing the columns you need using select()

gapminder_data%>%
  select(pop, year)

gapminder_data%>%
  select(-continent, -pop)


#How to reshape the data table by pivot wider

gapminder_data%>%
  select(country, continent, year, lifeExp)%>%
  pivot_wider(names_from = year, values_from = lifeExp)
  # %>% View() to view data
  








