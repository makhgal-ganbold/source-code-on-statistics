#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
double sd_cpp(NumericVector x) {
  int n = x.length();
  double sum = 0;
  for (int i = 0; i < n; i++) {
    sum += x[i];
  }
  double mu = sum / n;
  sum = 0;
  for (int i = 0; i < n; i++) {
    sum += pow(x[i] - mu, 2);
  }
  return sqrt(sum / (n - 1));
}

/*** R
testthat::expect_equal(object = sd_cpp(1:6), expected = sd(1:6))
*/
