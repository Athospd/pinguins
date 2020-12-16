r <- plumb(file = 'plumber.R')

r$run(port = 8000)


POST(url = 'http://localhost:8000/predict?species=Adelie&bill_length_mm=38.1&bill_depth_mm=21.2&flipper_length_mm=191&body_mass_g=3800') %>% content()
