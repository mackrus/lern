#set text(size: 13pt)
== Function Definition Time vs. Call Time
In Python, default parameter values are evaluated *once* when the `def` statement is executed, and stored on the function object (`add_item.__defaults__`).
