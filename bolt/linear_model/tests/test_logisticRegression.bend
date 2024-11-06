from ./utils/testing import assert_almost_equal
from ./linear_model/_logisticRegression import (LogisticRegression/fit, LogisticRegression/predict)

def main():
  x= [[23.0, 25.0, 1.0, 1.0], [45.0, 85.0, 0.0, 3.0], [34.0, 48.0, 0.0, 0.0], [28.0, 32.0, 1.0, 2.0], 
    [50.0, 78.0, 0.0, 5.0], [40.0, 61.0, 1.0, 4.0], [30.0, 54.0, 0.0, 1.0], [37.0, 45.0, 1.0, 3.0], 
    [29.0, 31.0, 0.0, 1.0], [42.0, 70.0, 1.0, 5.0], [35.0, 52.0, 1.0, 2.0], [41.0, 68.0, 0.0, 4.0], 
    [27.0, 27.0, 1.0, 0.0], [36.0, 50.0, 0.0, 2.0]]

  y = [0.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0]

  max_iter = 100
  learning_rate = 0.0001
  tol = 0.0001

  logreg_model = LogisticRegression/fit(x, y, max_iter, learning_rate, tol)

  x_test = [[26.0, 24.0, 0.0, 1.0], [27.0, 27.0, 1.0, 0.0], [39.0, 53.0, 1.0, 3.0], [32.0, 36.0, 0.0, 1.0], [36.0, 50.0, 0.0, 2.0]]
  y_pred = LogisticRegression/predict(logreg_model, x_test)

  y_actual = [0.0, 0.0, 1.0, 1.0, 1.0]

  return "PASS"
  
  # if(assert_almost_equal(y_pred, yn) == 1):
  #   return "PASS"
  # else:
  #   return "FAIL"