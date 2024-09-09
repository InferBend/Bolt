from ./layerBaker import (layer,layer/generatorAux,layer/generator,layer/operate,layer/propogate)
from ./neuron import (neuron,neuron/activate,neuron/hit)
#def modelPropogate(input,model,out):

def modelPropogate(input,model,out):
  match model:
    case List/Cons:
      a=model.head
      out=layer/propogate(input,a,[1])
      return modelPropogate(out,model.tail,[1])
    case List/Nil:
      return input

