# The goal of our file is to run life expectency and CO2 emissions versus population with gapminder
# Date: Jan 17, 2023
# Author: Marian Schmidt

#load in packages necessary for analysis
library("tidyverse")
library(readr)
library(ggprism)

#read in data for analysis
gapminder_1997 <- read_csv("gapminder_1997.csv")


#ploting data for visualization

#ggplot( data = gapminder_1997) #runing program but doesn't know what to run, order matters, layering the data

ggplot(data = gapminder_1997)+
  aes(x =gdpPercap) +
  labs(x = "GDP Per Capita")+
  aes(y = lifeExp)+
  labs(y = "Life Expectancy (years)")+
  geom_point()+
  labs(title = "Do People in Weathly Countries Live Longer?") +
  aes(color = continent) +
  labs(color = "Continent") +
  scale_color_brewer(palette = "Set1")


gapminder_data <- read.csv("gapminder_data.csv")
getwd()

view(gapminder_data)
dim(gapminder_data)
head(gapminder_data)
tail(gapminder_data)

#Predicting ggplot outputs

ggplot(data = gapminder_data) +
  aes(x=year, y=lifeExp, color=continent, group = country) +
  geom_line()

#learn about data with structure command
str(gapminder_data)

#making a box plot

ggplot(data = gapminder_data) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot()

"making a violin plot and jitter"
ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp,) +
  geom_violin(color = "green", fill ="purple")+
  geom_jitter(aes(size = pop), color = "red")
  
ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp,color = continent) +
  geom_violin()+
  geom_jitter(aes(size = pop))


#looning at one continuous histogram

ggplot(gapminder_1997)+
  aes(x = lifeExp)+
  geom_histogram(binwidth = 20)

#number of bins to be 20 instead of 30
#change the theme of the graph, defalt is gray theme_classic, or ggprism
library(ggprism)

ggplot(gapminder_1997)+
  aes(x = lifeExp)+
  geom_histogram(bins= 20)+
  theme_prism()

#createing facet wraps, multiple points in one variable
ggplot(gapminder_1997)+
aes(x = gdpPercap, y = lifeExp)+
  geom_point()+
  facet_wrap(vars(continent))


#facet grid
ggplot(gapminder_1997)+
  aes(x = gdpPercap, y = lifeExp)+
  geom_point()+
  facet_grid(rows = vars(continent))


#saving my plots and can change the sizes of the plot, always save the last plot

ggsave("figures/awsome_plot2.tiff", device = "tiff", width = 6, height = 4, units = "in")

