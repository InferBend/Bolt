from ./types/List import List/append


def subtract(x, y, z):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = (x.head - y.head)
          z = List/append(z, d)
          return subtract(x.tail, y.tail, z)
        case List/Nil:
          return z
    case List/Nil:
      return z


def multiply(x, y, z):
  match x:
    case List/Cons:
      match y:
        case List/Cons:
          d = (x.head * y.head)
          z = List/append(z, d)
          return multiply(x.tail, y.tail, z)
        case List/Nil:
          return z
    case List/Nil:
      return z


def multiplyScalar(x, val, z):
  match x:
    case List/Cons:
      z = List/append(z, x.head * val)
      return multiplyScalar(x.tail, val, z)
    case List/Nil:
      return z


def transpose(matrix, res):
  match matrix:
    case List/Cons:
      (l, _) = List/length(matrix.head)  
      return transpose_helper(matrix, 0, l, res)  
    case List/Nil:
      return res  


def transpose_helper(matrix, current_col, total_cols, result):
  if current_col == total_cols:
    return result  
  else:
    column = get_column(matrix, current_col)  
    new_result = List/append(result, column)  
    return transpose_helper(matrix, current_col + 1, total_cols, new_result) 


def get_column(matrix, col_index):
  match matrix:
    case List/Cons:
      return List/Cons(get_element(matrix.head, col_index, 0), get_column(matrix.tail, col_index))
    case List/Nil:
      return List/Nil  


def get_element(row, col_index, current_index):
  match row:
    case List/Cons:
      if current_index == col_index:
        return row.head  
      else:
        return get_element(row.tail, col_index, current_index + 1)  
    case List/Nil:
      return 0  