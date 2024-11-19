from ../utils/random import (List/shuffle)
from ../utils/types/List import (List/index, List/appendFront, List/split)

def split_helper(x, test_size, shuffle, random_state):
  (n, x) = List/length(x)
  split_index = f24/to_u24(u24/to_f24(n) * (1.0 - test_size))

  if(shuffle == 1):
    (x, seed) = List/shuffle(x, random_state)
  else:
    (x, seed) = (x, random_state)

  (train_data, test_data) = List/split(x, split_index)

  return (train_data, test_data)

def train_test_split(arrays, test_size, shuffle, random_state):
  match arrays:
    case List/Cons:
      return List/appendFront(train_test_split(arrays.tail, test_size, shuffle, random_state), split_helper(arrays.head, test_size, shuffle, random_state))
    case List/Nil:
      return []
    
def main():
  X = [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0], [7.0, 8.0, 9.0], [10.0, 11.0, 12.0], [13.0, 14.0, 15.0]]
  y = [1.0, 2.0, 3.0, 4.0, 5.0]

  dataset = train_test_split([X, y], 0.25, 1, 1.0)
  X_train, X_test = List/index(dataset, 0)
  y_train, y_test = List/index(dataset, 1)
  return y_test