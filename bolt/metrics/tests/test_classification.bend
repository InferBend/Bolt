from ./metrics/_classification import (accuracy_score)

def check_accuracyScore():
  y1 = [1.0, 2.0, 3.0, 4.0, 5.0]
  y2 = [1.0, 0.0, -1.0, 4.0, 5.0]

  return accuracy_score(y1, y2) == 0.6

def main():
  if check_accuracyScore():
    return "PASS"
  else:
    return "FAIL"