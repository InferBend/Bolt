from ../utils/math import sum
from ../utils/types/List import (List/append, List/appendFront)
from ../utils/stats import mean
from ../utils/vector import (subtract, multiply, multiplyScalar, initializeArray, vectorSum, vectorPower)

object StandardScaler {stddev, featureMean}

def deviationSum(x, meanX):
  match x:
    case List/Cons:
      diff = subtract(x.head, meanX, [])
      squared_diff = multiply(diff, diff, [])
      return vectorSum(squared_diff, deviationSum(x.tail, meanX))
    case List/Nil:
      (n, meanX) = List/length(meanX)
      return initializeArray(u24/to_f24(n), 0.0, [])


def scaler(x, meanX, stdev, out):
  match x:
    case List/Cons:
      return scaler(x.tail, meanX, stdev, List/append(out, multiply(subtract(x.head, meanX, []), vectorPower(stdev, -1.0), [])))
    case List/Nil:
      return out


def inverseScaler(x, meanX, stdev, out):
  match x:
    case List/Cons:
      return inverseScaler(x.tail, meanX, stdev, List/append(out, vectorSum(multiply(x.head, stdev, []), meanX)))
    case List/Nil:
      return out

def StandardScaler/transform(model, x):
  open StandardScaler: model
  return scaler(x, model.featureMean, model.stddev, [])

def StandardScaler/inverse_transform(model, x):
  open StandardScaler: model
  return inverseScaler(x, model.featureMean, model.stddev, [])


def sumOverFeatures/aux(x: List(List(f24)), featureSum: List(f24)):
  match x:
    case List/Cons:
      featureSum = vectorSum(x.head, featureSum)
      return sumOverFeatures/aux(x.tail, featureSum)
    case List/Nil:
      return featureSum


def sumOverFeatures(x: List(List(f24))):
  match x:
    case List/Cons:
      (n_features, xHead) = List/length(x.head)
    case List/Nil:
      (n_features, xHead) = (0, [])

  n_features = u24/to_f24(n_features)
  featureSumm = initializeArray(n_features, 0.0, [])
  return sumOverFeatures/aux(x, featureSumm)


def meanOverFeatures(x: List(List(f24))):
  match x:
    case List/Cons:
      (n_features, xHead) = List/length(x.head)
    case List/Nil:
      (n_features, xHead) = (0, [])

  n_features = u24/to_f24(n_features)

  summ = sumOverFeatures(x)
  featureMean = multiplyScalar(summ, 1.0/n_features, [])

  return featureMean


def StandardScaler/fit(x):
  n = 0.0
  total = 0.0

  match x:
    case List/Cons:
      (n_features, xHead) = List/length(x.head)
    case List/Nil:
      (n_features, xHead) = (0, [])

  (n, x) = List/length(x)

  featureMean = meanOverFeatures(x)
  deviation = deviationSum(x, featureMean)
  stddev = multiplyScalar(deviation, 1.0 / u24/to_f24(n_features), [])
  stddev = vectorPower(stddev, 0.5)

  return StandardScaler {stddev: stddev, featureMean: featureMean}


def main():
  x = [[1.0, 2.0], [10.0, 5.0]]
  model = StandardScaler/fit(x)
  open StandardScaler: model

  res = StandardScaler/transform(model, x)
  out = StandardScaler/inverse_transform(model, res)
  return out
