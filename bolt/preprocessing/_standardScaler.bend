from ../utils/math import sum
from ../utils/types/List import List/append

object StandardScaler {std, mean_val}


def deviation_sum(x, mean):
  match x:
    case List/Cons:
      return ((x.head - mean)*(x.head - mean))+deviation_sum(x.tail, mean)
    case List/Nil:
      return 0.0


def scaler(x, mean, stdev, out):
  match x:
    case List/Cons:
      return scaler(x.tail, mean, stdev, List/append(out, (x.head - mean) / stdev))
    case List/Nil:
      return out


def inverseScaler(x, mean, stdev, out):
  match x:
    case List/Cons:
      return inverseScaler(x.tail, mean, stdev, List/append(out, ((x.head * stdev) + mean)))
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
  total = sum(x)
  mean = total / n
  stdev = 0.0
  stdev = deviation_sum(x, mean)
  stdev = (stdev / (n - 1))**0.5

  return StandardScaler {std: stdev, mean_val: mean}

# scaler(x,mean,stdev,[])


def main():
  x = [10.0, 20.0, 30.0, 40.0]
  model = standard_scaler(x)
  open StandardScaler: model

  # 1 for standard scaling -1 for inverse
  res = transform(x, model, 1)
  out = transform(res, model, -1)
  return model
