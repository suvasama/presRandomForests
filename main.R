# LOAD DATA

library(data.table)
library(here)

path = here("Data", 
            "cal_housing.data")

col_names = c("longitude", 
              "latitude", 
              "housingMedianAge", 
              "totalRooms",
              "totalBedrooms",
              "population",
              "households",
              "medianIncome",
              "medianHouseValue")

data <- fread(path, 
              col.names = col_names)

rm(path)

##-------------------------------------------------------------------------------------

# FEATURE ENGINEERING

cols <- c("totalRooms",
          "totalBedrooms")

setnames(
  data[, 
       (cols) := lapply(.SD, "/", data$population), 
       .SDcols = cols], 
         cols, 
  c("avg_rooms", 
    "avg_beds")
  )

setnames(
  data[, population := population / households], 
  "population", 
  "avg_population"
  )

cols <- c("medianHouseValue", 
          "housingMedianAge", 
          "households",
          "avg_population",
          "avg_rooms", 
          "avg_beds")

new_cols <- c("log_house_value", 
              "log_age", 
              "log_households",
              "log_avg_population",
              "log_avg_rooms", 
              "log_avg_beds")

setnames(
  data[, 
       (cols) := lapply(.SD, log), 
       .SDcols = cols], 
  cols, 
  new_cols
  )

data[, 
     `:=` (
       med_income2 = medianIncome^2, 
       med_income3 = medianIncome^3
       )
     ]

y <- data$log_house_value
X <- data
X$log_house_value <- NULL

# indices for train-test-split
set.seed(101)
train <- sample(1:nrow(data), 
                floor(0.75*nrow(data))
                )

prices_test = data[-train, 
                   .(log_house_value)]

rm(cols)
rm(new_cols)
