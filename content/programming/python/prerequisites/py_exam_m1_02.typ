#set text(size: 13pt)
== Mutual / Alternating State in List Recursion
When you peel `lst[0]` off the front of `lst`, the remaining sublist `lst[1:]` has its indices shifted by 1:
- Even indices of `lst[1:]` were *odd* indices of `lst`!
- Odd indices of `lst[1:]` were *even* indices of `lst`!
So if `evens_rest, odds_rest = split_even_odd(lst[1:])`, then for `lst` the result is simply `([lst[0]] + odds_rest, evens_rest)`.
