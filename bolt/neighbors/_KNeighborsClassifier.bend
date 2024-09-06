##############################
# Author: Nihal Srivastava, May 2024
##############################

from ../utils/types/List import *
from ../utils/helper import sort
from ../utils/stats import (distance, mode)


def distanceBetweenPoints(points, x):
  match points:
    case List/Cons:
      return distance(points.head, x) + distanceBetweenPoints(points.tail, x)
    case List/Nil:
      return 0.0


def topKIndex(distances, i, n):
  if i < n + 1:
    match distances[i]:
      case List/Cons:
        d1 = List/index(distances[i], 0)
        (d2, i2) = topKIndex(distances, i + 1, n)
        if d1 < d2:
          return (d1, i)
        else:
          return (d2, i2)
      case List/Nil:
        return (9999.99, -1)
  else:
    return (99999.99, -1)


def knn/getDistances/aux(points, x, distances):
  match points:
    case List/Cons:
      d = distance(points.head, x)
      distances = List/append(distances, d)
      return knn/getDistances/aux(points.tail, x, distances)
    case List/Nil:
      return distances


def knn/getDistances(dataset, x, distances, i, n):
  if i < n + 1:
    distances_group = knn/getDistances/aux(dataset[i], x, [])
    distances[i] = sort(distances_group)
    return knn/getDistances(dataset, x, distances, i + 1, n)
  else:
    return distances


def knn/aux(distances, k, nearest):
  if k > 0:
    (d, i) = topKIndex(distances, 0, 2)
    (e, l) = List/popFront(distances[i])
    distances[i] = l
    nearest = List/append(nearest, i)
    return knn/aux(distances, k - 1, nearest)
  else:
    return nearest


def knnMain(dataset, p, k, n_class):
  distances = knn/getDistances(dataset, p, {}, 0, n_class)
  nearest = knn/aux(distances, k, [])
  nearest = sort(nearest)
  pred = mode(nearest)
  return pred


def emptyDict(dataset, n_class):
  if n_class == -1:
    return dataset
  else:
    dataset[n_class] = []
    return emptyDict(dataset, n_class - 1)


def makeDataset/aux(X, y, dataset):
  match y:
    case List/Cons:
      match X:
        case List/Cons:
          dataset[y.head] = List/append(dataset[y.head], X.head)
          return makeDataset/aux(X.tail, y.tail, dataset)
        case List/Nil:
          return dataset
    case List/Nil:
      return dataset


def makeDataset(X, y, n_class):
  dataset = emptyDict({}, n_class)
  dataset = makeDataset/aux(X, y, dataset)

  return dataset


def main():
  X = [[5.0, 3.0, 4.0], [3.0, 2.0, 2.0], [1.5, 9.0, 7.0], [7.0, 2.0, 3.0], [
      1.0, 12.0, 4.0], [2.0, 5.0, 3.0], [3.0, 6.0, 2.0], [2.0, 6.0, 2.5], [1.9, 5.8, 5.9]]
  y = [0, 0, 0, 0, 1, 1, 1, 2, 2]
  p = [2.0, 7.0, 5.4]
  k = 3
  n_class = 2

  dataset = makeDataset(X, y, n_class)
  nearest = knnMain(dataset, p, k, n_class)

  return nearest
