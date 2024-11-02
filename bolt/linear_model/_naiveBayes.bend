
from ../preprocessing/_oneHotEncoding import (onehotencoder)
from ../utils/vector import (transpose)

from ../utils/types/List import(List/reverse,List/contains,List/index,List/append)

######################################################################################################

def unique_values(lst, unique_lst):
  match lst:
    case List/Cons:
      k = List/contains(unique_lst, lst.head)
      if k != 1:
        unique_lst = List/append(unique_lst, lst.head)
        return unique_values(lst.tail, unique_lst)
      else: 
        return unique_values(lst.tail, unique_lst)
    case List/Nil:
      return unique_lst

def Set/add(x, val):
  match x:
    case List/Cons:
      if List/contains(x,val) == 1:
        return x
      else:
        return List/Cons(x.head, Set/add(x.tail, val))
    case List/Nil:
      return List/Cons (val, List/Nil )

def find_unique(ls,s):
  match ls:
    case List/Cons:
      k=List/contains(s,ls.head)
      if k!=1:
        s=Set/add(s,ls.head)
        return find_unique(ls.tail,s)
      else: 
        return find_unique(ls.tail,s)
    case List/Nil:
      return s

def count_occurrences(lst, elem):
  match lst:
    case List/Cons:
      if lst.head == elem:
        return (1.0 + count_occurrences(lst.tail, elem))
      else:
        return count_occurrences(lst.tail, elem)
    case List/Nil:
      return 0.0


def compute_probabilities(elements, lst, total,s):
  match elements:
    case List/Cons:
      count = count_occurrences(lst, elements.head)
      prob = count / to_f24(total)
      s=List/append(s,prob)
      return compute_probabilities(elements.tail, lst, total,s)
    case List/Nil:
      return s

def probability(y):
  (total_elements,y) = List/length(y)
  unique_elems = find_unique(y,[])
  k=compute_probabilities(unique_elems, y, total_elements,[])
  mp=probability_map1(unique_elems,k,{})
  return mp


def probability_map1(unique_elems,k,mp):
  match unique_elems:
    case List/Cons:
      match k:
        case List/Cons:
          mp=Map/set(mp,unique_elems.head, k.head )
          return probability_map1(unique_elems.tail,k.tail,mp)
        case List/Nil:
          return mp   
    case List/Nil:
      return mp


#########################################################################################################
#  ###############################################

def string_length_encode(s):
  match s:
    case String/Cons:
      return 1 + string_length_encode(s.tail)
    case String/Nil:
      return 0



def List/concat_encode(x, y):
  match x:
    case List/Cons:
      return List/Cons(x.head, List/concat_encode(x.tail, y))
    case List/Nil: 
      return y
    

def List/append_encode(x, val):
  return List/concat_encode(x, List/Cons(val, List/Nil))
      
def map_string_lengths(lst):
  match lst:
    case List/Cons:
      return List/Cons (string_length_encode(lst.head), map_string_lengths(lst.tail))
    case List/Nil:
      return List/Nil


# Function to check if two strings are equal
def string_equal_encode(s1, s2):
  l1 = string_length_encode(s1)
  l2 = string_length_encode(s2)
  if l1 != l2:
    return 0
  else:
    match s1:
      case String/Cons:
        match s2:
          case String/Cons:
            if s1.head == s2.head:
              return string_equal_encode(s1.tail, s2.tail)
            else:
              return 0
          case String/Nil:
            return 0
      case String/Nil:
        match s2:
          case String/Nil:
            return 1
          case _:
            return 0


def List/contains_encode(lst, value):
  match lst:
    case List/Cons:
      if string_equal_encode(lst.head, value) == 1:
        return 1
      else:
        return List/contains_encode(lst.tail, value)
    case List/Nil:
      return 0

def Set/add_encode(x, val):
  match x:
    case List/Cons:
      if string_equal_encode(x.head, val) == 1:
        return x
      else:
        return List/Cons(x.head,Set/add_encode(x.tail, val))
    case List/Nil:
      return List/Cons(val, List/Nil)


def find_unique_encode(ls,s):
  match ls:
    case List/Cons:
      k=List/contains_encode(s,ls.head)
      if k!=1:
        s=Set/add_encode(s,ls.head)
        return find_unique_encode(ls.tail,s)
      else: 
        return find_unique_encode(ls.tail,s)
    case List/Nil:
      return s


def List/length_encode(x):
  match x:
    case List/Cons:
      return (List/length_encode(x.tail) + 1)
    case List/Nil:
      return 0


def asc(d):
  match d:
    case String/Cons:
      return d.head + asc(d.tail)*10
    case String/Nil:
      return 0


def create_category_index_map(categories, index_map, index):
  match categories:
    case List/Cons:
      ascii_value = asc(categories.head)
      updated_map = Map/set (index_map,categories.head,index )
      return create_category_index_map(categories.tail, updated_map, index + 1.0)
    case List/Nil:
      return index_map



def gen_map(ls,l,l1,idx,mp):
  if idx<l:
    match ls:
      case List/Cons:
        l1=List/append_encode(l1,asc(ls.head))
        mp=Map/set(mp, asc(ls.head), idx)
        return gen_map(ls.tail,l,l1,idx+1,mp)
      case List/Nil:
        return mp
  else:
    return mp
      
      
def onehotencode_helper(y,mp,l):
  match y:
    case List/Cons:
      k=asc(y.head)
      l=List/append_encode(l,mp[k])
      return onehotencode_helper(y.tail,mp,l)
    case List/Nil:
      return l
      
   
    
def onehotencoder(y):
  encoded = find_unique_encode(y,[])
  l=List/length_encode(encoded)
  mp=gen_map(encoded,l,[],0,{})
  res=onehotencode_helper(y,mp,[]) 
  return res 

##########################################################################################################

def check_equality(x,y,valx,valy,count):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          if(x.head==valx):
            if(y.head==valy):
              count=count + 1
              return check_equality(x.tail,y.tail,valx,valy,count)
            else:
              return check_equality(x.tail,y.tail,valx,valy,count)
          else:
            return check_equality(x.tail,y.tail,valx,valy,count)
        case List/Nil:
          return count
    case List/Nil:
      return count

def generatex(unique_x,y,l,x,unique_y):
  match unique_y:
    case List/Cons:
      k=check_equality(x,y,unique_x,unique_y.head,0)
      l=List/append(l,k)
      return generatex(unique_x,y,l,x,unique_y.tail)
    case List/Nil:
      return l





def helper(x,y,unique_x,unique_y,l1):
  match unique_x:
    case List/Cons:
      l=generatex(unique_x.head,y,[],x,unique_y)
      l1=List/append(l1,l)
      return helper(x,y,unique_x.tail,unique_y,l1)
    case List/Nil:
      return l1


def sum(x):
  match x:
    case List/Cons:
      return x.head + sum(x.tail)
    case List/Nil:
      return 0.0



def genrate_prob_matrix_helper(k1,x,lx,unique_x,l,s):
  match k1:
    case List/Cons:
      p1=k1.head / s
      l=List/append(l,p1)
      return genrate_prob_matrix_helper(k1.tail,x,lx,unique_x,l,s)
    case List/Nil:
      return l

def genrate_prob_matrix(k,x,lx,unique_x,l):
  match k:
    case List/Cons:
      p1=genrate_prob_matrix_helper(k.head,x,lx,unique_x,[],sum(k.head))
      l=List/append(l,p1)
      return genrate_prob_matrix(k.tail,x,lx,unique_x,l)
    case List/Nil:
      return l

def probability_map(unique_elems,k,mp):
  match unique_elems:
    case List/Cons:
      match k:
        case List/Cons:
          mp=Map/set(mp, unique_elems.head,k.head )
          return probability_map(unique_elems.tail,k.tail,mp)
        case List/Nil:
          return mp   
    case List/Nil:
      return mp




def multiply_list(l,factor,res):
  match l:
    case List/Cons: 
      res=List/append(res,(l.head*factor))
      return multiply_list(l.tail,factor,res)
    case List/Nil:
      return res
      

def calculate_final_prob(mp,prob_list,l,px,py,r,ly):
  prob_yes=prob_list[1]
  prob_no=prob_list[0]
  res1=mp[px]
  res2=mp[0]
  prob_yes_array=multiply_list(res1,prob_yes,[])
  prob_no_array=multiply_list(res2,prob_no,[])
  prob_no_array_rev=List/reverse(prob_no_array) #Have to reverse it for matching suny column
  return [prob_yes_array,prob_no_array_rev]

      
def naive_bayes(x,y):
  unique_x = unique_values(x, [])
  unique_y = unique_values(y, [])
  (lx,unique_x)=List/length(unique_x)
  (ly,unique_y)=List/length(unique_y)
  k=helper(x,y,unique_x,unique_y,[])
  k_transpose= transpose(k)
  k1=genrate_prob_matrix(k_transpose,x,to_f24(lx),unique_x,[])
  mp=probability_map(unique_x,k1,{}) #mp[0]-> no mp[1]->yes
  prob_list=probability(y) #prob_list[0]->no prob_list[1]->yes
  final_list=calculate_final_prob(mp,prob_list,[],1,1,0,to_f24(ly)) #(px,py,start from idx,length of y)

  return final_list

  

    

#([[3, 2], [0, 4], [2, 3]]
def main():
  y=["no", "no", "yes", "yes", "yes", "no", "yes", "no", "yes", "yes", "yes", "yes", "yes", "no"]
  x=["sunny", "sunny", "overcast", "rainy", "rainy", "rainy", "overcast", "sunny", "sunny", "rainy", "sunny", "overcast", "overcast", "rainy"]
  x=onehotencoder(x)
  y=onehotencoder(y)
  # x=[0, 0, 1, 2, 2, 2, 1, 0, 0, 2, 0, 1, 1, 2]
  # y=[0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0]
  t=[[1,2],[4,3],[5,2]]
  return naive_bayes(x,y)

# ##################################################################################

# def main():
#   x = {
#     0: ["sunny", "sunny", "overcast", "rainy", "rainy", "rainy", "overcast", "sunny", "sunny", "rainy", "sunny", "overcast", "overcast", "rainy"],
#     1: [  
#         "hot", "hot", "hot", "mild", "cool", "cool", "cool", "mild", "cool", "mild", "mild", "mild", "hot", "mild"
#     ],
#     2: [  
#         "high", "high", "high", "high", "normal", "normal", "normal", "high", "normal", "normal", "normal", "high", "normal", "high"
#     ],
#     3: [ 
#         "False", "True", "False", "False", "False", "True", "True", "False", "False", "False", "True", "True", "False", "True"
#     ]
#   }
#   y=["no", "no", "yes", "yes", "yes", "no", "yes", "no", "yes", "yes", "yes", "yes", "yes", "no"]
# #   res=onehotencoder(y)
#   # x[0] = onehotencoder(x[0])
#   # x[1] = onehotencoder(x[1])
#   # x[2] = onehotencoder(x[2])
#   # x[3] = onehotencoder(x[3])
#   y1=onehotencoder(y)
#   prob_list=probability(y1)
#   x_encoded = {
#     0: onehotencoder(x[0]),
#     1: onehotencoder(x[1]),
#     2: onehotencoder(x[2]),
#     3: onehotencoder(x[3])
#     }
#   k=process_all(x_encoded,y1)
  

  
#   return k