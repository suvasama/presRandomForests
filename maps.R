# maps of data by area
# use the unpreprocessed data

library(ggmap)

(map <- get_map(c(left = -124.4, 
                  right = -114.4, 
                  bottom = 32.4, 
                  top = 42)))

(map <- get_stamenmap(bbox = c(left = -124.4, 
                               right = -114.4, 
                               bottom = 32.4, 
                               top = 42), 
                      maptype= "watercolor"))

ggmap(map) + 
  stat_density2d(data = data, 
                 aes(x = longitude, y = latitude), size = .5) +
  stat_density2d(data = data, 
                 aes(x = longitude, y = latitude, 
                     fill = ..level.., alpha = ..level..),
                 size = .01, bins = 20, 
                 geom = "polygon") +
  scale_fill_gradient(low = "green", 
                      high = "red") +
  scale_alpha(range = c(0, .3), guide = F)

ggmap(map) + 
  geom_point(data = data, 
             aes(x = longitude, y = latitude, colour = medianHouseValue)) +
  labs(colour = "Median House Value", size = 24)

ggmap(map) + 
  geom_point(data = data, 
             aes(x = longitude, y = latitude, colour = medianIncome), 
             alpha = .4) + 
  scale_colour_gradient(low = "red", high = "blue") + 
  labs(colour = "Median Income", size = 24)

ggmap(map) + 
  geom_point(data = data, 
             aes(x = longitude, y = latitude, colour = housingMedianAge), 
             alpha = .8) + 
  scale_colour_gradient(low = "red", high = "blue") + 
  labs(colour = "Housing Median Age", size = 24)

ggmap(map) + 
  geom_point(data = data[totalRooms > 2500, ], 
             aes(x = longitude, y = latitude, colour = totalRooms), 
             alpha = .4) + 
  scale_colour_gradient(low = "red", high = "blue") + 
  labs(colour = "Number of Rooms", size = 24)

ggmap(map) + 
  geom_point(data = data[totalBedrooms > 2000, ], 
             aes(x = longitude, y = latitude, colour = totalBedrooms), 
             alpha = .5) + 
  scale_colour_gradient(low = "red", high = "blue") + 
  labs(colour = "Number of Bedrooms", size = 24)


