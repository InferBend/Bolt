##############################
# Author: Jaisuraj Bantupalli, May 2024
##############################
##  TREE Data Structure - Imp Syntax ##

## This has Binary Search Tree (BST) and Binary Tree

type BinaryTree:
  Node { value, ~left, ~right }
  Leaf

type BinarySearchTree:
  Node { value, ~left, ~right }
  Leaf

# function to insert the value in binary search tree
def BinarySearchTree/insert(tree, value_to_insert):
  fold x = tree:
    case BinarySearchTree/Leaf:
      return BinarySearchTree/Node{value:value_to_insert, left:BinarySearchTree/Leaf, right:BinarySearchTree/Leaf}
    case BinarySearchTree/Node:
      if x.value > value_to_insert:
        return BinarySearchTree/Node{value:x.value, left:BinarySearchTree/insert(x.left, value_to_insert), right:x.right}
      else:
        return BinarySearchTree/Node{value:x.value, left:x.left, right:BinarySearchTree/insert(x.right, value_to_insert)}


# function to search for the value in binary search tree and returns true or false
def BinarySearchTree/search(tree, value_to_search):
  fold x = tree:
    case BinarySearchTree/Leaf:
      return 0
    case BinarySearchTree/Node:
      if x.value == value_to_search:
        return 1
      else:
        if x.value > value_to_search:
          return BinarySearchTree/search(x.left, value_to_search)
        else:
          return BinarySearchTree/search(x.right, value_to_search)


# this function is to insert in Binary Tree
def BinaryTree/insert(tree, value_to_insert):
  fold x = tree:
    case BinaryTree/Leaf:
      return BinaryTree/Node{value:value_to_insert, left:BinaryTree/Leaf, right:BinaryTree/Leaf}
    case BinaryTree/Node:
      return BinaryTree/Node{value:x.value, left:BinaryTree/insert(x.left, value_to_insert), right:x.right}


# generates Random Binary Tree
def BinaryTree/generate(n, x):
  bend n, x:
    when n != 0:
      return BinaryTree/Node{value:x, left:BinaryTree/generate(n - 1, x*2+1), right:BinaryTree/generate(n - 1, x*2+2)}
    else:
      return BinaryTree/Leaf



def main:
  my_tree=BinarySearchTree/Leaf
  my_tree = BinarySearchTree/insert(my_tree, 3)
#   my_tree = BinarySearchTree/insert(my_tree, 4)

  value_exists = BinarySearchTree/search(my_tree, 4)
  if value_exists==1:
    return "It Exists"
  else:
    return "Does not Exist"

#   my_tree1=BinaryTree/Leaf
#   my_tree1 = BinaryTree/insert(my_tree1, 3)
#   my_tree1 = BinaryTree/insert(my_tree1, 3)

# you need depth and first value to generate binary tree
#   depth = 1
#   first_val = 1
#   my_tree1 = BinaryTree/generate(depth, first_val)


