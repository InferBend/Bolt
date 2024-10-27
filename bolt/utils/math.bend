PI = 3.1415926535


def abs(x):
  if x < 0.0:
    return -1.0 * x
  else:
    return x


def sum(x):
  match x:
    case List/Cons:
      return x.head + sum(x.tail)
    case List/Nil:
      return 0.0


def min(a, b):
  if a < b:
    return a
  else:
    return b


def max(a, b):
  if a > b:
    return a
  else:
    return b


def degreeToRadian(x):
  return (x * PI) / 180.0


def factorial(x):
  if x < 1.0:
    return 1.0
  else:
    if x == 1.0:
      return 1.0
    else:
      return x * factorial(x - 1.0)


def sin/aux(r, i, sign, limit):
  if i > limit:
    return 0.0
  else:
    if sign == 1.0:
      return sin/aux(r, i + 2.0, 0.0, limit) - (r ** i)/factorial(i)
    else:
      return sin/aux(r, i + 2.0, 1.0, limit) + (r ** i)/factorial(i)


def sin(x):
  r = degreeToRadian(x)
  return sin/aux(r, 1.0, 0.0, 8.0)


def cos/aux(r, i, sign, limit):
  if i > limit:
    return 0.0
  else:
    if sign == 1.0:
      return sin/aux(r, i + 2.0, 0.0, limit) - (r ** i)/factorial(i)
    else:
      return sin/aux(r, i + 2.0, 1.0, limit) + (r ** i)/factorial(i)


def cos(x):
  r = degreeToRadian(x)
  return cos/aux(r, 0.0, 0.0, 8.0)


def tan(x):
  sinx = sin(x)
  cosx = cos(x)
  return sinx / cosx


def log/aux(x, i, limit):
  if i > limit:
    return 0.0
  else:
    return log/aux(x, i + 2.0, limit) + (x ** i) / i


def log(z):
  x = (z - 1.0) / (z + 1.0)
  return 2.0 * log/aux(x, 1.0, 24.0)


def main():
  x = 7.0
  y = [1.0, 2.0, 3.0]
  (l, y) = List/length(y)
  return sum(y) / u24/to_f24(l)
