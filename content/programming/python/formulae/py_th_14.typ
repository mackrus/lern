#set text(size: 13pt)
== Safe Idiom for Mutable Defaults
```python
def add_item(x, bucket=None):
    if bucket is None:
        bucket = []
    bucket.append(x)
    return bucket
```
