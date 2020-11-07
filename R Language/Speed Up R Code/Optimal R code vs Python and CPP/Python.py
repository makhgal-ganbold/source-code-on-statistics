def sd_py(x):
  n = len(x)
  sum = 0.0
  for x_i in x:
    sum += x_i
  mu = sum / n
  sum = 0.0
  for x_i in x:
    sum += pow(x_i - mu, 2)
  return pow(sum / (n - 1), 0.5)

sd_py(range(1,7)) # 1:6
