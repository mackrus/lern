#set text(size: 13pt)
== Grammar Depth & Binding Strength
In a recursive descent parser, production rules *lower* in the hierarchy (closer to `factor`) are evaluated *first* and bind more tightly than rules higher in the hierarchy.
