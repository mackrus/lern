#set text(size: 13pt)
== Shallow Copy (`a[:]`) vs. Deep Copy
Slicing a list (`b = a[:]`) creates a *new outer list*, but copies the *references* to the inner lists (`b[0] is a[0]` and `b[1] is a[1]`).
