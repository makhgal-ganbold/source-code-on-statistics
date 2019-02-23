#
# Training Program for R Langauge
# Topic A6 - Efficent Programming
# Author: galaa (www.galaa.mn)
# Copyright (c) 2019 Makhgal
# Created on 2019/02/23
#

set.seed(seed = 10)
x <- rnorm(n = 1e6, mean = -1.5, sd = 1.25)

profvis::profvis(
  expr = {
    breaks <- seq(from = min(x), to = max(x), "length.out" = 1 + round(log2(length(x))))
    freq <- table(cut(x = x, breaks = breaks))
    p <- pnorm(q = breaks, "mean" = mean(x), "sd" = sd(x))
    p <- diff(p)
    p <- p / sum(p)
    rm(breaks)
  },
  interval = 0.005 # 5 ms
)
chisq.test(x = freq, p = p)

chisq.test.R <- function (x, p) {
  res <- list()
  p <- sum(x) * p
  res$statistic <- sum((x - p) ** 2 / p)
  res$parameter <- length(x) - 1
  res$p.value <- pchisq(q = res$statistic, df = res$parameter, lower.tail = FALSE)
  res
}
chisq.test.R(x = freq, p = p)

rbenchmark::benchmark(
  "built-in" = chisq.test(x = freq, p = p),
  "user-function" = chisq.test.R(x = freq, p = p),
  columns = c("test", "elapsed", "relative"),
  replications = 1000, order = "elapsed"
)

Rcpp::cppFunction(code = '
List chisq_test_cpp (NumericVector x, NumericVector p) {
  NumericVector np = sum(x) * p;
  double t = sum(pow(x - np, 2) / np);
  int df = x.length() - 1;
  double p_value = R::pchisq(t, df, false, false);
  return List::create(Named("statistic") = t, _["parameter"] = df, _["p.value"] = p_value);
}')
chisq_test_cpp(x = freq, p = p)

rbenchmark::benchmark(
  "built-in" = chisq.test(x = freq, p = p),
  "user-function-R" = chisq.test.R(x = freq, p = p),
  "user-function-C++" = chisq_test_cpp(x = freq, p = p),
  columns = c("test", "elapsed", "relative"),
  replications = 1000, order = "elapsed"
)

library(magrittr); set.seed(seed = 10)
{rnorm(n = 1e6, "mean" = -1.5, "sd" = 1.25) -> x} %>%
  list(
    "MIN" = min(.), "MAX" = max(.),
    "N.POINTS" = 1 + {.} %>% length %>% log2 %>% round
  ) %$%
  seq(from = MIN, to = MAX, "length.out" = N.POINTS) %>%
  {
    cut(x = x, breaks = .) %>%
      table ->>
      freq;
    pnorm("q" = ., "mean" = mean(x), "sd" = sd(x)) %>%
      diff %>%
      {. / sum(.)} ->>
      p;
  }
chisq.test(x = freq, p = p)
