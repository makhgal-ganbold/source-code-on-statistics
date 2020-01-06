#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

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


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
testthat::expect_equal(object = sd_cpp(1:6), expected = sd(1:6))
*/
