from ./_math import sum
from ../types/List import List/index


def distance/aux(x, y, i):
  match x:
    case List/Cons:
      (l, x) = List/length(x)
      if i < l:
        return ((List/index(x, i) - List/index(y, i)) * (List/index(x, i) - List/index(y, i))) + distance/aux(x, y, i + 1)
      else:
        return 0.0
    case List/Nil:
      return 0.0


def distance(x, y):
  x = distance/aux(x, y, 0)
  return x ** 0.5


def mode/aux(x, count, previous, maxCount, currentMax):
  match x:
    case List/Cons:
      if x.head == previous:
        return mode/aux(x.tail, count + 1.0, x.head, maxCount, currentMax)
      else:
        if maxCount < count:
          return mode/aux(x.tail, 1.0, x.head, count, previous)
        else:
          return mode/aux(x.tail, 1.0, x.head, maxCount, currentMax)
    case List/Nil:
      if maxCount < count:
        return previous
      else:
        return currentMax


def mode(x):
  return mode/aux(x, 0.0, -1.0, 0.0, -1.0)


def mean(x):
  (l, x) = List/length(x)
  return sum(x) / to_f24(l)


def main():
  x = [1.0, 2.0, 3.0]

  return mean(x)
