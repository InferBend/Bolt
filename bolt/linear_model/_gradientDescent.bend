##############################
# Author: Nihal Srivastava, June 2024
##############################

# List

def List/append(x, val):
  
  return List/concat(x, [val])

# Metrics

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
  return meanSquaredError/aux(yTrue, yPred) / to_f24(l)

#############################################################

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


def gradientDescent/aux(x, y, iters, lr, thres, weight, bias, prevCost, costs):
  if iters == 0:
    return (weight, bias, costs)
  else:
    wx = multiplyScalar(x, weight, [])
    yPred = addScalar(wx, bias, [])
    cost = meanSquaredError(y, yPred)
    costs = List/append(costs, cost)

    if abs(prevCost - cost) < thres:
      return (weight, bias, costs)
    else:
      (l, x) = List/length(x)
      n = to_f24(l)
      dw = (-2.0 / n) * sum(multiply(x, subtract(y, yPred, []), []))
      db = (-2.0 / n) * sum(subtract(y, yPred, []))

      weight = weight - (lr * dw)
      bias = bias - (lr * db)

      return gradientDescent/aux(x, y, iters - 1, lr, thres, weight, bias, cost, costs)


def gradientDescent(x, y, iters, lr, thres):
  return gradientDescent/aux(x, y, iters, lr, thres, 0.1, 0.1, 999.9, [])


def predict(x, weight, bias):
  return (x * weight) + bias


def main():
  x = [32.502, 53.426, 61.530, 47.475, 59.813, 55.142, 52.211, 39.299, 48.105, 52.550,
       45.419, 54.351, 44.164, 58.168, 56.727, 48.955, 44.687, 60.297, 45.618, 38.816]
  y = [31.707, 68.777, 62.562, 71.546, 87.230, 78.211, 79.641, 59.171, 75.331, 71.300,
       55.165, 82.478, 62.008, 75.392, 81.436, 60.723, 82.892, 97.379, 48.847, 56.877]

  (w, b, costs) = gradientDescent(x, y, 100, 0.0001, 0.000001)
  y = predict(50.12, w, b)
  return y
