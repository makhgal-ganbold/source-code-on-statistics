
# Find the latitude, longitude, and elevation of the point that distances from this point to the other points are known

# Given known points (latitude, longitude, elevation)
points <- data.frame(
  lat = c(47.928354, 47.927262, 47.915240, 47.919008),
  lon = c(106.905238, 106.940987, 106.894638, 106.943261),
  elev = c(0, 0, 0, 0),
  name = c("Баянбүрд", "Сансар", "Баруун 4 зам", "Зүүн 4 зам")
)

# Given distances from unknown point to these points (in meters)
distances <- c(1400.5, 1986.6, 1752.9, 1921.1)

# Objective function
objective_function <- function(x) {
  lat_unknown <- x[1]
  lon_unknown <- x[2]
  elev_unknown <- x[3]
  # Compute distances from unknown point to the known points
  computed_distances <- sqrt(
    geosphere::distHaversine(c(lon_unknown, lat_unknown), points[, c("lon", "lat")])^2 +
      {points$elev - elev_unknown}^2
  )
  # the total squared differences
  sum({computed_distances - distances}^2)
}

# Initial guess (latitude, longitude, elevation)
initial_guess <- c(mean(points$lat), mean(points$lon), mean(points$elev))

# Optimization to find best latitude, longitude, and elevation
result <- optim(initial_guess, objective_function)

# Print results
cat("Latitude:", result$par[1], " Longitude:", result$par[2], " Elevation:", result$par[3], "meters\n")

leaflet::leaflet(data = points) |>
  leaflet::addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G") |>
  leaflet::addMarkers(~lon, ~lat, popup = ~name) |>
  leaflet::addCircleMarkers(result$par[2], result$par[1], popup = "Олсон координат") |>
  leaflet::setView(lng = mean(points$lon), lat = mean(points$lat), zoom = 14)
