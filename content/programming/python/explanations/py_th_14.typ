#set text(size: 13pt)
== Explanation
Because default argument expressions are evaluated only once when the function is defined, both calls share the exact same list object (`r1 is r2`). After the second call, that shared list contains `[1, 2]`.
