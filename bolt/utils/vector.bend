from ./types/List import List/append


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
    
def subtractScalar(x, val, z):
  match x:
    case List/Cons:
      z = List/append(z, x.head - val)
      return subtractScalar(x.tail, val, z)
    case List/Nil:
      return z

def divideScalar(ls, n, z):
  match ls:
    case List/Cons:
      return divideScalar(ls.tail, n, List/append(z, ls.head / n))
    case List/Nil:
      return z 