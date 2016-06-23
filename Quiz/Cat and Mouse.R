#
# Quiz: Cat and mouse
# Author: galaa
# Created on 2016/04/7 07:19:25
#

movement = matrix(c(1, 0, 0, 0, 0, 0.5, 0, 0, 0.5, 0, 0, 0, 0, 1, 0, 0, 1/3, 1/3, 0, 1/3, 0, 0, 0, 0, 1), nrow = 5, ncol = 5, byrow = TRUE)

escapes = 0
simulation = 0

while (simulation <= 1000)
{
  current_position = 3; died = FALSE; escaped = FALSE;

  while (!died && !escaped)
  {
    cum_prob = 0
    new_position = 0
    u = runif(n = 1, min = 0, max = 1)

    while (cum_prob < u)
    {
      new_position = new_position + 1
      cum_prob = cum_prob + movement[current_position, new_position]
    }

    current_position = new_position

    if (current_position == 1)
    {
      died = TRUE
    }
    else if (current_position == 5)
    {
      escaped = TRUE
    }
  }

  if (escaped)
  {
    escapes = escapes + 1
  }

  simulation = simulation + 1
}
print(c('P(escape) = ', escapes / 1000))
