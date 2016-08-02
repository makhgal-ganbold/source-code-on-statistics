#' A edf function
#'
#' This function computes a value of the left continuous empirical distribution function at a given point
#' @param x: argument as numeric
#' @param X: empirical data as vector
#' @keywords empirical distribution function
#' @export
#' @examples
#' edf(x = 0, X = c(-1,0,1));

edf <- function (x, X) {
  sum(X < x, na.rm = TRUE) / length(which(!is.na(X)));
}
