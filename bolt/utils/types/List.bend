##############################
# Author: Nihal Srivastava, May 2024
##############################
# LIST Data Structure - Imp Syntax #

from ./String import String/concat

def List/clear(x):
  return []


def List/index(x, idx):
  match x:
    case List/Cons:
      if idx == 0:
        return x.head
      else:
        return List/index(x.tail, idx + (-1))
    case List/Nil:
      return "Out of bound"


def List/append(x, val):
  return List/concat(x, [val])


def List/appendFront(x, val):
  match x:
    case List/Cons:
      return List/concat([val], x)
    case List/Nil:
      return [val]


def List/popFront(x):
  match x:
    case List/Cons:
      return (x.head, x.tail)
    case List/Nil:
      return []


def List/popBack/aux(l, x):
  match x:
    case List/Nil:
      return List/Nil
    case List/Cons:
      if l == 0:
        return []
      else:
        return List/concat([x.head], List/popBack/aux(l - 1, x.tail))


def List/popBack(x):
  (l, x) = List/length(x)
  switch l - 1:
    case 0:
      return []
    case _:
      return List/popBack/aux(l - 1, x)


def List/split/aux(l1, l2, i):
  match l2:
    case List/Cons:
      switch i:
        case 0:
          return (l1, l2)
        case _:
          return List/split/aux(List/append(l1, l2.head), l2.tail, i - 1)
    case List/Nil:
      return *


def List/split(x, i):
  return List/split/aux([], x, i)


def List/popElement/aux(x, index, before):
  match x:
    case List/Cons:
      if index < 1.0:
        return (x.head, x.tail)
      else:
        before = List/append(before, x.head)
        (ele, remaining) = List/popElement(x.tail, index - 1.0)
        return (ele, List/concat(before, remaining))
    case List/Nil:
      return (0.0, List/Nil)


def List/popElement(x, index):
  return List/popElement/aux(x, index, [])


def List/contains(lst, elem):
  match lst:
    case List/Cons:
      if lst.head == elem:
        return 1
      else:
        return List/contains(lst.tail, elem)
    case List/Nil:
      return 0

def List/join/aux(ls, new_string, delimiter):
  match ls:
    case List/Cons:
      return List/join/aux(ls.tail, String/concat(new_string, String/concat(ls.head, delimiter)), delimiter)
    case List/Nil:
      return new_string

def List/join(ls, delimiter):
  return List/join/aux(ls, "", delimiter)