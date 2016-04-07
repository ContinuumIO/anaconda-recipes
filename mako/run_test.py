from mako.template import Template

a = Template("hello ${data}!").render(data="world")
b = "hello world!"
assert a == b
