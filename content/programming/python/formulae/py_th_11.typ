#set text(size: 13pt)
== Predecessor Lookup Cost
To set `pred.succ = None` where `pred.succ == self.last`, we must walk $n - 2$ links from `self.first` $arrow.r.double Theta(n)$.
