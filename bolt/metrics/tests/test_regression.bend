from ./metrics/_regression import (meanSquaredError, meanAbsoluteError, totalSumOfSquares, r2_score)

def check_meanSquaredError():
  y1 = [1.0, 0.0, -1.0]
  y2 = [0.8, -1.0, 0.0]

  return meanSquaredError(y1, y2) == 0.68

def check_meanAbsoluteError():
  y1 = [1.0, 0.0, -1.0]
  y2 = [0.8, -1.0, 0.0]

  return meanAbsoluteError(y1, y2) == 0.73333

def check_totalSumOfSquares():
  y = [0.8, -1.0, 1.0]

  return totalSumOfSquares(y) == 2.4266666

def check_r2_score():
  y1 = [1.0, 2.0, 0.0, -1.0]
  y2 = [1.0, 2.2, 0.2, -0.8]

  return (r2_score(y1, y1) == 1.00) & ((r2_score(y1, y2) == 0.9760))

def main():
  if check_meanSquaredError() & check_meanAbsoluteError() & check_totalSumOfSquares() & check_r2_score():
    return "PASS"
  else:
    return "FAIL"