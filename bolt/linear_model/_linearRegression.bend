##############################
# Author: Nihal Srivastava, June 2024
##############################

from ../utils/types/List import List/append
from ../utils/vector import *
from ../utils/math import (sum, abs)

type LinearRegression:
  Model {weights, bias, cost}


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


def meanSquaredError/aux(yTrue, yPred):
  match yTrue:
    case List/Cons:
      match yPred:
        case List/Cons:
          return ((yTrue.head - yPred.head) ** 2.0) + meanSquaredError/aux(yTrue.tail, yPred.tail)
        case List/Nil:
          return 0.0
    case List/Nil:
      return 0.0


def meanSquaredError(yTrue, yPred):
  (l, yTrue) = List/length(yTrue)
  return meanSquaredError/aux(yTrue, yPred) / u24/to_f24(l)


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

    # TODO: implement invscaling eta = eta0 / pow(t, power_t)
    # t = Number of weight updates performed during training. Same as (n_iter_ * n_samples + 1)
    # match x:
    #   case List/Cons:
    #     n_samples, xHead = List/length(x.head)
    #   case List/Nil:
    #     n_samples, xHead = 0.0

    # t = u24/to_f24(1000 - iters + 1)
    # eta = lr / (t ** 0.25)

    eta = lr

    if abs(prevCost - cost) < thres:
      return (weights, bias, costs)
    else:
      (l, yTrue) = List/length(x)
      n = u24/to_f24(l)
      db = (-2.0 / n) * sum(subtract(y, yPred, []))
      normalizer = (-2.0 / n)
      dw = multiplyScalar(sumOfWeights(
          multiplyY(x, subtract(y, yPred, []), [])), normalizer, [])

      weights = subtract(weights, multiplyScalar(dw, eta, []), [])
      bias = bias - (eta * db)

      return gradientDescent/aux(x, y, iters - 1, eta, thres, weights, bias, cost, costs)


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
      n = u24/to_f24(l)
    case Lists/Nil:
      n = -1.0
  return n


def gradientDescent(x, y, iters, lr, thres):
  n = getNumberOfFeatures(x)
  W = initializeArray(n, 0.1, [])
  return gradientDescent/aux(x, y, iters, lr, thres, W, 0.1, 999.9, [])


def predict(x, weights, bias):
  return sum(multiply(x, weights, []), []) + bias


def LinearRegression/fit(x, y, max_iter, learning_rate, tol):
  (weights, bias, costs) = gradientDescent(x, y, max_iter, learning_rate, tol)
  return LinearRegression/Model(weights, bias, costs)


def LinearRegression/predictX(model, x):
  match model:
    case LinearRegression/Model:
      return predict(x, model.weights, model.bias)


def LinearRegression/predict(model, x):
  match x:
    case List/Cons:
      return List/concat([LinearRegression/predictX(model, x.head)], LinearRegression/predict(model, x.tail))
    case List/Nil:
      return []


def main():
  # x = Hours studied, Previous score, Sleep hours, sample questions, y = Performance indicator
  # https://www.kaggle.com/datasets/nikhil7280/student-performance-multiple-linear-regression

  x = [[7.0, 99.0, 9.0], [4.0, 82.0, 4.0], [8.0, 51.0, 7.0],
       [5.0, 52.0, 5.0], [7.0, 75.0, 8.0, 5.0], [3.0, 78.0, 9.0],]

  y = [91.0, 68.777, 45.0, 36.0, 66.0, 61.0]

  max_iter = 100
  learning_rate = 0.0001
  tol = 0.0001

  model = LinearRegression/fit(x, y, max_iter, learning_rate, tol)
  xn = [[9.0, 100.0, 3.0], [1.0, 60.0, 7.0]]
  y_pred = LinearRegression/predict(model, xn)
  return y_pred
