from linear_model/_linearRegression import (LinearRegression/fit, LinearRegression/predict)


def main():
  x = [[7.0, 99.0, 9.0, 1.0], [4.0, 82.0, 4.0, 2.0], [8.0, 51.0, 7.0, 2.0],
       [5.0, 52.0, 5.0, 2.0], [7.0, 75.0, 8.0, 5.0], [3.0, 78.0, 9.0, 6.0],]

  y = [91.0, 68.777, 45.0, 36.0, 66.0, 61.0]
  xn = [4.0, 82.0, 4.0, 1.0]

  lr_model = LinearRegression/fit(x, y)
  yn = LinearRegression/predict(lr_model, xn)
  return yn
