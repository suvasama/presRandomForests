
head(data)
summary(data)
cor(data)

##------------------------------------------------------------------------

library(ggplot2)

ggplot(data = data, aes(y = log_house_value, x = medianIncome)) + 
  geom_point(alpha = .4, colour = "purple4", size = 0.5) +
  ylab("Log of Median House Value") +
  xlab("Median Income") +
  theme(text = element_text(size = 16))

ggplot(data = data, aes(y = log_house_value, x = log_age)) + 
  geom_point(alpha = .4, colour = "purple4", size = 0.5) +
  ylab("Log of Median House Value") +
  # ylab("Median Income") +
  theme(text = element_text(size = 16))

ggplot(data = data, aes(x = log_house_value, y = log_avg_rooms)) + 
  geom_point(alpha = .4, colour = "purple4", size = 0.5) +
  xlab("Log of Median House Value") +
  #  ylab("Median Income") +
  theme(text = element_text(size = 16))

ggplot(data = data, aes(x = log_house_value, y = log_avg_beds)) + 
  geom_point(alpha = .4, colour = "purple4", size = 0.5) +
  xlab("Log of Median House Value") +
  #  ylab("Median Income") +
  theme(text = element_text(size = 16))

ggplot(data = data, aes(x = log_house_value, y = log_households)) + 
  geom_point(alpha = .4, colour = "purple4", size = 0.5) +
  xlab("Median House Value") +
  #  ylab("Median Income") +
  theme(text = element_text(size = 16))

ggplot(data = data, aes(x = log_house_value, y = log_avg_population)) + 
  geom_point(alpha = .4, colour = "purple4", size = 0.5) +
  xlab("Median House Value") +
  #  ylab("Median Income") +
  theme(text = element_text(size = 16))



