from ./utils/testing import assert_equal
from ./neighbors/_KNeighborsClassifier import (Knn/fit, Knn/predict)

def check_knnClassifier():
  k = 5

  X = [[23.0, 25.0, 1.0, 1.0], [45.0, 85.0, 0.0, 3.0], [34.0, 48.0, 0.0, 0.0], [28.0, 32.0, 1.0, 2.0], 
    [50.0, 78.0, 0.0, 5.0], [40.0, 61.0, 1.0, 4.0], [30.0, 54.0, 0.0, 1.0], [37.0, 45.0, 1.0, 3.0], 
    [29.0, 31.0, 0.0, 1.0], [42.0, 70.0, 1.0, 5.0], [35.0, 52.0, 1.0, 2.0], [41.0, 68.0, 0.0, 4.0], 
    [27.0, 27.0, 1.0, 0.0], [36.0, 50.0, 0.0, 2.0]]

  y = [0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0]
  k = 5
  p = 2.0

  model = Knn/fit(X, y, k, p)

  x_test = [[26.0, 24.0, 0.0, 1.0], [27.0, 27.0, 1.0, 0.0], [39.0, 53.0, 1.0, 3.0]]
  y_actual = [0.0, 0.0, 1.0]
  
  y_pred = Knn/predict(model, x_test)

  return assert_equal(y_actual, y_pred)

def main():
  if check_knnClassifier():
    return "PASS"
  else:
    return "FAIL"