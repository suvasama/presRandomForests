The repository contains the codes used for my Women in Data Science conference presentation. You can find the slides for my presentation [here](https://www.dropbox.com/s/e6jpwi0y8eb8djg/grf_short.pdf?dl=0). I compared the performance of several random forests packages and showed how to generate confidence intervals for such models.

I am using California Housing dataset for estimates. You can download the dataset [here](https://www.dcc.fc.up.pt/~ltorgo/Regression/cal_housing.html). A modified version of the dataset is available at [Kaggle](https://www.kaggle.com/camnugent/california-housing-prices).

I fitted the model using four R models from different packages: linear regression from base R, random forest estimates from ranger and grf and extreme boosting from xgboost. A minimal amount of hyperparameter tuning was performed to improve the performance xgboost.

The repository is organized as follows
1. Load and preprocess data [here](main.R).
2. Visualize the data using [point plots](visualizations.R), [maps](maps.R) and [decision trees](reg_trees.R). I used the original dataset for visualizations and the preprocessed dataset to estimate the models.
3. Estimate the [models](models.R). That is, fit the models, make predictions and compute confidence intervals for predictions.Choose the optimal amount of trees by cross validation for xgboost. Also, plot figures of the most important features chosen by the models. Estimate variance and confidence intervals using grf.

A snapshot of names and versions of packages I used is available [here](packrat.loc).
