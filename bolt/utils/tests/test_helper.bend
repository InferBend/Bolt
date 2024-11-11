from ./utils/testing import assert_equal
from ./utils/helper import (sort, Number/parse_digit, Number/parse_integer)

def check_sort():
  x = [1.0, 0.0, 300.0, -1.0, 20.0, -50.0]
  y = [-50.0, -1.0, 0.0, 1.0, 20.0, 300.0]
  x = sort(x)

  return assert_equal(x, y)

def check_Number_parse_digit():
  d = Number/parse_digit('5')
  N = 5

  return d == N  

def check_Number_parse_interger():
  i = Number/parse_integer("3214")
  N = 3214

  return i == N

def main():
  return check_sort() & check_Number_parse_digit() & check_Number_parse_interger()
