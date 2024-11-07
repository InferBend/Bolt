from ./math import abs

def assert_equal(l1, l2):
  # works for lists and strings
  match l1:
    case List/Cons:
      match l2:
        case List/Cons:
          if(l1.head == l2.head):
            return assert_equal(l1.tail, l2.tail)
          else:
            return 0
        case List/Nil:
          return 0
    case List/Nil:
      match l2:
        case List/Cons:
          return 0
        case List/Nil:
          return 1
        
def assert_multi_array(l1, l2):
  match l1:
    case List/Cons:
      match l2:
        case List/Cons:
          if (assert_equal(l1.head, l2.head) == 1):
            return assert_multi_array(l1.tail, l2.tail)
          else:
            return 0
        case List/Nil:
          return 0
    case List/Nil:
      match l2:
        case List/Cons:
          return 0
        case List/Nil:
          return 1

def assert_almost_equal(l1, l2):
  # works for lists and strings
  # TODO: send the decimal value as paramter and make it smaller by improving algos

  match l1:
    case List/Cons:
      match l2:
        case List/Cons:
          if(abs(l1.head - l2.head) < 8.0 * 10.0**(-1.0)):
            return assert_almost_equal(l1.tail, l2.tail)
          else:
            return 0
        case List/Nil:
          return 0
    case List/Nil:
      match l2:
        case List/Cons:
          return 0
        case List/Nil:
          return 1