from ./utils/testing import assert_almost_equal
from ./neighbors/_KNeighborsRegressor import Knn/fit_predict

def check_knnRegressor():
  k = 5

  X = [[0.0], [1.0], [2.0], [3.0], [4.0], [5.0], [6.0], [7.0], [8.0]]
  y = [5.0, 7.0, 9.0, 11.0, 13.0, 15.0, 17.0, 19.0, 21.0]

  p2 = [9.0]
  y2 = Knn/fit_predict(X, y, p2, k)

  p3 = [1.0]
  y3 = Knn/fit_predict(X, y, p3, k)

  p4 = [-1.0]
  y4 = Knn/fit_predict(X, y, p4, k)

  return (y2 == 17.0) & (y3 == 9.0) & (y4 == 9.0)

def main():
  if check_knnRegressor():
    return "PASS"
  else:
    return "FAIL"