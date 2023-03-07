# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



# Data Import and Cleaning
week7_tbl <- read_csv(file = "../data/week3.csv") %>%
  mutate(timeStart = as.POSIXct(timeStart, tz = "UTC")) %>%
  mutate(condition = factor(condition, ordered = FALSE, levels = c("A", "B", "C"),labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, ordered = FALSE, levels = c("M", "F"),labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = difftime(timeEnd, timeStart, units = "mins"))





# Visualization
(ggpairs(week7_tbl[,5:13])) %>%
  ggsave("../figs/fig0.png",.)

fig1 <- ggplot(week7_tbl, aes(timeStart, q1)) +
  geom_point() +
  ylab("Q1 Score") + 
  xlab("Date of Experiment")
ggsave("../figs/fig1.png", fig1)  

fig2 <- ggplot(week7_tbl, aes(q1, q2, color = gender)) +
  geom_point(position = "jitter") +
  labs(color = "Participant Gender")
ggsave("../figs/fig2.png", fig2)  

fig3 <- ggplot(week7_tbl, aes(q1, q2, group = gender)) +
  geom_point(position = "jitter") +
  facet_wrap(gender~.) +
  xlab("Score on Q1") +
  ylab("Score on Q2")
ggsave("../figs/fig3.png", fig3)  

