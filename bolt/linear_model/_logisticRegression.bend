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

def classify_helper(prob, l):
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
  prob_list=classify_helper(prob,[])
  return prob_list


def predict_helper(x, w, b):
  mlr_output=multiply_helper(x,w,[],[],b)
  logistic_regression_probabilities=sigmoid(mlr_output)
  return logistic_regression_probabilities

def multiply_helper(x, weights, k, mlr_output, bias):
  match x:
    case List/Cons:
      mlr_single_output=sum(multiply(x.head, weights, []), []) + bias
      mlr_output=List/append(mlr_output,mlr_single_output)
      return multiply_helper(x.tail,weights,k,mlr_output,bias)
    case List/Nil:
      return mlr_output

def LogisticRegression/fit(x: List(List(f24)), y: List(f24), max_iter: u24, learning_rate: f24, tol: f24):
  (weights, bias, costs) = gradientDescent(x, y, max_iter, learning_rate, tol)
  return LogisticRegression/Model(weights, bias, costs)


def LogisticRegression/predict(model, x):
  match model:
    case LogisticRegression/Model:
      y_pred = predict_helper(x, model.weights, model.bias)
      y_pred_classes = classify(y_pred)
      return y_pred_classes

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

  max_iter = 100
  learning_rate = 0.0001
  tol = 0.0001


  logreg_model = LogisticRegression/fit(x, y, max_iter, learning_rate, tol)
  x_test = [[1.0, 68.0, 82.0],
                   [1.0, 54.0, 78.0],
                   [1.0, 10.0, 95.0]]
  y_pred_classes= LogisticRegression/predict(logreg_model,x_test)
  return y_pred_classes
