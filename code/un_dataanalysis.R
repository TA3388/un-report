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
  

#Working with messy data: skippng the first two rows and renaming the columns

co2_emmsissions_dirty <-read_csv("data/co2-un-data.csv", skip = 2,
         col_names = c("region", "country", "year", "series", "value", "footnote", "source"))

co2_emmsissions_dirty%>%
  select(country, year, series, value)%>%
  mutate(series = recode(series,"Emissions (thousand metric tons of carbon dioxide)" = "total_emissions",
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions"))%>%
  pivot_wider(names_from = series, values_from = value)

#combining co2 data, and population data

#filter data from 2005 and select to remove column from emission data

co2_emissions <- co2_emmsissions_dirty%>%
  select(country, year, series, value)%>%
  mutate(series = recode(series,"Emissions (thousand metric tons of carbon dioxide)" = "total_emissions",
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions"))%>%
  pivot_wider(names_from = series, values_from = value)%>%
  filter(year==2005)%>%
  select(-year)

##Bringing in 2007 population data

gapminder_data_2007 <- read_csv("data/gapminder_data.csv")%>%
  filter(year==2007)%>%
  select(country, pop, lifeExp, gdpPercap) #or select what you don't want to see

#inner join: only include what is shared between two tables

inner_join(co2_emissions, gapminder_data_2007, by = "country")

anti_join(co2_emissions, gapminder_data_2007, by = "country")

anti_join(gapminder_data_2007, co2_emissions, by = "country")

full_join(co2_emissions, gapminder_data_2007)%>%
  View()


