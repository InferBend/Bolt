from ../utils/math import (abs, sum)


def meanSquaredError/aux(yTrue, yPred):
  match yTrue:
    case List/Cons:
      match yPred:
        case List/Cons:
          return ((yTrue.head - yPred.head) ** 2.0) + meanSquaredError/aux(yTrue.tail, yPred.tail)
        case List/Nil:
          return 0.0
    case List/Nil:
      return 0.0


def meanSquaredError(yTrue, yPred):
  (l, yTrue) = List/length(yTrue)
  return meanSquaredError/aux(yTrue, yPred) / to_f24(l)


def meanAbsoluteError/aux(yTrue, yPred):
  match yTrue:
    case List/Cons:
      match yPred:
        case List/Cons:
          return abs(yTrue.head - yPred.head) + meanAbsoluteError/aux(yTrue.tail, yPred.tail)
        case List/Nil:
          return 0.0
    case List/Nil:
      return 0.0


def meanAbsoluteError(yTrue, yPred):
  (l, yTrue) = List/length(yTrue)
  return meanAbsoluteError/aux(yTrue, yPred) / to_f24(l)


def totalSumOfSquares/aux(yTrue, yMean):
  match yTrue:
    case List/Cons:
      return ((yTrue.head - yMean) ** 2.0) + totalSumOfSquares/aux(yTrue.tail, yMean)
    case List/Nil:
      return 0.0


def totalSumOfSquares(yTrue):
  (l, yTrue) = List/length(yTrue)
  yMean = sum(yTrue) / to_f24(l)
  return totalSumOfSquares/aux(yTrue, yMean)


def r2_score(yTrue, yPred):
  rss = meanSquaredError/aux(yTrue, yPred)
  tss = totalSumOfSquares(yTrue)
  r2 = 1.0 - (rss / tss)
  return r2


def main():
  y1 = [1.0, 2.0, 1.0, 1.1]
  y2 = [1.0, 1.5, 0.8, 1.1]

  return meanSquaredError(y1, y2)
