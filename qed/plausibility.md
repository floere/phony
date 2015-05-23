## Vanity

### Phony#vanity?

Are these numbers vanity numbers?

```ruby
  Phony.assert.vanity? '41800 WEGGLI'
  Phony.assert.vanity? '41800WEGGLI'
  Phony.assert.vanity? '41848 SUCCESSMATCH'
  Phony.refute.vanity? '4180 NO NO NO'
  Phony.refute.vanity? '41900 KURZ'
  Phony.refute.vanity? '41 44 364 35 32'
```

### Phony.vanity\_to\_number

Turn the vanity number into a normal number.

```ruby
  Phony.vanity_to_number('41800WEGGLI').assert == '41800934454'
  Phony.vanity_to_number('41800weggli').assert == '41800934454'
```

Allow for call-through numbers (>= 1.6.0).

```ruby
  Phony.vanity_to_number('41800SUCCESSMATCH').assert == '41800782237762824'
```

Does not check for validity of number.

```ruby
  Phony.vanity_to_number('4180BLA').assert == '4180252'
  Phony.vanity_to_number('41800SUCCESSMATCH').assert == '41800782237762824'
```