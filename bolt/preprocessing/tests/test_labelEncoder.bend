from ./preprocessing/_LabelEncoder import (LabelEncoder, LabelEncoder/fit, LabelEncoder/transform, LabelEncoder/inverse_transform)
from ./utils/testing import (assert_equal, assert_equal_string_array)

def main():
  y = ["XYZ", "X", "Y", "Z", "X", "Y", "ZXY"]
  
  labelEncoder = LabelEncoder/fit(y)
  open LabelEncoder: labelEncoder
  res = LabelEncoder/transform(labelEncoder, y)
  out = LabelEncoder/inverse_transform(labelEncoder, res)

  actual_encoded = [0, 1, 2, 3, 1, 2, 4]

  if assert_equal(actual_encoded, res) & assert_equal_string_array(y, out):
    return "PASS"
  else:
    return "FAIL"
