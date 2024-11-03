from ./utils/testing import assert_almost_equal
from ./linear_model/_linearRegression import (LinearRegression/fit, LinearRegression/predict)

def main():
  # y = 2x + 5
  x = [[0.0], [1.0], [2.0], [3.0], [4.0], [5.0], [6.0], [7.0], [8.0]]
  y = [5.0, 7.0, 9.0, 11.0, 13.0, 15.0, 17.0, 19.0, 21.0]

  model = LinearRegression/fit(x, y)

  xn = [[9.0], [1.0], [-1.0]]
  yn = [23.0, 7.0, 3.0]
  y_pred = LinearRegression/predict(model, xn)

  if(assert_almost_equal(y_pred, yn) == 1):
    return "PASS"
  else:
    return "FAIL"