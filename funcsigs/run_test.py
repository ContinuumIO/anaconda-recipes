from funcsigs import signature


def foo(a, b=None, *args, **kwargs):
    pass

sig = signature(foo)
print(sig)
