import param

class A(param.Parameterized):
    a = param.Number(0.5,bounds=(0,1),doc="Probability that...")
    b = param.Boolean(False,doc="Enable feature...")
