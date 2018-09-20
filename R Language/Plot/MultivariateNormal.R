# This script illustrates a multivariate Gaussian distribution and its
# marginal distributions

# This code is issued under the CC0 "license"

# Install required package
install.packages("plot3D")

# Initialize random number generation
set.seed(1)

# Define limits of plotting
X <- Y <- seq(from = -5, to = 5, by = 0.1)

# 2-d Mean and covariance matrix
MeanVec <- c(0, 0)
CovMatrix <- matrix(data = c(1, 0.6, 0.6, 2), nrow = 2)

# Get the 1-d PDFs for the "walls"
Z_x <- dnorm(x = X, mean = MeanVec[1], sqrt(CovMatrix[1,1]))
Z_y <- dnorm(x = Y, mean = MeanVec[2], sqrt(CovMatrix[2,2]))

# Get the 2-d samples for the "floor"
Samples <- MASS::mvrnorm(mu = MeanVec, Sigma = CovMatrix, n = 2500)

# Get the sigma ellipses by transform a circle by the cholesky decomp
L <- chol(CovMatrix)
t <- seq(from = 0, to = 2 * pi, length.out = 100) # Our ellipse will have 100 points on it
C <- cbind(cos(t), sin(t)) # A unit circle
E1 <- 1 * C %*% L; E2 <- 2 * C %*% L; E3 <- 3 * C %*% L; # Get the 1,2, and 3-sigma ellipses

# Plot the samples on the "floor"
plot3D::scatter3D(
  x = Samples[,1], y = Samples[,2], z = rep(0, times = dim(Samples)[1]),
  colvar = NULL, # no coloring by z
  pch = 20, cex = 0.1, col = "black", # point shape, size and color
  bty = "b2", # back panels and grid lines
  expand = 0.5, phi = 10, theta = 45, # view
  # Make the figure look nice
  xlim = range(X), ylim = range(Y), zlim = 1.1 * c(0,max(Z_x, Z_y)),
  xlab = "X", ylab = "Y", zlab = "Density",
  ticktype = "detailed"
)

# Plot the 1,2, and 3-sigma ellipses slightly above the floor
plot3D::scatter3D(x = E1[,1], y = E1[,2], z = 1e-3 + rep(0, times = dim(E1)[1]), add = TRUE, type = "l", colvar = NULL, col = "green")
plot3D::scatter3D(x = E2[,1], y = E2[,2], z = 1e-3 + rep(0, times = dim(E2)[1]), add = TRUE, type = "l", colvar = NULL, col = "green")
plot3D::scatter3D(x = E3[,1], y = E3[,2], z = 1e-3 + rep(0, times = dim(E3)[1]), add = TRUE, type = "l", colvar = NULL, col = "green")

# Plot the histograms on the walls from the data in the middle
res.h.x <- hist(Samples[,1], breaks = 20, plot = FALSE) # Creates 20 bars
n_x <- res.h.x$density
xout <- res.h.x$breaks
plot3D::box3D(
  x0 = xout[-length(xout)], y0 = rep(max(Y), times = length(xout) - 1), z0 = rep_len(x = 0, length.out = length(n_x)),
  x1 = xout[-1], y1 = rep(max(Y), times = length(xout) - 1), z1 = n_x,
  colvar = NULL, border = gray(0.5, alpha = 0.5), col = gray(1, alpha = 0), lwd = 1, add = TRUE
)

# Now plot the other histograms on the wall
res.h.y <- hist(Samples[,2], breaks = 20, plot = FALSE)
n_y <- res.h.y$density
yout <- res.h.y$breaks
plot3D::box3D(
  x0 = rep(min(X), times = length(yout) - 1), y0 = yout[-length(yout)], z0 = rep_len(x = 0, length.out = length(n_y)),
  x1 = rep(min(X), times = length(yout) - 1), y1 = yout[-1], z1 = n_y,
  colvar = NULL, border = gray(0.5, alpha = 0.5), col = gray(1, alpha = 0), lwd = 1, add = TRUE
)

# Now plot the 1-d pdfs over the histograms
plot3D::scatter3D(x = X, y = rep(max(Y), times = length(X)), z = Z_x, add = TRUE, type = "l", colvar = NULL, col = "blue")
plot3D::scatter3D(x = rep(min(Y), times = length(X)), y = Y, z = Z_y, add = TRUE, type = "l", colvar = NULL, col = "red")

# Save the plot
dev.print(device = pdf, file = "MultivariateNormal.pdf")
