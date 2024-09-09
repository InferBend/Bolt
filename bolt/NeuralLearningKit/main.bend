from ./layerBaker import (layer,layer/generator)
from ./modelBaker import(modelPropogate)
from ./neuron import (neuron,neuron/activate,neuron/hit)

def main():
  l1=layer{size:4,type:"normal",activation:"sigmoid"}
  l2=layer{size:4,type:"normal",activation:"sigmoid"}
  open layer :l1
  open layer: l2
  l11=layer/generator(l1)
  l22=layer/generator(l2)
  model=[l11,l22]
  layer_final=modelPropogate([3,3,5],model,[0])
  return layer_final