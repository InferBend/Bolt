
def sort(xs):
  match xs:
    case List/Nil:
      return List/Nil
    case List/Cons:
      return insert(xs.head, sort(xs.tail))


def insert(v, xs):
  match xs:
    case List/Nil:
      return List/Cons(v, List/Nil)
    case List/Cons:
      return swap_gt(v, xs.head, xs.tail)


def swap_gt(v, x, xs):
  if x > v:
    return List/Cons(v, List/Cons(x, xs))
  else:
    return List/Cons(x, insert(v, xs))

def Number/parse_digit(digit):
  return digit - '0'

def Number/parse_integer(str):
  # converts intergers string to int 
  acc = 0
  fold str with acc:
    case String/Nil:
      return acc
    case String/Cons:
      return str.tail(10*acc + Number/parse_digit(str.head))


def main():
  return Number/parse_integer("123")
