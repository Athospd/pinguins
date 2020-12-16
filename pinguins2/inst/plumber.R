library(plumber)

#' @apiTitle API de teste


#' Teste de index
#'
#' @get /
#' @serializer json
index <- function(req, msg = "") {
  mtcars
}
