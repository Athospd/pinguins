#' @export
iniciar_api <- function() {
  p <- plumber::plumb(system.file("plumber.R", "pinguins2"))
}
