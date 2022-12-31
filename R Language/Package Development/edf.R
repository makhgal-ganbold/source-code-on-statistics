#' @title edf function
#'
#' @description Computes the value of the left continuous empirical distribution function at a given point.
#'
#' @param x numeric scalar, function argument
#' @param X numeric vector, empirical data
#' @return numeric, left continuous empirical distribution function value
#' @export
#' @examples
#' edf(x = 0, X = c(- 1, 0, NA, 1));

edf <- function (x, X) {
  sum(X < x, na.rm = TRUE) / sum(!is.na(X))
}
