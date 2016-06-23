#
# Multidimensional Scaling
# Author: galaa
# Created on 2016/03/19 07:49:41
#

# Data

X = matrix(
  c(-21.9, -15.2, -17.1, -18.3, -20.5, -17.8, -20.6, -23.7, -20.2, -17.7, -17.3, -22.7, -14.4, -13.8, -21.2, -22.2, -20.2, -22.4, -23.9, -21.8, -30.6, -24.0, -16.3, -11.3, -13.0, -14.1, -16.0, -14.5, -15.1, -18.0, -15.0, -11.8, -12.3, -18.4, -10.7, -9.0, -16.0, -16.3, -15.7, -16.9, -18.6, -16.2, -27.6, -18.5, -7.3, -5.7, -5.9, -6.8, -7.4, -8.3, -6.1, -6.4, -7.0, -2.7, -4.8, -9.8, -5.2, -1.5, -6.6, -5.8, -8.1, -5.7, -8.1, -6.6, -16.3, -7.1, 2.7, 3.3, 2.9, 2.8, 2.9, 0.8, 3.8, 4.6, 4.6, 7.5, 4.5, 2.1, 3.4, 7.8, 4.7, 4.8, 1.7, 5.5, 3.8, 3.7, 2.8, 4.4, 10.2, 9.5, 10.5, 10.2, 10.0, 8.0, 11.7, 12.2, 12.4, 15.1, 11.9, 9.4, 9.8, 14.6, 12.5, 12.2, 9.1, 13.0, 11.6, 11.1, 12.7, 11.8, 16.4, 14.7, 15.9, 16, 15.8, 13.7, 18, 18.4, 19, 21.5, 18.2, 15.2, 15.5, 20.4, 18.6, 18.5, 15.3, 18.6, 17.8, 17, 18.4, 18, 19.3, 16.6, 17.9, 18.2, 17.9, 16, 21, 20.8, 21.7, 24.5, 21.1, 17.6, 17.8, 23.3, 21.5, 21, 18.1, 20.6, 20.5, 18.8, 20.6, 20.4, 16.7, 14.7, 15.9, 16.1, 15.6, 13.6, 18.2, 18.4, 19.3, 21.7, 18.4, 14.8, 15.6, 20.7, 19.3, 18.4, 15.5, 18.2, 17.8, 16.4, 17.8, 17.8, 9.9, 9.0, 9.6, 9.7, 8.5, 7.6, 11.6, 11.0, 12.2, 15.1, 11.9, 8.2, 10.2, 14.9, 12.5, 10.9, 8.9, 11.9, 10.9, 9.4, 10.5, 10.3, 0.5, 1.5, 1.3, 0.6, -0.2, -0.9, 1.9, 1.7, 2.2, 5.1, 2.6, -0.9, 2.1, 5.8, 2.4, 1.8, -0.4, 2.4, 0.7, 0.9, 1.6, 0.8, -11.4, -7.2, -7.7, -9.2, -11.1, -9.7, -9.8, -10.4, -9.6, -6.7, -8.1, -12.5, -6.9, -4.2, -9.6, -9.9, -11.1, -8.9, -11.9, -9.9, -8.6, -11.2, -19.6, -12.6, -14.4, -15.8, -18.2, -15.0, -17.8, -20.2, -17.7, -15.1, -15.0, -19.9, -12.3, -11.2, -18.2, -19.3, -17.7, -18.0, -20.5, -18.3, -23.6, -20.4),
  nrow = 22,
  ncol = 12,
  byrow = FALSE
);

print(X);

# Distance matrix

d <- dist(X, method = "euclidean");

print(d);

# B matrix calculation

d2 <- as.matrix(d)^2;
d2i. <- d2j. <- colMeans(d2);
d2.. <- mean(d2i.);

n = length(X[,1]);

B <- matrix(nrow = n, ncol = n);
for (i in 1:n) {
  for (j in 1:n) {
    B[i,j] <- -1 / 2 * 
      ( d2[i,j] - d2i.[i] - d2j.[j] + d2.. );
  }
}

print(B);

# Eigen values and eigen vectors (spectral decomposition) of B matrix

Lambda = eigen(B)$values;

Gamma = eigen(B)$vectors;

# Ratio

p = 2;
t = 0;
for (i in 1:p) {
  t = t + Lambda[i];
}
t = t / sum(Lambda[1:n-1]);
print(t);

# New coordinates on p-dimensional space

Coordinates = data.frame(
  Gamma[,1:p] %*% diag(sqrt(Lambda[1:p])),
  label = c("UB", "Arkhangai", "Bayan-Ulgii", "Bayankhongor", "Bulgan", "Govi-Altai", "Govisumber", "Darkhan-Uul", "Dornod", "Dornogovi", "Dundgovi", "Zavkhan", "Uvurkhangai", "Umnugovi", "Sukhbaatar", "Selenge", "Tuv", "Khovd", "Khentii", "Khuvsgul", "Uvs", "Orkhon")
);

# Plot

attach(Coordinates);
plot(X1, X2);
text(X1, X2, label, pos=4);
detach(Coordinates);

# Multidimensional Scaling with specific function -- COMPARE IT previous results

mds <- cmdscale(d, eig = TRUE, k = 2);
print(mds);
