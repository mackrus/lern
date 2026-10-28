#set text(size: 13pt)
= Mutable Default Arguments in Python

What does the following code print?
```python
def add_item(x, bucket=[]):
    bucket.append(x)
    return bucket

r1 = add_item(1)
r2 = add_item(2)
print(r1, r2)
```
#pagebreak()
#set text(size: 13pt)
`[1, 2] [1, 2]`
#pagebreak()
#set text(size: 13pt)
`[1] [2]`
#pagebreak()
#set text(size: 13pt)
`[1] [1, 2]`
#pagebreak()
#set text(size: 13pt)
Raises `UnboundLocalError`
