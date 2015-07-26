## Phony.format

Format formats phone numbers according to the predominant format of a country.

You really need to give it a normalized phone number WITH country code, so this won't work.

    Phony.format('3643532')

These, however, are splendid:

    Phony.format('41443643532').assert == '+41 44 364 35 32'
    Phony.format('41800111222').assert == '+41 800 111 222'
    Phony.format('43198110').assert == '+43 1 98110'
    Phony.format('18705551122').assert == '+1 (870) 555-1122'

It is aliased as `#formatted`, if that floats your boat.

    Phony.formatted('41443643532').assert == '+41 44 364 35 32'

This is a very nice page for country specific formats:
http://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers 

### Options

#### :format => :international

    Phony.format('18091231234', :format => :international).assert == '+1 (809) 123-1234'
    Phony.format('43198110', :format => :international).assert == '+43 1 98110'
    Phony.format('43198110', :format => :international_absolute).assert == '+43 1 98110'
    Phony.format('33142278186', :format => :+).assert == '+33 1 42 27 81 86'
    Phony.format('43198110', :format => :international_relative).assert == '0043 1 98110'
    Phony.format('4233841148', :format => :international_relative).assert == '00423 384 11 48'

#### :format => :national

    Phony.format('41443643532', :format => :national).assert == '044 364 35 32'
    Phony.format('41800111222', :format => :national).assert == '0800 111 222'
    Phony.format('43198110', :format => :national).assert == '01 98110'

#### :format => :local

    Phony.format('41443643532', :format => :local).assert == '364 35 32'
    Phony.format('493038625454', :format => :local).assert == '386 25454'

#### :format => String template

    Phony.format('41443643532', :format => 'A%{cc}B%{trunk}C%{ndc}D%{local}').assert == 'A41B0C44D364 35 32'
    Phony.format('41443643532', :format => '%{local} %{ndc} %{trunk} %{cc}', :local_spaces => '').assert == '3643532 44 0 41'
    Phony.format('41443643532', :format => 'A%{cc}B%{ndc}C%{local}', :local_spaces => '/').assert == 'A41B44C364/35/32'
    Phony.format('71234567890', :format => '+%{cc} (%{trunk}%{ndc}) %{local}', :local_spaces => '-').assert == '+7 (8123) 45-67890'
    Phony.format('13015550100', :format => '+%{cc} %{trunk}%{ndc} %{local}', :local_spaces => '-').assert == '+1 301 555-0100'

#### :spaces => String

    Phony.format('18091231234', :format => :international, :spaces => '').assert == '+1(809)123-1234'
    Phony.format('43198110', :format => :international, :spaces => '').assert == '+43198110'
    Phony.format('43198110', :format => :international_absolute, :spaces => '').assert == '+43198110'
    Phony.format('33142278186', :format => :+, :spaces => '').assert == '+33142278186'
    Phony.format('43198110', :format => :international_relative, :spaces => '').assert == '0043198110'
    Phony.format('4233841148', :format => :international_relative, :spaces => '').assert == '004233841148'
    Phony.format('18091231234', :format => :international, :spaces => :-).assert == '+1-(809)-123-1234'
    Phony.format('43198110', :format => :international, :spaces => :-).assert == '+43-1-98110'
    Phony.format('43198110', :format => :international_absolute, :spaces => :-).assert == '+43-1-98110'
    Phony.format('33142278186', :format => :+, :spaces => :-).assert == '+33-1-42-27-81-86'
    Phony.format('43198110', :format => :international_relative, :spaces => :-).assert == '0043-1-98110'
    Phony.format('4233841148', :format => :international_relative, :spaces => :-).assert == '00423-384-11-48'

#### :local_spaces => String

    Phony.format("33142278186", :format => :international, :local_spaces => :-).assert == '+33 1 42-27-81-86'

### Example countries

#### Austria

    Phony.format('43198110').assert == '+43 1 98110'
    Phony.format('43198110', :format => :international).assert == '+43 1 98110'
    Phony.format('43198110', :format => :international_absolute).assert == '+43 1 98110'
    Phony.format('43198110', :format => :international_relative).assert == '0043 1 98110'
    Phony.format('43198110', :format => :international, :spaces => '').assert == '+43198110'
    Phony.format('43198110', :format => :international_absolute, :spaces => '').assert == '+43198110'
    Phony.format('43198110', :format => :international_relative, :spaces => '').assert == '0043198110'
    Phony.format('43198110', :format => :international, :spaces => :-).assert == '+43-1-98110'
    Phony.format('43198110', :format => :international_absolute, :spaces => :-).assert == '+43-1-98110'
    Phony.format('43198110', :format => :international_relative, :spaces => :-).assert == '0043-1-98110'
    Phony.format('43198110', :format => :national).assert == '01 98110'

#### Denmark

    Phony.format('4540506070', format: :national).assert == '40 50 60 70'

#### France

    Phony.format('33142278186', :format => :+).assert == '+33 1 42 27 81 86'
    Phony.format('33142278186', :format => :+, :spaces => '').assert == '+33142278186'
    Phony.format('33142278186', :format => :+, :spaces => :-).assert == '+33-1-42-27-81-86'


#### India
      
    Phony.format('914433993939').assert == '+91 44 339 93 939'

#### Italy

    Phony.format('393333337647', :format => :international).assert == '+39 333 333 7647'
    Phony.format('390108480161', :format => :international).assert == '+39 010 8480161'
    Phony.format('393333337647', :format => :national).assert == '333 333 7647'
    Phony.format('390108480161', :format => :national).assert == '010 8480161'

#### Liechtenstein

    Phony.format('4233841148', :format => :international_relative).assert == '00423 384 11 48'
    Phony.format('4233841148', :format => :international_relative, :spaces => '').assert == '004233841148'
    Phony.format('4233841148', :format => :international_relative, :spaces => :-).assert == '00423-384-11-48'

#### NANP

    Phony.format('18705551122').assert == '+1 (870) 555-1122'
    Phony.format('18091231234', :format => :international).assert == '+1 (809) 123-1234'
    Phony.format('18091231234', :format => :international, :spaces => '').assert == '+1(809)123-1234'
    Phony.format('18091231234', :format => :international, :spaces => :-).assert == '+1-(809)-123-1234'

Does not show a trunk code by default on national level.

    Phony.format('14152223333', :format => :national).assert == '(415) 222-3333'
    Phony.format('14159224711', :format => :national).assert == '(415) 922-4711'

With forced trunk option.

    Phony.format('14159224711', :format => :national, :trunk => true).assert == '1 (415) 922-4711'
    Phony.format('14159224711', :format => :national, :trunk => false).assert == '(415) 922-4711'

With forced parentheses option.

    Phony.format('14159224711', :format => :national, :parentheses => true).assert == '(415) 922-4711'
    Phony.format('14159224711', :format => :national, :parentheses => false).assert == '415 922-4711'

#### Netherlands

    Phony.format('311012341234', :format => :national).assert == '010 123 41234'

With forced trunk.

    Phony.format('311012341234', :format => :national, :trunk => true).assert == '010 123 41234'

#### New Zealand

    Phony.format('6421123456').assert == '+64 21 123 456'
    Phony.format('64211234567').assert == '+64 21 123 4567'
    Phony.format('642112345678').assert == '+64 21 12 345 678'
    Phony.format('6493791234').assert == '+64 9 379 1234'

#### Russia

    Phony.format(Phony.normalize('+370 800 12345'), :format => :international).assert == '+370 800 12 345'
    Phony.format(Phony.normalize('+7 812 123 4567'), :format => :international).assert == '+7 812 123-45-67'
    Phony.format(Phony.normalize('+370 800 12345'), :format => :national).assert == '8800 12 345'
    Phony.format(Phony.normalize('+7 812 123 4567'), :format => :national).assert == '8812 123-45-67'

#### Switzerland

    Phony.format('41443643532').assert == '+41 44 364 35 32'
    Phony.format('41443643532', :format => :national).assert == '044 364 35 32'
    Phony.format('41800112233').assert == '+41 800 112 233'
    Phony.format('41443643532', :format => :international).assert == '+41 44 364 35 32'
    Phony.format('41443643532', :format => :national).assert == '044 364 35 32'
    Phony.format('41800112233', :format => :national).assert == '0800 112 233'
    Phony.format('41443643532', :format => :local).assert == '364 35 32'
    Phony.format('493038625454', :format => :local).assert == '386 25454'
    
#### Zimbabwe

##### Mobile numbers

    Phony.format('263713123456', :format => :international).assert == '+263 71 312 3456'
    Phony.format('263713123456', :format => :national).assert == '071 312 3456'
    Phony.format('263733123456', :format => :international).assert == '+263 73 312 3456'
    Phony.format('263733123456', :format => :national).assert == '073 312 3456'
    Phony.format('263773123456', :format => :international).assert == '+263 77 312 3456'
    Phony.format('263773123456', :format => :national).assert == '077 312 3456'
    Phony.format('263783123456', :format => :international).assert == '+263 78 312 3456'
    Phony.format('263783123456', :format => :national).assert == '078 312 3456'

#### Unsupported Countries

Formats as a single block.

    Phony.format('88132155605220').assert == '+881 32155605220'

Formats as a single block, regardless of format.

    Phony.format('8811819372205', :format => :international).assert == '+881 1819372205'

Formats as a single block, respecting custom spaces.

    Phony.format('8811819372205', :spaces => :-).assert == '+881-1819372205'

Formats as a single block, even without spaces.

    Phony.format('8811819372205', :spaces => '').assert == '+8811819372205'

### Special cases

Missing number parts are handled well enough.

      Phony.format('4144').assert == '+41 44 '
      Phony.format('4144364').assert == '+41 44 364'
      Phony.format('414436435').assert == '+41 44 364 35'
