from ./preprocessing/_standardScaler import (StandardScaler, standard_scaler, transform)
from ./utils/testing import assert_equal

# @TODO: Move to testing.bend


def assert_multi_array(l1, l2):
  match l1:
    case List/Cons:
      match l2:
        case List/Cons:
          if (assert_equal(l1.head, l2.head) == 1):
            return assert_multi_array(l1.tail, l2.tail)
          else:
            return 0
        case List/Nil:
          return 0
    case List/Nil:
      match l2:
        case List/Cons:
          return 0
        case List/Nil:
          return 1


def main():
  x = [[1.0, 2.0], [10.0, 5.0]]
  model = standard_scaler(x)
  open StandardScaler: model

  # 1 for standard scaling -1 for inverse
  res = transform(x, model, 1)
  out = transform(res, model, -1)

  if assert_multi_array(res, [[-1.0, -1.0], [1.0, 1.0]]) & assert_multi_array(out, x):
    return "PASS"
  else:
    return "FAIL"
