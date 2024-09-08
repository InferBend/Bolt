##############################
# Author: Nihal Srivastava, Jun 2024
##############################

# List imports

from ../utils/types/List import (List/index, List/append, List/contains)
from ../utils/helper import sort
from ../utils/math import (sum, log)
from ../utils/random import *


def List/lengthInt(x):
  match x:
    case List/Cons:
      return (List/lengthInt(x.tail) + 1)
    case List/Nil:
      return 0


def Set/add(x, val):
  match x:
    case List/Cons:
      if x.head == val:
        return x
      else:
        return List/concat([x.head], Set/add(x.tail, val))
    case List/Nil:
      return [val]


def log2(z):
  return log(z) / log(2.0)


def List/bulkIndex/aux(x, indexes, y):
  match indexes:
    case List/Cons:
      y = List/append(y, List/index(x, indexes.head))
      return List/bulkIndex/aux(x, indexes.tail, y)
    case List/Nil:
      return y


def List/bulkIndex(x, indexes):
  return List/bulkIndex/aux(x, indexes, [])


def List/getColumn/aux(X, feat_idx, y):
  match X:
    case List/Cons:
      y = List/append(y, List/index(X.head, feat_idx))
      return List/getColumn/aux(X.tail, feat_idx, y)
    case List/Nil:
      return y


def List/getColumn(X, feat_idx):
  return List/getColumn/aux(X, feat_idx, [])


def divideScalar/aux(x, value, y):
  match x:
    case List/Cons:
      y = List/append(y, x.head / to_f24(value))
      return divideScalar/aux(x.tail, value, y)
    case List/Nil:
      return y


def divideScalar(x, value):
  return divideScalar/aux(x, value, [])


def find_unique(ls, s):
  match ls:
    case List/Cons:
      k = List/contains(s, ls.head)
      if k != 1:
        s = Set/add(s, ls.head)
        return find_unique(ls.tail, s)
      else:
        return find_unique(ls.tail, s)
    case List/Nil:
      return s

#################################


def mode/aux(x, count, previous, maxCount, currentMax):
  match x:
    case List/Cons:
      if x.head == previous:
        return mode/aux(x.tail, count + 1, x.head, maxCount, currentMax)
      else:
        if maxCount < count:
          return mode/aux(x.tail, 1, x.head, count, previous)
        else:
          return mode/aux(x.tail, 1, x.head, maxCount, currentMax)
    case List/Nil:
      if maxCount < count:
        return previous
      else:
        return currentMax


def mode(x):
  return mode/aux(x, 0, -1, 0, -1)


def List/createRange(current, upper, y):
  if current == upper:
    return y
  else:
    y = List/append(y, current)
    return List/createRange(current + 1, upper, y)


def List/getTopK(x, k, y):
  if (k > 0):
    match x:
      case List/Cons:
        y = List/append(y, x.head)
        return List/getTopK(x.tail, k - 1, y)
      case List/Nil:
        return y
  else:
    return y


def argwhere/aux(x, limit, isGreater, y, index):
  match x:
    case List/Cons:
      if isGreater == 1:
        if x.head > limit:
          y = List/append(y, index)
          return argwhere/aux(x.tail, limit, isGreater, y, index + 1)
        else:
          return argwhere/aux(x.tail, limit, isGreater, y, index + 1)
      else:
        if x.head < limit | x.head == limit:
          y = List/append(y, index)
          return argwhere/aux(x.tail, limit, isGreater, y, index + 1)
        else:
          return argwhere/aux(x.tail, limit, isGreater, y, index + 1)
    case List/Nil:
      return y


def argwhere(x, limit, isGreater):
  # x == list, limit == condition value, isGreater == > operation between element and limit
  return argwhere/aux(x, limit, isGreater, [], 0)


def bincount/aux(x, y, value, count):
  match x:
    case List/Cons:
      if x.head == value:
        return bincount/aux(x.tail, y, value, count + 1.0)
      else:
        y = List/append(y, count)
        return bincount/aux(x, y, value + 1.0, 0.0)
    case List/Nil:
      y = List/append(y, count)
      return y


def bincount(x):
  x = sort(x)
  return bincount/aux(x, [], 0.0, 0.0)


def entropy/aux(ps, y):
  match ps:
    case List/Cons:
      if ps.head > 0.0:
        e = ps.head * log2(ps.head)
        y = List/append(y, e)
        return entropy/aux(ps.tail, y)
      else:
        return entropy/aux(ps.tail, y)
    case List/Nil:
      return y


def entropy(x):
  hist = bincount(x)
  (l, x) = List/length(x)
  ps = divideScalar(hist, l)

  return (-1.0 * sum(entropy/aux(ps, [])))


type DecisionTree:
  Node {feature, threshold, ~left, ~right}
  Leaf {value}


def isLeafNode(x):
  match x:
    case DecisionTree/Node:
      return 0
    case DecisionTree/Leaf:
      return 1


def DecisionTree/fit(X, y):
  max_depth = 100
  min_samples_split = 2
  match X:
    case List/Cons:
      n_feats = List/lengthInt(X.head)
    case List/Nil:
      n_feats = 0

  tree = DecisionTree/growTree(X, y, 0, max_depth, min_samples_split, n_feats)
  return tree


def getCount(y, counter, prev):
  match y:
    case List/Cons:
      if y.head == prev:
        counter = Map/set(counter, y.head, counter[y.head] + 1.0)
        return getCount(y.tail, counter, y.head)
      else:
        counter = Map/set(counter, y.head, 1.0)
        return getCount(y.tail, counter, y.head)
    case List/Nil:
      return counter


def mostCommonLabel/aux(counter, unique_y, max_count, value):
  match unique_y:
    case List/Cons:
      if counter[unique_y.head] > max_count:
        return mostCommonLabel/aux(counter, unique_y.tail, counter[unique_y.head], unique_y.head)
      else:
        return mostCommonLabel/aux(counter, unique_y.tail, max_count, value)
    case List/Nil:
      return value


def DecisionTree/mostCommonLabel(y):
  y = sort(y)
  counter = getCount(y, {}, -1.0)
  unique_y = find_unique(y, [])
  most_common_label = mostCommonLabel/aux(counter, unique_y, 0, -1.0)

  return most_common_label


def DecisionTree/growTree(X, y, depth, max_depth, min_samples_split, n_feats):
  n_samples = List/lengthInt(X)
  n_features = 0
  match X:
    case List/Cons:
      n_features = List/lengthInt(X.head)
    case List/Nil:
      n_features = 0

  n_labels = List/lengthInt(find_unique(y, []))

  if (depth > max_depth | n_labels == 1 | n_samples < min_samples_split):
    # leaf_value = DecisionTree/mostCommonLabel(y)
    leaf_value = mode(y)
    return DecisionTree/Leaf(leaf_value)
  else:
      # feat_idxs = choice(n_features, n_feats)
    feat_idxs = List/shuffle(List/createRange(0, n_features, []), 43.0)
    feat_idxs = List/getTopK(feat_idxs, n_feats, [])

    (best_feat, best_thresh) = bestCriteria(X, y, feat_idxs)

    (left_idxs, right_idxs) = split(List/getColumn(X, best_feat), best_thresh)

    left = DecisionTree/growTree(List/bulkIndex(X, left_idxs), List/bulkIndex(
        y, left_idxs), depth + 1, max_depth, min_samples_split, n_feats)

    right = DecisionTree/growTree(List/bulkIndex(X, right_idxs), List/bulkIndex(
        y, right_idxs), depth + 1, max_depth, min_samples_split, n_feats)

    return DecisionTree/Node(best_feat, best_thresh, left, right)


def bestCriteria/aux2(X_column, y, thresholds, best_gain, split_idx, split_thresh, feat_idx):
  match thresholds:
    case List/Cons:
      gain = informationGain(y, X_column, thresholds.head)
      if (gain > best_gain):
        return bestCriteria/aux2(X_column, y, thresholds.tail, gain, feat_idx, thresholds.head, feat_idx)
      else:
        return bestCriteria/aux2(X_column, y, thresholds.tail, best_gain, split_idx, split_thresh, feat_idx)
    case List/Nil:
      return (best_gain, split_idx, split_thresh)


def bestCriteria/aux(X, y, feat_idxs, best_gain, split_idx, split_thresh):
  match feat_idxs:
    case List/Cons:
      X_column = List/getColumn(X, feat_idxs.head)
      thresholds = find_unique(X_column, [])
      (best_gain, split_idx, split_thresh) = bestCriteria/aux2(X_column, y, thresholds, best_gain, split_idx, split_thresh, feat_idxs.head)
      return bestCriteria/aux(X, y, feat_idxs.tail, best_gain, split_idx, split_thresh)
    case List/Nil:
      return (split_idx, split_thresh)


def bestCriteria(X, y, feat_idxs):
  best_gain = -1.0
  split_idx = -1.0
  split_thresh = -1.0

  return bestCriteria/aux(X, y, feat_idxs, best_gain, split_idx, split_thresh)


def informationGain(y, X_column, split_thresh):
  parent_entropy = entropy(y)
  (left_idxs, right_idxs) = split(X_column, split_thresh)

  (n_l, left_idx) = List/length(left_idxs)
  (n_r, right_idx) = List/length(left_idxs)

  if (n_l == 0 | n_r == 0):
    return 0.0
  else:
    (n, y) = List/length(y)
    e_l = entropy(List/bulkIndex(y, left_idxs))
    e_r = entropy(List/bulkIndex(y, right_idxs))
    child_entropy = (n_l / n) * e_l + (n_r / n) * e_r
    ig = parent_entropy - child_entropy

    return ig


def split(X_column, split_thresh):
  left_idx = argwhere(X_column, split_thresh, 0)
  right_idx = argwhere(X_column, split_thresh, 1)

  return (left_idx, right_idx)


def DecisionTree/traverseTree(x, node):
  match node:
    case DecisionTree/Node:
      if (List/index(node.feature) < node.threshold):
        return DecisionTree/traverseTree(x, node.left)
      else:
        return DecisionTree/traverseTree(x, node.right)
    case DecisionTree/Leaf:
      return node.value


def main():
  X = [[5.0, 3.0, 4.0], [3.0, 2.0, 2.0], [1.5, 9.0, 7.0], [7.0, 2.0, 3.0], [
      1.0, 12.0, 4.0], [2.0, 5.0, 3.0], [3.0, 6.0, 2.0], [2.0, 6.0, 2.5], [1.9, 5.8, 5.9]]
  y = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.0, 2.0]
  # tree = DecisionTree/fit(X, y)

  # x = [2.0, 7.0, 5.4]
  # pred = DecisionTree/traverseTree(x, tree)

  return 1
