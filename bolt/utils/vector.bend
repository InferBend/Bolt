from ./types/List import (List/append, List/appendFront)

def initializeArray(size, value, arr):
  if size == 0.0:
    return arr
  else:
    return initializeArray(size - 1.0, value, List/append(arr, value))

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

def vectorPower(x, val):
  match x:
    case List/Cons:
      return List/appendFront(vectorPower(x.tail, val), x.head ** val)
    case List/Nil:
      return []