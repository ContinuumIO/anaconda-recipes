import mistune

res = mistune.markdown('I am using **markdown**')
assert res.strip() == '<p>I am using <strong>markdown</strong></p>', repr(res)

print("mistune OK")
