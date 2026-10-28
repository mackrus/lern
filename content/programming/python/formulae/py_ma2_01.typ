#set text(size: 13pt)
== String Formatting Idiom
Using the list's iterator:
```python
"(" + ", ".join(str(x) for x in self) + ")"
```
