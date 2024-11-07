from ./preprocessing/_standardScaler import (StandardScaler, standard_scaler, transform)
from ./utils/testing import assert_multi_array

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
