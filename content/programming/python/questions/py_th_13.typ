#set text(size: 13pt)
= Shallow Copy & Aliasing of Nested Lists

What is printed when the following Python code is executed?
```python
a = [[1, 2], [3, 4]]
b = a[:]
b[0].append(9)
b.append([5, 6])
print(a)
```
#pagebreak()
#set text(size: 13pt)
`[[1, 2, 9], [3, 4]]`
#pagebreak()
#set text(size: 13pt)
`[[1, 2], [3, 4]]`
#pagebreak()
#set text(size: 13pt)
`[[1, 2, 9], [3, 4], [5, 6]]`
#pagebreak()
#set text(size: 13pt)
`[[1, 2], [3, 4], [5, 6]]`
