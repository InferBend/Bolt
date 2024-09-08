##############################
# Author: Jaisuraj Bantupalli, August 2024
##############################
from ./_gradientDescent import (gradientDescent,List/append)

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

def predict_helper(y,w,b,l):
  match y:
    case List/Cons:
      d=predict1(y.head,w,b)
      l=List/append(l,d)
      return predict_helper(y.tail, w, b, l)
    case List/Nil:
      return l

def predict11(y,w,b):
  k=predict_helper(y,w,b,[])
  return k

def LogisticRegression/fit(x,y):
  (weights, bias, costs) = gradientDescent(x, y, 100, 0.0001, 0.000001)
  return LogisticRegression/Model(weights, bias, costs)

def LogisticRegression/predict(model, x):
  match model:
    case LogisticRegression/Model:
      y_pred = predict11(x, model.weights, model.bias)
      y_class = classify(y_pred)
      return y_class



def main():
  x = [32.502, 53.426, 61.530, 47.475, 59.813, 55.142, 52.211, 39.299, 48.105, 52.550,
       45.419, 54.351, 44.164, 58.168, 56.727, 48.955, 44.687, 60.297, 45.618, 38.816]
  y = [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0,
       0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0]

  lr_model = LogisticRegression/fit(x, y)
  x_test=[22.09,65.90,55.34]
  y_pred= LogisticRegression/predict(lr_model,x_test)
  return y_class
