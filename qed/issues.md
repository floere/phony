## Issues

A collection of former issues, for quick reference.

### #136

Works for Italy.

```ruby
  Phony.normalize('+39 393 0000000').assert == '393930000000'
```

Specifically fixes the issue.

```ruby
  italia = Phony['39']
  italia.normalize('363 000000').assert == '363000000'
```

Works for country with CC 46.

```ruby
  Phony.normalize('+46 (0)46 222 0000').assert == '46462220000'
```

### #151

Normalizes, but this is a non-real case.

```ruby
  Phony.normalize('1-111-111-1111').assert        == '1111111111'
  Phony.normalize('111-111-1111', cc: '1').assert == '1111111111'
```

### #152

```ruby
  Phony.split('39694805123').assert == ['39', '694805123', []]
  Phony.format('39694805123').assert == '+39 694805123 '
```