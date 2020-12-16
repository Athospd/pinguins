library(plumber)
library(tidymodels)
library(tidyverse)
library(httr)
library(magrittr)

model <- readRDS("model_list.rds")


#* Health Check - Is the APi running
#* @get /teste
status <- function(){
 list(
   status = "All Good",
   time = Sys.time()
 )
}

#*@param species
#*@param bill_length_mm
#*@param bill_depth_mm
#*@param flipper_length_mm
#*@param body_mass_g
#* @post /predict
#* @serializer csv
CalculatePrediction <- function(req,
  species,
  bill_length_mm,
  bill_depth_mm,
  flipper_length_mm,
  body_mass_g
  ){
  new_data <- read.table(text = req$args$csv$penguins.csv, sep = ",", header = TRUE) %>% glimpse()
  new_data <- na.omit(new_data)
  y.pred <- predict(model$fit_rf, new_data = new_data)

  return(y.pred)
}

