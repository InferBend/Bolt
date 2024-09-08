##############################
# Author: Nihal Srivastava, May 2024
##############################
# String Data Structure - Imp Syntax #

from ./List import List/append


def String/concat(x, y):
  match x:
    case String/Cons:
      return String/Cons(x.head,String/concat(x.tail, y))
    case String/Nil:
      return y


def String/append(x, val):
  return String/concat(x, String/Cons(val, String/Nil))


def String/index(s, idx):
  match s:
    case String/Cons:
      if idx == 0:
        return s.head
      else:
        return String/index(s.tail, idx + (-1))
    case String/Nil:
      return "Out of bound"


def String/splitAtLetter/aux(s1, s2, value):
  match s2:
    case String/Cons:
      if s2.head == value:
        return (s1, s2.tail)
      else:
        return String/splitAtLetter/aux(String/append(s1, s2.head), s2.tail, value)
    case String/Nil:
      return (s1, s2)


def String/splitAtLetter(s, value):
  return String/splitAtLetter/aux("", s, value)


def String/splitToList(s, delimiter, l):
  match s:
    case String/Cons:
      (s1, s2) = String/splitAtLetter(s, delimiter)
      l = List/append(l, s1)
      return String/splitToList(s2, delimiter, l)
    case String/Nil:
      return l


def string_length(s):
  match s:
    case String/Cons:
      return 1 + string_length(s.tail)
    case String/Nil:
      return 0


def string_equal(s1, s2):
  l1 = string_length(s1)
  l2 = string_length(s2)
  if l1 != l2:
    return 0
  else:
    match s1:
      case String/Cons:
        match s2:
          case String/Cons:
            if s1.head == s2.head:
              return string_equal(s1.tail, s2.tail)
            else:
              return 0
          case String/Nil:
            return 0
      case String/Nil:
        match s2:
          case String/Nil:
            return 1
          case _:
            return 0


def main():
  l = String/splitToList("Hello,world,test", ',', [])
  return l
