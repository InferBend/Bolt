from ./utils/testing import assert_equal
from ./utils/math import (abs, sum, min, max, degreeToRadian, factorial, sin, cos, tan, log)

def check_abs():
  
  return (abs(-1.0) == 1.0) & (abs(0.0) == 0.0) & (abs(2.0) == 2.0)

def check_sum():
  x1 = [1.0, 0.0, -1.0]
  x2 = [5.0, 2.0, 7.0]
  x3 = [-5.0, -1.0, 0.0]

  return (sum(x1) == 0.0) & (sum(x2) == 14.0) & (sum(x3) == -6.0) 

def check_min():

  return (min(-1.0, -5.0) == -5.0) & (min(-1.0, 0.0) == -1.0) & (min(0.0, 4.0) == 0.0) & (min(10.0, 40.0) == 10.0)

def check_max():

  return (max(-1.0, -5.0) == -1.0) & (max(-1.0, 0.0) == 0.0) & (max(0.0, 4.0) == 4.0) & (max(10.0, 40.0) == 40.0)

def check_degreeToRadian():

  return (degreeToRadian(1.0) == 0.0174533) & (degreeToRadian(30.0) == 0.523599) & (degreeToRadian(0.0) == 0.0) & (degreeToRadian(90.0) == 1.5708) & (degreeToRadian(180.0) == 3.14159)

def check_factorial():

  return (factorial(1.0) == 1.0) & (factorial(2.0) == 2.0) & (factorial(10.0) == 3628800.0)

def check_sin():

  return (sin(0.0) == 0.0) & (sin(30.0) == 0.5) & (sin(45.0) == 0.70710678)

def check_cos():

  return (cos(0.0) == 1.000) & (cos(45.0) == 0.70710678)

def check_tan():

  return (tan(0.0) == 0.000) & (tan(45.0) == 1.00)

def check_log():

  return (log(3.0) == 1.0986122) & (log(2.0) == 0.6931471)

def main():
  if check_abs() & check_sum() & check_min() & check_max() & check_degreeToRadian() & check_factorial() & check_sin() & check_cos() & check_tan() & check_log():
    return "PASS"
  else:
    return "FAIL"