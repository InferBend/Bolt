from ./neuron import (neuron,neuron/activate,neuron/hit)
object layer {size,type,activation}

def layer/generatorAux(layerMain,size):
  if size==0:
    return layerMain
  else:
    n1=neuron{weight:1.00,bias:2.00}
    open neuron :n1
    return layer/generatorAux(List/concat(layerMain,[n1]),size - 1)
def layer/generator(ll):
  open layer:ll
  layerMain=[]
  layerFinal=layer/generatorAux(layerMain,ll.size)
  return layerFinal

def layer/operate(nn,input,n):
  open neuron:nn
  match input:
    case List/Cons:
      return layer/operate(nn,input.tail,neuron/hit(nn,n,"sigmoid"))
    case List/Nil:
      return n

def layer/propogate(input,ll,out):
  match ll:
    case List/Cons:
      match out:
        case List/Cons:
          match input:
            case List/Cons:
              return layer/propogate(input,ll.tail,List/concat(out,[layer/operate(ll.head,input,0)]))
            case List/Nil:
              return out
        case List/Nil:
          return out
    case List/Nil:
      return out

  

