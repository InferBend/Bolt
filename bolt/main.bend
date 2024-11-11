from linear_model/_naiveBayes import(naive_bayes)
from preprocessing/_oneHotEncoding import(onehotencoder)
from utils/types/List import(List/append)
from utils/vector import(transpose)

def helpr(x,x_train):
  match x:
    case List/Cons:
      x1=onehotencoder(x.head)
      x_train=List/append(x_train,x1)
      return helpr(x.tail,x_train)
    case List/Nil:
      return x_train

def main():
  # X = [[5.0, 3.0, 4.0], [3.0, 2.0, 2.0], [1.5, 9.0, 7.0], [7.0, 2.0, 3.0], [
  #     1.0, 12.0, 4.0], [2.0, 5.0, 3.0], [3.0, 6.0, 2.0], [2.0, 6.0, 2.5], [1.9, 5.8, 5.9]]
  # y = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.0, 2.0]
  # xn = [2.0, 7.0, 5.4]
  # k = 3

  # yn = Knn/fit_predict(X, y, xn, 5)
  # return yn
  # x= [[1.0, 45.0, 85.0],[1.0, 50.0, 43.0],
  #    [1.0, 54.0, 78.0],
  #    [1.0, 60.0, 58.0],
  #    [1.0, 63.0, 72.0],
  #    [1.0, 67.0, 80.0],
  #    [1.0, 70.0, 65.0],
  #    [1.0, 73.0, 90.0],
  #    [1.0, 75.0, 60.0],
  #    [1.0, 80.0, 85.0]]


  # y = [1.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0]


  # lr_model = LogisticRegression/fit(x, y)
  # x_test = [[1.0, 68.0, 82.0],
  #                  [1.0, 65.0, 25.0],
  #                  [1.0, 54.0, 78.0]]

  # y_pred= LogisticRegression/predict(lr_model,x_test)
  # return y_pred
  y=["no", "no", "yes", "maybe", "yes", "maybe", "yes", "no", "maybe", "yes", "yes", "yes", "yes", "maybe"]
  x=["sunny", "sunny", "overcast", "rainy", "rainy", "rainy", "overcast", "sunny", "sunny", "rainy", "sunny", "overcast", "overcast", "rainy"]
    
  x=onehotencoder(x)
  y=onehotencoder(y)
  # x=[0, 0, 1, 2, 2, 2, 1, 0, 0, 2, 0, 1, 1, 2]
  # y=[0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0]
  return naive_bayes(x,y)
