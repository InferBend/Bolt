from ./utils/testing import assert_equal
from ./utils/vector import (subtract, multiply, multiplyScalar)

def check_subtract():
  x = [12.0, -10.0, 300.0, 0.0, 20.0, 50.0]
  y = [-50.0, 1.0, 20.0, 0.0, 20.0, 300.0]
  actual = [62.0, -11.0, 280.0, 0.0, 0.0, -250.0]
  z = subtract(x, y, [])

  return assert_equal(actual, z)

def check_multiply():
  x = [12.0, 10.0, 300.0, -2.0, 20.0, -50.0]
  y = [-5.0, 1.0, 0.0, -3.0, 20.0, 3.0]
  actual = [-60.0, 10.0, 0.0, 6.0, 400.0, -150.0]
  z = multiply(x, y, [])

  return assert_equal(actual, z)

def check_multiplyScalar():
  x = [-5.0, 1.0, 0.0, -3.0, 20.0, 3.0]
  v = 3.0
  actual = [-15.0, 3.0, 0.0, -9.0, 60.0, 9.0]
  z = multiplyScalar(x, v, [])

  return assert_equal(actual, z)

def main():
  if check_subtract() & check_multiply() & check_multiplyScalar():
    return "PASS"
  else:
    return "FAIL"
