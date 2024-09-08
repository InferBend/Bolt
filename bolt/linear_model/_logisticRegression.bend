##############################
# Author: Jaisuraj Bantupalli, August 2024
##############################
from ./_linearRegression import (gradientDescent)
from ../utils/types/List import List/append
from ../utils/vector import *
from ../utils/math import (sum, abs)

type LogisticRegression:
  Model {weights, bias, cost}

def sigmoid_helper(z):
  si= 1.0 + 2.718281829**(0.0 - z)
  return 1.0/si


def sigmoid(ls):
  match ls:
    case List/Cons:
      return List/Cons(sigmoid_helper(ls.head), sigmoid(ls.tail))
    case List/Nil:
      return List/Nil


def predict1(x, weight, bias):
  z = (x * weight) + bias
  return sigmoid(z)

def classify_helper(prob,l):
  match prob:
    case List/Cons:
      if prob.head>0.5:
        l=List/append(l,1.0)
      else:
        l=List/append(l,0.0)
      return classify_helper(prob.tail,l)
    case List/Nil:
      return l

def classify(prob):
  k=classify_helper(prob,[])
  return k


def predict_helper(x,w,b):
  k=multiply_helper(x,w,[],[],b)
  sig=sigmoid(k)
  return sig

def multiply_helper(x,weights,k,l,bias):
  match x:
    case List/Cons:
      kk1=sum(multiply(x.head, weights, []), []) + bias
    #   kk=multiply(x.head,weights,[])
      l=List/append(l,kk1)
      return multiply_helper(x.tail,weights,k,l,bias)
    case List/Nil:
      return l

def LogisticRegression/fit(x,y):
  (weights, bias, costs) = gradientDescent(x, y, 100, 0.0001, 0.000001)
  return LogisticRegression/Model(weights, bias, costs)


def LogisticRegression/predict(model, x):
  match model:
    case LogisticRegression/Model:
      y_pred = predict_helper(x, model.weights, model.bias)
      y_class = classify(y_pred)
      return y_class



def main():
  x= [[1.0, 45.0, 85.0],
     [1.0, 50.0, 43.0],
     [1.0, 54.0, 78.0],
     [1.0, 60.0, 58.0],
     [1.0, 63.0, 72.0],
     [1.0, 67.0, 80.0],
     [1.0, 70.0, 65.0],
     [1.0, 73.0, 90.0],
     [1.0, 75.0, 60.0],
     [1.0, 80.0, 85.0]]


  y = [1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0]


  lr_model = LogisticRegression/fit(x, y)
  x_test = [[1.0, 68.0, 82.0],
                   [1.0, 54.0, 78.0],
                   [1.0, 10.0, 95.0]]

  y_pred= LogisticRegression/predict(lr_model,x_test)
#   y_check= pred_11
  return y_pred
