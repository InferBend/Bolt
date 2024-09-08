##############################
# Author: Jaisuraj Bantupalli, May 2024
##############################
## Set Data Structure - Imp Syntax ##


##### TODO##########
#                  # 
#  Sorting of Set  #
#                  #
#                  #
####################



type Set:
  Nil
  Cons { head, ~tail }

# Clear the Set
def Set/clear(x):
  return Set/Nil

# Check if an element is in the set
def Set/contains(set, val):
  match set:
    case Set/Cons:
      if set.head == val:
        return 1
      else:
        return Set/contains(set.tail, val)
    case Set/Nil:
      return 0


def Set/union(set1, set2):
  match set1:
    case Set/Cons:
      if Set/contains(set2, set1.head):
        return Set/union(set1.tail, set2)
      else:
        return Set/Cons(set1.head, Set/union(set1.tail, set2))
    case Set/Nil:
      return set2

# Append to end
def Set/add(x, val):
  if Set/contains(x, val):
    return x
  else:
    return Set/union(x, Set/Cons(val,  Set/Nil ))

# Get length of Set
def Set/length(x):
  match x:
    case Set/Cons:
      return (Set/length(x.tail) + 1)
    case Set/Nil:
      return 0


def main():
  # x = [1, 2, 3]
  # y = [1, 4, 5, 6]
  # k = Set/union(x, y)
#   l1 = Set/length(k)
#   k = Set/add(k, 1)
#   l2 = Set/length(k)
  s1=Set/Nil
  s1=Set/add(s1,1)
  s1=Set/add(s1,3)
  s1=Set/add(s1,4)
  s1=Set/add(s1,4)
  l=Set/length(s1)  
  return l
