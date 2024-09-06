
from ./types/List import *


def random/aux(a, c, m, seed):
  next_number = (a * seed + c) % m
  return next_number


def random(seed):
  a = 11035.00
  c = 12345.00
  m = 32.00
  return random/aux(a, c, m, seed) / m


def randomInt(lower, upper, seed):
  originalValue = random(seed)
  newValue = (originalValue * (upper - lower)) + lower
  return (newValue, originalValue)


def List/shuffle/aux(x, i, seed):
  if i < 1:
    return x
  else:
    (randomIndex, seed) = randomInt(1.0, List/length(x) - 1, seed)
    (e, l) = List/popElement(x, randomIndex)
    l = List/append(l, e)
    return List/shuffle/aux(l, i - 1.0, seed)


def List/shuffle(x, seed):
  (randomIndex, seed) = randomInt(1.0, List/length(x) - 1, seed)
  return List/shuffle/aux(x, randomIndex, seed)


def choice/aux(x, size, y, seed):
  (randomIndex, seed) = randomInt(0.0, x, seed)
  y = List/append(y, randomIndex)
  if size == 0.0:
    return y
  else:
    return choice/aux(x, size - 1.0, y, seed)


def choice(x, size):
  return choice/aux(x, size, [], 12.0)


def main():
  return choice(10.0, 5.0)
