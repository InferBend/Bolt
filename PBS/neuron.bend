object neuron {weight,bias}
def neuron/activate(val,function):
  if String/equals(function,"relu"):
    if val<=0.00:
      return 0.00
    else:
      return val
  elif String/equals(function,"sigmoid"):
    return 1.0/(1.0+2.7182**val)
  else:
    return val

def neuron/hit(nn,x,activate):
  open neuron:nn
  val=0.00
  val=(x*nn.weight)+nn.bias
  return neuron/activate(val,activate)
