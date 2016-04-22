#
# Nonparametric Tests in R language
# Author: galaa
# Created on 2016/04/22 11:46:00
#


#
# Kolmogorov - Smirnov Test (goodness of fit)
#

X <- c(0.3, 0.3, 0.5, 0.5, 0.8, 1.4, 2.2, 2.8, 3.4, 8.6);

ks.test(X, "pexp", 0.5); # exponential distribution with parameter 0.5

#
# Chi-squared test for given probabilities (goodness of fit)
#

X <- c(8, 1, 1) # frequency
p <- c(0.78, 0.17, 0.04); # probability distribution

chisq.test(X, p = p, rescale.p = TRUE);

#
# Kolmogorov - Smirnov Test (comparison of two groups)
#

X = c(3.8, 2.6, 3.5, 3.6, 3.4);
Y = c(3.7, 2.5, 3.0, 3.5);

ks.test(X, Y);

#
# Kruskal-Wallis test (comparison of multiple groups)
#

X1 <- c(68, 63, 58, 51, 41);
X2 <- c(78, 69, 58, 57, 53);
X3 <- c(94, 82, 73, 67, 66, 61);
X4 <- c(54, 51, 32, 74, 65, 80);

kruskal.test(list(X1, X2, X3, X4));

# another way

X <- c(X1, X2, X3, X4);
Group <- factor(rep(1:4, c(length(X1), length(X2), length(X3), length(X4))));

kruskal.test(X, Group);

#
# Pearson's Chi-squared test (independence)
#

X = matrix(c(8, 9, 13, 21, 11, 2, 4, 6, 8, 8), nrow = 2, byrow = TRUE); # contingency table as matrix

chisq.test(X);

#
# Pearson's product-moment correlation (independence)
#

X <- c(65, 80, 100, 90, 80, 70, 80, 90, 80, 90, 100, 90, 80, 70, 90, 70, 80, 80, 100, 95);
Y <- c(99, 107, 110, 108, 105, 105, 108, 109, 100, 119, 130, 107, 102, 98, 118, 81, 108, 112, 118, 124);

cor.test(X, Y);
