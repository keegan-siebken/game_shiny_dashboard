library(shiny)
library(tidyverse)
library(ggplot2)
library(DT)

# Read in data
game_sales <- read_csv(here::here("game_shiny/game_sales_data.csv"))