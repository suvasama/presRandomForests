
library(ggplot2)
library(ranger)
library(xgboost)

source(here("R", "rmse.R"))

# Model 1: Linear regression

lm_fit <- lm(log_house_value ~., 
             data = data[train, ])

prices_test$lm_pred <- predict(lm_fit, 
                               X[-train, ])

rmse(prices_test$log_house_value, 
     prices_test$lm_pred)


##------------------

## Model 2: Random forest using ranger

library(grf)

ranger_fit <- ranger(log_house_value ~., 
                     data = data[train, ], 
                     keep.inbag=TRUE)

ranger_pred <- predict(ranger_fit, 
                       X[-train, ], 
                       type = "se")

rmse(prices_test$log_house_value, 
     ranger_pred$predictions)

max(importance(ranger_fit))

rel_imp <- setDT(as.data.frame(importance(ranger_fit) / 
                                 max(importance(ranger_fit))), 
                 keep.rownames = T)

setnames(rel_imp, 
         colnames(rel_imp),
         c("coeff", "importance"))

setorder(rel_imp, importance, coeff)
pos <- rel_imp$coeff

ggplot(data = rel_imp, aes(x = coeff, y = importance)) + 
  geom_bar(stat = "identity", fill = "steelblue4") +
  scale_x_discrete(limits = pos) +
  coord_flip()

importance_pvalues(ranger_fit)


##----------------------

## Model 3: generalized random forest

reg_for_fit <- regression_forest(X[train, ], y[train], 
                                 num.trees = 10000)

prices_test$reg_for_pred <- predict(reg_for_fit, 
                                    X[-train, ])

rmse(prices_test$log_house_value, 
     prices_test$reg_for_pred)

ggplot(prices_test, 
       aes(x = reg_for_pred, y = log_house_value)
       ) +
  geom_point(colour = "olivedrab") +
  geom_abline()+
  xlab("Prediction") +
  ylab("True Value")

pred_ci <- predict(reg_for_fit, X[-train, ], 
                   estimate.variance = T)

pred_ci <- as.data.table(pred_ci)

pred_ci[, 
        `:=` (
          low_ci = predictions + 2.576 * sqrt(variance.estimates), 
          up_ci = predictions - 2.576 * sqrt(variance.estimates)
          )
        ]

pred_ci <- cbind(pred_ci, data[-train, ])

# Take a random sample of the data for illustration
set.seed(102)
ex <- sample(1:nrow(pred_ci),
             nrow(pred_ci) / 50)

ggplot(data = pred_ci[ex, ], 
       aes(y = predictions, x = log_house_value)) +
  geom_point(colour = "steelblue4") +
  geom_abline() +
  geom_errorbar(aes(ymin = low_ci, ymax = up_ci), 
                width = 0.05, colour = "steelblue4") +
  xlab("Prediction") +
  ylab("True Value")


##------- 

# Model 4: xgboost

cv <- xgb.cv(data = as.matrix(X[train, ]),
             label = y[train],
             objective = "reg:linear",
             nrounds = 500, nfold = 5, eta = 0.3, depth = 6)

elog <- as.data.frame(cv$evaluation_log)
(nrounds <- which.min(elog$test_rmse_mean))

xgboost_fit <- xgboost(data = as.matrix(X[train, ]),
                        label = y[train],
                        nrounds = nrounds,
                        objective = "reg:linear", eta = 0.3, depth = 6)

prices_test$pred_xgboost <- predict(xgboost_fit, 
                                    as.matrix(X[-train, ])) 

rmse(prices_test$log_house_value, 
     prices_test$pred_xgboost)

ggplot(prices_test, 
       aes(x = pred_xgboost, y = log_house_value)) +
  geom_point(colour = "deeppink1") +
  geom_abline()+
  xlab("Prediction") +
  ylab("True Value")

xgb.ggplot.importance(
  xgb.importance(
    colnames(X), model = xgboost_fit
    ), rel_to_first = T, measure = "Frequency"
  ) + 
  theme(legend.position = "none", text = element_text(size = 16)) +
  scale_fill_brewer(palette = "PiYG")
  

# not run
library(DiagrammeR)

(gr <- xgb.plot.tree(model = xgboost_fit, render = T))
export_graph(gr, 'xgboost_tree.png', width = 1500, height = 1900)
