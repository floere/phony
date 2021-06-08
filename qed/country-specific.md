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

Important: It is not expected to handle an international number correctly. This fails:

    Phony["81"].format('81312345634', :format => :international).refute == '+81 3-1234-5634'

Only expects and handles normalized national numbers:

    Phony["81"].format('312345634', :format => :international).assert == '+81 3-1234-5634'

#### Japan

The domestic Telephone number in Japan has to have Trunk prefix.

In Tokyo

    japan = Phony["81"]
  
    japan.format('0312345634', :format => :international).assert == '+81-3-1234-5634'
    japan.format('0312345634', :format => :national).assert ==      '03-1234-5634'
    japan.format('0312345634', :format => :local).assert ==         '1234-5634'
    
    japan.normalize("03 1234 5634").assert == '0312345634'
    japan.normalize("03-1234-5634").assert == '0312345634'
    japan.normalize("03(1234)5634").assert == '0312345634'
    japan.normalize("Hello    03-1234-5634").assert == '0312345634'
  
    japan.assert.plausible?('0312345678')

In Shihoro Town, Hokkaido

    japan.format('0156452211', :format => :international).assert == '+81-1564-5-2211'
    japan.format('0156452211', :format => :national).assert ==      '01564-5-2211'
    japan.format('0156452211', :format => :local).assert ==         '5-2211'
    
    japan.normalize("01564 5 2211").assert == '0156452211'
    japan.normalize("01564-5-2211").assert == '0156452211'
    japan.normalize("01564(5)2211").assert == '0156452211'
    japan.normalize("Hello   01564-5-2211 ").assert == '0156452211'
    
    japan.assert.plausible?('0156452211')

#### Italy

This is an error case from issue #428.

    italy = Phony["39"]
  
    italy.plausible?('12345').assert == false