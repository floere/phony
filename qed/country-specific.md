## Phony[cc]



### Example countries

#### NANP

```ruby
  nanp = Phony['1']
  
  nanp.format('5551234567890', :format => :international).assert == '+1 (555) 123-4567890'
  nanp.format('5551234567890', :format => :national).assert ==      '(555) 123-4567890'
  nanp.format('5551234567890', :format => :local).assert ==         '123-4567890'
```

It is not expected to handle an intl number correctly.

```ruby
  Phony["1"].format('15551234567890', :format => :international).assert == '+1 (155) 512-34567890'
```

Yep. This turns out to be wrong. Only expects and handles normalized national numbers.

#### Japan

```ruby
  japan = Phony["81"]
  
  japan.format('8012345634', :format => :international).assert == '+81 80 1234 5634'
  japan.format('8012345634', :format => :national).assert ==      '080 1234 5634'
  japan.format('8012345634', :format => :local).assert ==         '1234 5634'
```