from neighbors/_KNeighborsClassifier import Knn/fit_predict


def main():
  X = [[5.0, 3.0, 4.0], [3.0, 2.0, 2.0], [1.5, 9.0, 7.0], [7.0, 2.0, 3.0], [
      1.0, 12.0, 4.0], [2.0, 5.0, 3.0], [3.0, 6.0, 2.0], [2.0, 6.0, 2.5], [1.9, 5.8, 5.9]]
  y = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.0, 2.0]
  xn = [2.0, 7.0, 5.4]
  k = 3

  yn = Knn/fit_predict(X, y, xn, 5)
  return yn
