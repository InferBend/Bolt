##############################
# Author: Nihal Srivastava, Jun 2024
##############################

from ../utils/types/List import *
from ../utils/stats import (distance, mode)


def sort(xs):
  match xs:
    case List/Nil:
      return List/Nil
    case List/Cons:
      return insert(xs.head, sort(xs.tail))


def insert(v, xs):
  match xs:
    case List/Nil:
      return List/Cons(v, List/Nil)
    case List/Cons:
      return swap_gt(v, xs.head, xs.tail)


def swap_gt(v, x, xs):
  (f1, e1) = v
  (f2, e2) = x
  if f2 > f1:
    return List/Cons(v, List/Cons(x, xs))
  else:
    return List/Cons(x, insert(v, xs))


def distanceBetweenPoints(points, x):
  match points:
    case List/Cons:
      return distance(points.head, x) + distanceBetweenPoints(points.tail, x)
    case List/Nil:
      return 0.0


def knn/getDistances(X, p, distances):
  match X:
    case List/Cons:
      d = distance(X.head, p)
      distances = List/append(distances, d)
      return knn/getDistances(X.tail, p, distances)
    case List/Nil:
      return distances


def List/indexedArray(a, i, c):
  match a:
    case List/Cons:
      c = List/append(c, (a.head, i))
      return List/indexedArray(a.tail, i + 1, c)
    case List/Nil:
      return c


def knn/aux(nearestPoints, y, k, nearestYs):
  if k == 0:
    return nearestYs
  else:
    match nearestPoints:
      case List/Cons:
        (distance, index) = nearestPoints.head
        p = List/index(y, index)
        nearestYs = List/append(nearestYs, p)
        return knn/aux(nearestPoints.tail, y, k - 1, nearestYs)
      case List/Nil:
        return nearestYs


def Knn/fit_predict(X, y, p, k):
  distances = knn/getDistances(X, p, [])
  distances = List/indexedArray(distances, 0, [])
  nearestPoints = sort(distances)
  nearestYs = knn/aux(nearestPoints, y, k, [])

  return mode(nearestYs)


def main():
  X = [[5.0, 3.0, 4.0], [3.0, 2.0, 2.0], [1.5, 9.0, 7.0], [7.0, 2.0, 3.0], [
      1.0, 12.0, 4.0], [2.0, 5.0, 3.0], [3.0, 6.0, 2.0], [2.0, 6.0, 2.5], [1.9, 5.8, 5.9]]
  y = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.0, 2.0]
  p = [2.0, 7.0, 5.4]
  k = 3

  nearest = Knn/fit_predict(X, y, p, k)

  return nearest
