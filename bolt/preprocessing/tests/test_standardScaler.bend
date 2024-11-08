from ./preprocessing/_standardScaler import (StandardScaler, StandardScaler/fit, StandardScaler/transform, StandardScaler/inverse_transform)
from ./utils/testing import assert_multi_array

def main():
  x = [[1.0, 2.0], [10.0, 5.0]]
  model = StandardScaler/fit(x)
  open StandardScaler: model

  res = StandardScaler/transform(model, x)
  out = StandardScaler/inverse_transform(model, res)

  if assert_multi_array(res, [[-1.0, -1.0], [1.0, 1.0]]) & assert_multi_array(out, x):
    return "PASS"
  else:
    return "FAIL"
