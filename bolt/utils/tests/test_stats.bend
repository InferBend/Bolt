from ./utils/testing import assert_equal
from ./utils/stats import (distance, mode, mean)

def check_distance():
  x = [1.0, 2.0, 3.0]
  y = [5.0, -2.0, 0.0]
  actual_dist = 6.40312

  result = distance(x, y)
  return result == actual_dist

def check_mean():
  y = [5.0, -2.0, 0.0]
  actual_mean = 1.0

  result = mean(y)
  return result == actual_mean

def check_mode():
  y = [5.0, -2.0, 7.0, -2.0, 0.0]
  actual_mode = -2.0

  result = mode(y)
  return result == actual_mode

def main():
  if check_distance() & check_mode() & check_mean():
    return "PASS"
  else:
    return "FAIL"
