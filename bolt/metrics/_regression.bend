# import List functions here

# decide about the helper functions

def abs(x):
  if x < 0.0:
    return -1.0 * x
  else:
    return x


def sum(x):
  match x:
    case List/Cons:
      return x.head + sum(x.tail)
    case List/Nil:
      return 0.0

#


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
  return meanSquaredError/aux(yTrue, yPred) / List/length(yTrue)


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
  return meanAbsoluteError/aux(yTrue, yPred) / List/length(yTrue)


def totalSumOfSquares/aux(yTrue, yMean):
  match yTrue:
    case List/Cons:
      return ((yTrue.head - yMean) ** 2.0) + totalSumOfSquares/aux(yTrue.tail, yMean)
    case List/Nil:
      return 0.0


def totalSumOfSquares(yTrue):
  yMean = sum(yTrue) / List/length(yTrue)
  return totalSumOfSquares/aux(yTrue, yMean)


def r2_score(yTrue, yPred):
  rss = meanSquaredError/aux(yTrue, yPred)
  tss = totalSumOfSquares(yTrue)
  r2 = 1.0 - (rss / tss)
  return r2
