from ./math import sum
from ./types/List import (List/index)
from ./helper import sort
from ./math import (abs)

def distance/aux(x, y, p, l, i):
  if i < l:
    return (abs(List/index(x, i) - List/index(y, i)) ** p) + distance/aux(x, y, p, l, i + 1)
  else:
    return 0.0


def distance(x, y, p):
  (l, x) = List/length(x)
  k = distance/aux(x, y, p, l, 0)
  return k ** (1.0 / p)


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
  # TODO: Think of an alternative to -1.0 as previous number
  x = sort(x)
  return mode/aux(x, 0.0, -1.0, 0.0, -1.0)


def mean(x):
  (l, x) = List/length(x)
  return sum(x) / u24/to_f24(l)


def main():
  x = [1.0, 2.0, 3.0, 4.0]

  return mean(x)
