## Phony[cc]



### Example countries

#### NANP

    nanp = Phony['1']
    
    nanp.format('5551234567890', :format => :international).assert == '+1 (555) 123-4567890'
    nanp.format('5551234567890', :format => :national).assert ==      '(555) 123-4567890'
    nanp.format('5551234567890', :format => :local).assert ==         '123-4567890'
    
    nanp.normalize("555 1234567890").assert == '5551234567890'
    nanp.normalize('4159224711').assert == '4159224711'

Important: It is not expected to handle an international number correctly. This fails:

    Phony["81"].format('81312345634', :format => :international).refute == '+81 3-1234-5634'

Only expects and handles normalized national numbers:

    Phony["81"].format('312345634', :format => :international).assert == '+81 3-1234-5634'

But note that these will not fail, as the contained numbers are still a NANP number.

    nanp.normalize("+1 555 1234567890").assert == '15551234567890'
    nanp.normalize("+1 (0) 555 1234567890").assert == '15551234567890'

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

In Yokosuka, Kanagawa

    japan.format('0468112222', :format => :international).assert == '+81-46-811-2222'
    japan.format('0468112222', :format => :national).assert ==      '046-811-2222'
    japan.format('0468112222', :format => :local).assert ==         '811-2222'

    japan.normalize("0468-11-2222").assert == '0468112222'
    japan.normalize("046-811-2222").assert == '0468112222'

    japan.assert.plausible?('0468112222')

Other patterns

    japan.format('0597971000', :format => :national).assert == '0597-97-1000'
    japan.format('0597930505', :format => :national).assert == '05979-3-0505'
    japan.format('0154822200', :format => :national).assert == '015-482-2200'
    japan.format('0154235151', :format => :national).assert == '0154-23-5151'
    japan.format('0154762231', :format => :national).assert == '01547-6-2231'
    japan.format('0223086332', :format => :national).assert == '022-308-6332'
    japan.format('0223221111', :format => :national).assert == '0223-22-1111'
    japan.format('0255531880', :format => :national).assert == '025-553-1880'
    japan.format('0250243777', :format => :national).assert == '0250-24-3777'
    japan.format('0264730243', :format => :national).assert == '026-473-0243'
    japan.format('0264524902', :format => :national).assert == '0264-52-4902'
    japan.format('0286322222', :format => :national).assert == '028-632-2222'
    japan.format('0283245111', :format => :national).assert == '0283-24-5111'
    japan.format('0289572111', :format => :national).assert == '028-957-2111'
    japan.format('0289642111', :format => :national).assert == '0289-64-2111'
    japan.format('0795500000', :format => :national).assert == '079-550-0000'
    japan.format('0795200000', :format => :national).assert == '0795-20-0000'
    japan.format('0829610000', :format => :national).assert == '082-961-0000'
    japan.format('0829700111', :format => :national).assert == '0829-70-0111'
    japan.format('0865522000', :format => :national).assert == '086-552-2000'
    japan.format('0865500000', :format => :national).assert == '0865-50-0000'


#### Italy

This is an error case from issue #428.

    italy = Phony["39"]
  
    italy.plausible?('12345').assert == false


#### Luxembourg

Error from issue #520.

    luxembourg = Phony["352"]

    luxembourg.assert.plausible?('2634731')
    luxembourg.assert.plausible?('264412701')
