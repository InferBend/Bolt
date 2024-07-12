def accuracy_score/aux(yTrue, yPred):
  match yTrue:
    case List/Cons:
      match yPred:
        case List/Cons:
          if yTrue.head == yPred.head:
            return accuracy_score/aux(yTrue.tail, yPred.tail) + 1.0
          else:
            return accuracy_score/aux(yTrue.tail, yPred.tail)
        case List/Nil:
          return 0.0
    case List/Nil:
      return 0.0


def accuracy_score(yTrue, yPred):
  (l, yTrue) = List/length(yTrue)
  return accuracy_score/aux(yTrue, yPred) / to_f24(l)
