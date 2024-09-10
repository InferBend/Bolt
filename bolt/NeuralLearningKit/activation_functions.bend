from ../utils/math import (max, sum)
from ../utils/types/List import List/append
from ../utils/vector import (subtractScalar, divideScalar)

e = 2.718281829

def sigmoid/aux(z):
  # sig(x) = 1 / (1 + e ^ -x )
  si = 1.0 + e**(0.0 - z)
  return 1.0/si


def sigmoid(ls):
  match ls:
    case List/Cons:
      return List/Cons(sigmoid/aux(ls.head), sigmoid(ls.tail))
    case List/Nil:
      return List/Nil
    
def dSigmiod/aux(x):
  # dsig(x) = sig(x)(1 - sig(x))
  return sigmoid/aux(x) * (1.0 - sigmoid/aux(x))

def dSigmoid(ls):
  match ls:
    case List/Cons:
      return List/Cons(dSigmiod/aux(ls.head), dSigmoid(ls.tail))
    case List/Nil:
      return List/Nil

def relu/aux(x):
  return max(0.0, x)

def relu(ls):
  match ls:
    case List/Cons:
      return List/Cons(relu/aux(ls.head), relu(ls.tail))
    case List/Nil:
      return List/Nil

def dRelu/aux(x):
  if(x > 0.0):
    return 1.0
  else:
    return 0.0

def dRelu(ls):
  match ls:
    case List/Cons:
      return List/Cons(dRelu/aux(ls.head), dRelu(ls.tail))
    case List/Nil:
      return List/Nil

def exponential(x, ls):
  match x:
    case List/Cons:
      return exponential(x.tail, List/append(ls, e**x.head))
    case List/Nil:
      return ls

def maxElement/aux(ls, maxx):
  match ls:
    case List/Cons:
      return maxElement/aux(ls.tail, max(ls.head, maxx))
    case List/Nil:
      return maxx

def maxElement(ls):
  match ls:
    case List/Cons:
      return maxElement/aux(ls.tail, ls.head)
    case List/Nil:
      return "ERROR"

def softmax(ls):
  max_value = maxElement(ls)
  exp_values = exponential(subtractScalar(ls, max_value, []), [])
  total = sum(exp_values)
  probabilities = divideScalar(exp_values, total, [])

  return probabilities

def swish/aux(x):
  return x * sigmoid/aux(x)

def swish(ls):
  match ls:
    case List/Cons:
      return List/Cons(swish/aux(ls.head), swish(ls.tail))
    case List/Nil:
      return List/Nil

def dSwish/aux(x):
  return swish/aux(x) + sigmoid/aux(x) * (1 - swish/aux(x))

def dSwish(ls):
  match ls:
    case List/Cons:
      return List/Cons(dSwish/aux(ls.head), swish(ls.tail))
    case List/Nil:
      return List/Nil