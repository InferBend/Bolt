from ../utils/math import sum
from ../utils/types/List import (List/append, List/appendFront)
from ../utils/stats import mean
from ../utils/vector import (subtract, multiply, multiplyScalar)

object StandardScaler {stddev, featureMean}

############# # @TODO: Move to vector.bend ###########################


def vectorSum(x, y):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = (x.head + y.head)
          return List/appendFront(vectorSum(x.tail, y.tail), d)
        case List/Nil:
          return []
    case List/Nil:
      return []


def initializeArray(size, value, arr):
  if size == 0.0:
    return arr
  else:
    return initializeArray(size - 1.0, value, List/append(arr, value))


def vectorPower(x, val):
  match x:
    case List/Cons:
      return List/appendFront(vectorPower(x.tail, val), x.head ** val)
    case List/Nil:
      return []

############# MOVE THESE ###########################


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
      return scaler(x.tail, meanX, stdev, List/append(out, multiply(subtract(x.head, meanX, []), 1.0 / stdev, [])))
    case List/Nil:
      return out


def inverseScaler(x, meanX, stdev, out):
  match x:
    case List/Cons:
      return inverseScaler(x.tail, meanX, stdev, List/append(out, vectorSum(multiply(x.head, stdev, []), meanX)))
      # return inverseScaler(x.tail, meanX, stdev, List/append(out, ((x.head * stdev) + meanX)))
    case List/Nil:
      return out


def transform(x, model, direction):
  open StandardScaler: model
  if direction == 1:
    return scaler(x, model.featureMean, model.stddev, [])
  else:
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


def standard_scaler(x):
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
  model = standard_scaler(x)
  open StandardScaler: model

  # 1 for standard scaling -1 for inverse
  res = transform(x, model, 1)
  out = transform(res, model, -1)
  return out
