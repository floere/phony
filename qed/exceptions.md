# Exceptions

## Phony#format

If a nil number is given, Phony will tell a user specifically.

```ruby
  expect ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.format(number).' do
    Phony.format nil
  end
```
