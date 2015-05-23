## Exceptions

### Phony#format

If a nil number is given, Phony will tell a user specifically.

```ruby
  expect ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.format(number).' do
    Phony.format nil
  end
```

### Phony#normalize

If a nil number is given, Phony will tell a user specifically.

```ruby
  expect ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.normalize(number).' do
    Phony.format nil
  end
```

Raises if number starts with reserved zero code.

```ruby
  expect Phony::NormalizationError, 'Phony could not normalize the given number. Is it a phone number?' do
    Phony.normalize '+00 00 00 00 01'
  end
```

Raises a nice error message.

```ruby
  expect Phony::NormalizationError, 'Phony could not normalize the given number. Is it a phone number?' do
    Phony.normalize 'test'
  end
```