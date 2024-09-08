from linear_model/_logisticRegression import(LogisticRegression/fit,LogisticRegression/predict)


def main():
  # X = [[5.0, 3.0, 4.0], [3.0, 2.0, 2.0], [1.5, 9.0, 7.0], [7.0, 2.0, 3.0], [
  #     1.0, 12.0, 4.0], [2.0, 5.0, 3.0], [3.0, 6.0, 2.0], [2.0, 6.0, 2.5], [1.9, 5.8, 5.9]]
  # y = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.0, 2.0]
  # xn = [2.0, 7.0, 5.4]
  # k = 3

  # yn = Knn/fit_predict(X, y, xn, 5)
  # return yn
  x = [32.502, 53.426, 61.530, 47.475, 59.813, 55.142, 52.211, 39.299, 48.105, 52.550,
       45.419, 54.351, 44.164, 58.168, 56.727, 48.955, 44.687, 60.297, 45.618, 38.816]
  y = [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0,
       0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0]

  log_reg = LogisticRegression/fit(x, y)
  x_test=[22.09,65.90,55.34]
  y_pred= LogisticRegression/predict(log_reg,x_test)
  return y_pred
