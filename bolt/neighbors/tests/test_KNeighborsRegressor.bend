from ./utils/testing import assert_almost_equal
from ./neighbors/_KNeighborsRegressor import (Knn/fit, Knn/predict)

def check_knnRegressor():
  X = [[0.0], [1.0], [2.0], [3.0], [4.0], [5.0], [6.0], [7.0], [8.0]]
  y = [5.0, 7.0, 9.0, 11.0, 13.0, 15.0, 17.0, 19.0, 21.0]
  k = 5
  p = 2.0
  
  model = Knn/fit(X, y, k, p)

  xn = [[9.0], [1.0], [-1.0]]
  y_actual = [17.0, 9.0, 9.0]

  y_pred = Knn/predict(model, xn)

  return assert_almost_equal(y_actual, y_pred)

def main():
  if check_knnRegressor():
    return "PASS"
  else:
    return "FAIL"