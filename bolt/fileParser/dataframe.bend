from ../utils/types/List import (List/append, List/index)
from ../utils/helper import Number/parse_integer

def List/convert_to_int(ls, index, final):
  match ls:
    case List/Cons:
      if(index == 0):
        final = List/append(final, Number/parse_integer(ls.head))
        return List/convert_to_int(ls.tail, index - 1, final)
      else:
        final = List/append(final, ls.head)
        return List/convert_to_int(ls.tail, index - 1, final)
    case List/Nil:
      return final 