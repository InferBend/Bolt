from ../utils/math import sum
from ../utils/types/List import List/append
from ../utils/stats import mean

object StandardScaler {std, mean_val}


def deviation_sum(x, meanX):
  match x:
    case List/Cons:
      return ((x.head - meanX)**2.0)+deviation_sum(x.tail, meanX)
    case List/Nil:
      return 0.0


def scaler(x, meanX, stdev, out):
  match x:
    case List/Cons:
      return scaler(x.tail, meanX, stdev, List/append(out, (x.head - meanX) / stdev))
    case List/Nil:
      return out


def inverseScaler(x, meanX, stdev, out):
  match x:
    case List/Cons:
      return inverseScaler(x.tail, meanX, stdev, List/append(out, ((x.head * stdev) + meanX)))
    case List/Nil:
      return out


def transform(x, model, direction):
  open StandardScaler: model
  if direction == 1:
    return scaler(x, model.mean_val, model.std, [])
  else:
    return inverseScaler(x, model.mean_val, model.std, [])


def standard_scaler(x):
  n = 0.0
  total = 0.0
  (n, x) = List/length(x)
  meanX = mean(x)
  deviationSum = deviation_sum(x, meanX)
  stdev = (deviationSum / (u24/to_f24(n) - 1))**0.5

  return StandardScaler {std: stdev, mean_val: meanX}


def main():
  x = [10.0, 20.0, 30.0, 40.0]
  model = standard_scaler(x)
  open StandardScaler: model

  # 1 for standard scaling -1 for inverse
  res = transform(x, model, 1)
  out = transform(res, model, -1)
  return out
