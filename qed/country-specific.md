## Phony[cc]



### Example countries

#### NANP

```ruby
  nanp = Phony['1']
  
  nanp.format('5551234567890', :format => :international).assert == '+1 (555) 123-4567890'
  nanp.format('5551234567890', :format => :national).assert ==      '(555) 123-4567890'
  nanp.format('5551234567890', :format => :local).assert ==         '123-4567890'
  
  nanp.normalize("555 1234567890").assert == '5551234567890'
  nanp.normalize("+1 555 1234567890").assert == '5551234567890'
  nanp.normalize("+1 (0) 555 1234567890").assert == '5551234567890'
  nanp.normalize('4159224711').assert == '4159224711'
  
  nanp.assert.plausible?('4159224711')
```

It is not expected to handle an intl number correctly.

```ruby
  Phony["1"].format('15551234567890', :format => :international).assert == '+1 (155) 512-34567890'
```

Yep. This turns out to be wrong. Only expects and handles normalized national numbers.

#### Japan

```ruby
  japan = Phony["81"]
  
  japan.format('8012345634', :format => :international).assert == '+81-80-1234-5634'
  japan.format('8012345634', :format => :national).assert ==      '080-1234-5634'
  japan.format('8012345634', :format => :local).assert ==         '1234-5634'
  
  japan.normalize("80 1234 5634").assert == '8012345634'
  japan.normalize("Hello    80 1234 5634").assert == '8012345634'
```

#### Italy

This is an error case from issue #428.

```ruby
  italy = Phony["39"]
  
  italy.plausible?('12345').assert == false
```