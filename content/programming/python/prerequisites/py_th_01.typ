#set text(size: 13pt)
== Cost of Slicing in Python
Unlike views in NumPy, slicing a standard Python `list` (`a[1:]`) copies all remaining elements into a newly allocated array. At call depth $i$, copying $n - i$ elements takes $Theta(n - i)$ work.
