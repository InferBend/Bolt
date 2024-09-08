##############################
# Author: Jaisuraj Bantupalli, May 2024
##############################

from ../utils/types/String import (string_length, string_equal)
from ../utils/types/List import List/append


def map_string_lengths(lst):
  match lst:
    case List/Cons:
      return List/Cons(string_length(lst.head), map_string_lengths(lst.tail))
    case List/Nil:
      return List/Nil


def List/contains(lst, value):
  match lst:
    case List/Cons:
      if string_equal(lst.head, value) == 1:
        return 1
      else:
        return List/contains(lst.tail, value)
    case List/Nil:
      return 0


def Set/add(x, val):
  match x:
    case List/Cons:
      if string_equal(x.head, val) == 1:
        return x
      else:
        return List/Cons(x.head,Set/add(x.tail, val))
    case List/Nil:
      return List/Cons(val, List/Nil)


def find_unique(ls, s):
  match ls:
    case List/Cons:
      k = List/contains(s, ls.head)
      if k != 1:
        s = Set/add(s, ls.head)
        return find_unique(ls.tail, s)
      else:
        return find_unique(ls.tail, s)
    case List/Nil:
      return s


def asc(d):
  match d:
    case String/Cons:
      return d.head + asc(d.tail)*10
    case String/Nil:
      return 0


def create_category_index_map(categories, index_map, index):
  match categories:
    case List/Cons:
      ascii_value = asc(categories.head)
      updated_map = Map/set(index_map,categories.head,index)
      return create_category_index_map(categories.tail, updated_map, index + 1.0)
    case List/Nil:
      return index_map


def gen_map(ls, l, l1, idx, mp):
  if idx < l:
    match ls:
      case List/Cons:
        l1 = List/append(l1, asc(ls.head))
        mp = Map/set( mp, asc(ls.head), idx)
        return gen_map(ls.tail, l, l1, idx+1, mp)
      case List/Nil:
        return mp
  else:
    return mp


def onehotencode_helper(y, mp, l):
  match y:
    case List/Cons:
      k = asc(y.head)
      l = List/append(l, mp[k])
      return onehotencode_helper(y.tail, mp, l)
    case List/Nil:
      return l


def onehotencoder(y):
  encoded = find_unique(y, [])
  (l, encoded) = List/length(encoded)
  mp = gen_map(encoded, l, [], 0, {})
  res = onehotencode_helper(y, mp, [])
  return res


def main():
  y = ["XYZ", "X", "Y", "Z", "X", "Y", "ZXY"]
  res = onehotencoder(y)
  return res
