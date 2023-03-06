# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)




# Data Import and Cleaning
week7_tbl <- read_csv(file = "../data/week3.csv") %>%
  mutate(timeStart = as.POSIXct(timeStart, tz = "UTC")) %>%
  mutate(condition = factor(condition, ordered = FALSE, levels = c("A", "B", "C"),labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, ordered = FALSE, levels = c("M", "F"),labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))

