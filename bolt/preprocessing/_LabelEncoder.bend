##############################
# Author: Jaisuraj Bantupalli, May 2024
##############################

from ../utils/types/String import (string_length, string_equal)
from ../utils/types/List import List/append

object LabelEncoder {classes, inverse_classes}

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


def ascii(d):
  match d:
    case String/Cons:
      return d.head + ascii(d.tail)*10
    case String/Nil:
      return 0


def create_category_index_map(categories, index_map, index):
  match categories:
    case List/Cons:
      ascii_value = ascii(categories.head)
      updated_map = Map/set(index_map,categories.head,index)
      return create_category_index_map(categories.tail, updated_map, index + 1.0)
    case List/Nil:
      return index_map


def generate_class_map(ls, l, l1, idx, mp):
  if idx < l:
    match ls:
      case List/Cons:
        l1 = List/append(l1, ascii(ls.head))
        mp = Map/set( mp, ascii(ls.head), idx)
        return generate_class_map(ls.tail, l, l1, idx+1, mp)
      case List/Nil:
        return mp
  else:
    return mp


def LabelEncoder/aux(y, mp, l):
  match y:
    case List/Cons:
      k = ascii(y.head)
      l = List/append(l, mp[k])
      return LabelEncoder/aux(y.tail, mp, l)
    case List/Nil:
      return l

def generate_inverse_map(uniqueValues, idx, l, class_map, inverse_map):
  if idx < l:
    match uniqueValues:
      case List/Cons:
        inverse_map = Map/set( inverse_map, idx, uniqueValues.head)
        return generate_inverse_map(uniqueValues.tail, idx+1, l, class_map, inverse_map)
      case List/Nil:
        return inverse_map
  else:
    return inverse_map

def LabelEncoder/fit(y: List(String)):
  encoded = find_unique(y, [])
  (l, encoded) = List/length(encoded)
  class_map = generate_class_map(encoded, l, [], 0, {})
  inverse_map = generate_inverse_map(encoded, 0, l, class_map, {})

  return LabelEncoder {classes: class_map, inverse_classes: inverse_map}

def LabelEncoder/transform(model, y):
  open LabelEncoder: model
  return LabelEncoder/aux(y, model.classes, [])

def LabelEncoder/inverse_aux(y, mp, l):
  match y:
    case List/Cons:
      l = List/append(l, mp[y.head])
      return LabelEncoder/aux(y.tail, mp, l)
    case List/Nil:
      return l

def LabelEncoder/inverse_transform(model, y):
  open LabelEncoder: model
  return LabelEncoder/inverse_aux(y, model.inverse_classes, [])

def main():
  y = ["XYZ", "X", "Y", "Z", "X", "Y", "ZXY"]
  
  labelEncoder = LabelEncoder/fit(y)
  open LabelEncoder: labelEncoder
  res = LabelEncoder/transform(labelEncoder, y)
  out = LabelEncoder/inverse_transform(labelEncoder, res)
  return out
