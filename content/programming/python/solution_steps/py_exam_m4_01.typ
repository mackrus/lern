#set text(size: 13pt)
== Step-by-Step Strategy
1. Write `calc_sqrt(x)`: if `x < 0`, raise `EvaluationError`; return `m.sqrt(x)`.
2. Write `calc_log(args: list)`: check `1 <= len(args) <= 2` and `args[0] > 0`; if 2 args, check `args[1] > 0 and args[1] != 1` and return `m.log(args[0], args[1])`.
3. Write `calc_divisible(args: list)`: check `len(args) == 2` and `args[0] > 0 and args[1] > 0`; return `float(args[0]) if args[0] % args[1] == 0 else float(args[1])`.
