library(tidyverse)
library(tidymodels)
library(palmerpenguins)
library(jsonlite)

penguins_df <- penguins %>%
  filter(!is.na(sex)) %>%
  select(-year, -island)

# Train Test Split
set.seed(123)
penguin_split <- initial_split(penguins_df, strata = sex)
penguin_train <- training(penguin_split)
penguin_test <- testing(penguin_split)

fit_rf <- rand_forest(trees = 1000, mode = "classification") %>%
  set_engine("ranger") %>%
  fit(sex ~ ., data = penguin_train) 

pred_test_rf <- fit_rf %>%
  predict(penguin_test) #%>%
  #bind_cols(penguin_test) %>%
  #rename(actual = sex, 
         #prediction = .pred) 


saveRDS(fit_rf,"final_penguin.rds")

write_json(penguin_test[1,-6], "sample.json") 


model.list <- vector(mode = "list")
model.list$fit_rf <- fit_rf

saveRDS(object = model.list, file = 'model_list.rds')
