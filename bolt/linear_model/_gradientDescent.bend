##############################
# Author: Nihal Srivastava, June 2024
##############################

from ../utils/types/List import (List/append)
from ../metrics/_regression import (meanSquaredError)


def subtract(x, y, z):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = (x.head - y.head)
          z = List/append(z, d)
          return subtract(x.tail, y.tail, z)
        case List/Nil:
          return z
    case List/Nil:
      return z


def multiply(x, y, z):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = (x.head * y.head)
          z = List/append(z, d)
          return multiply(x.tail, y.tail, z)
        case List/Nil:
          return z
    case List/Nil:
      return z


def multiplyScalar(x, val, z):
  match x:
    case List/Cons:
      z = List/append(z, x.head * val)
      return multiplyScalar(x.tail, val, z)
    case List/Nil:
      return z


def multiplyWeights(x, weights, z):
  match x:
    case List/Cons:
      z = List/append(z, sum(multiply(x.head, weights, []), []))
      return multiplyWeights(x.tail, weights, z)
    case List/Nil:
      return z


def addScalar(x, val, z):
  match x:
    case List/Cons:
      z = List/append(z, x.head + val)
      return addScalar(x.tail, val, z)
    case List/Nil:
      return z


def sum(x):
  match x:
    case List/Cons:
      return x.head + sum(x.tail)
    case List/Nil:
      return 0.0


def abs(x):
  if x < 0.0:
    return -1.0 * x
  else:
    return x


def multiplyY(x, y, z):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = multiplyScalar(x.head, y.head, [])
          z = List/append(z, d)
          return multiplyY(x.tail, y.tail, z)
        case List/Nil:
          return z
    case List/Nil:
      return z


def sumArrays(x, y, z):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = x.head + y.head
          return sumArrays(x.tail, y.tail, List/append(z, d))
        case List/Nil:
          return z
    case List/Nil:
      return z


def sumOfWeights/aux(dw, sdw):
  match dw:
    case List/Cons:
      sdw = sumArrays(dw.head, sdw, [])
      return sumOfWeights/aux(dw.tail, sdw)
    case List/Nil:
      return sdw


def sumOfWeights(dw):
  n = getNumberOfFeatures(dw)
  sdw = initializeArray(n, 0.0, [])
  return sumOfWeights/aux(dw, sdw)


def gradientDescent/aux(x, y, iters, lr, thres, weights, bias, prevCost, costs):
  if iters == 0:
    return (weights, bias, costs)
  else:
    wx = multiplyWeights(x, weights, [])
    yPred = addScalar(wx, bias, [])
    cost = meanSquaredError(y, yPred)
    costs = List/append(costs, cost)

    if abs(prevCost - cost) < thres:
      return (weights, bias, costs)
    else:
      (l, yTrue) = List/length(x)
      n = to_f24(l)
      db = (-2.0 / n) * sum(subtract(y, yPred, []))
      normalizer = (-2.0 / n)
      dw = multiplyScalar(sumOfWeights(
          multiplyY(x, subtract(y, yPred, []), [])), normalizer, [])

      weights = subtract(weights, multiplyScalar(dw, lr, []), [])
      bias = bias - (lr * db)

      return gradientDescent/aux(x, y, iters - 1, lr, thres, weights, bias, cost, costs)


def initializeArray(size, value, arr):
  if size == 0.0:
    return arr
  else:
    return initializeArray(size - 1.0, value, List/append(arr, value))


def getNumberOfFeatures(x):
  n = -1.0
  match x:
    case List/Cons:
      (l, xHead) = List/length(x.head)
      n = to_f24(l)
    case Lists/Nil:
      n = -1.0
  return n


def gradientDescent(x, y, iters, lr, thres):
  n = getNumberOfFeatures(x)
  W = initializeArray(n, 0.1, [])
  return gradientDescent/aux(x, y, iters, lr, thres, W, 0.1, 999.9, [])


def predict(x, weights, bias):
  return sum(multiply(x, weights, []), []) + bias


def main():
  # x = Hours studied, Previous score, Sleep hours, sample questions, y = Performance indicator
  # https://www.kaggle.com/datasets/nikhil7280/student-performance-multiple-linear-regression

#   x = [[7.0, 99.0, 9.0, 1.0], [4.0, 82.0, 4.0, 2.0], [8.0, 51.0, 7.0, 2.0],
#        [5.0, 52.0, 5.0, 2.0], [7.0, 75.0, 8.0, 5.0], [3.0, 78.0, 9.0, 6.0],]
  x= [[1.0, 45.0, 85.0],[1.0, 50.0, 43.0],
     [1.0, 54.0, 78.0],
     [1.0, 60.0, 58.0],
     [1.0, 63.0, 72.0],
     [1.0, 67.0, 80.0],
     [1.0, 70.0, 65.0],
     [1.0, 73.0, 90.0],
     [1.0, 75.0, 60.0],
     [1.0, 80.0, 85.0]]

#   y = [91.0, 68.777, 45.0, 36.0, 66.0, 61.0]
  y = [1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0]

  (weights, bias, costs) = gradientDescent(x, y, 100, 0.0001, 0.000001)
  xn = [4.0, 82.0, 4.0, 1.0]
  yn = predict(xn, weights, bias)
  return yn