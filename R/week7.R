# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
library(GGally)


# Data Import and Cleaning
week7_tbl <- read_csv(file = "../data/week3.csv") %>%
  mutate(timeStart = ymd_hms(timeStart)) %>%
  mutate(condition = factor(condition, ordered = FALSE, levels = c("A", "B", "C"),labels = c("Block A", "Block B", "Control"))) %>%
  mutate(gender = factor(gender, ordered = FALSE, levels = c("M", "F"),labels = c("Male", "Female"))) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = as.numeric(difftime(timeEnd, timeStart, units = "mins")))





# Visualization
(ggpairs(week7_tbl[,5:13])) %>%
  ggsave("../figs/fig0.png",.)

fig1 <- ggplot(week7_tbl, aes(timeStart, q1)) +
  geom_point()  + 
  labs(x= "Date of Experiment", y ="Q1 Score") 
ggsave("../figs/fig1.png", fig1, width = 7, height = 4, units = "in")  


fig2 <- ggplot(week7_tbl, aes(q1, q2, color = gender)) +
  geom_point(position = "jitter") +
  labs(color = "Participant Gender")
ggsave("../figs/fig2.png", fig2, width = 7, height = 4, units = "in")  

fig3 <- ggplot(week7_tbl, aes(q1, q2)) +
  geom_point(position = "jitter") +
  facet_wrap(.~gender) +
  labs(x = "Score on Q1", y = "Score on Q2") 
ggsave("../figs/fig3.png", fig3, width = 7, height = 4, units = "in")  


fig4 <- ggplot(week7_tbl, aes(gender,timeSpent)) + 
  geom_boxplot() +
  labs(x = "Gender", y = "Time Elapsed (mins)") 
ggsave("../figs/fig4.png", fig4, width = 7, height = 4, units = "in")  


fig5 <- ggplot(week7_tbl, aes(q5, q7, color = condition)) + 
  geom_point(position = "jitter") +
  geom_smooth(method = "lm", se = F) +
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#E0E0E0"), legend.title = element_text(size =10)) +
  labs(color = "Experimental Condition", x = "Score on Q5", y = "Score on Q7")
ggsave("../figs/fig5.png", fig5, width = 7, height = 4, units = "in") 

