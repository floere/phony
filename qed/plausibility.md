## Plausibility

### Phony#plausible?

### Options


#### cc

    Phony.assert.plausible?('+41 44 111 22 33', cc: '41')
    Phony.refute.plausible?('+41 44 111 22 33', cc: '1')

#### ndc

    Phony.assert.plausible?('+41 44 111 22 33', ndc: '44')
    Phony.refute.plausible?('+41 44 111 22 33', ndc: '43')

#### cc & ndc String

    Phony.assert.plausible?('+41 44 111 22 33', cc: '41', ndc: '44')

#### cc & ndc Regex

    Phony.refute.plausible?('+41 44 111 22 33', cc: /4(0|2)/, ndc: /4(4|5)/)
    Phony.assert.plausible?('+41 44 111 22 33', cc: /4(0|1)/, ndc: /4(4|5)/)

### Example countries

Some of the examples use `plausible? true: [some numbers]`.

#### Reserved

    Phony.refute.plausible?('010')
    Phony.refute.plausible?('0000000')
    Phony.refute.plausible?('+00 00 000 00 01')
    Phony.refute.plausible?('00 00 000 00 01')

#### Andorra

    Phony.assert.plausible?('+376 712345')
    Phony.refute.plausible?('+376 71234') # too short
    Phony.refute.plausible?('+376 7123456') # too long
    Phony.assert.plausible?('+376 712345')
    Phony.refute.plausible?('+376 71234') # too short
    Phony.refute.plausible?('+376 7123456') # too long

#### Angola

    Phony.assert.plausible?('+244 852 123 456')
    Phony.refute.plausible?('+244 852 123') # too short
    Phony.refute.plausible?('+244 852 123 4567') # too long

#### Albania

    Phony.assert.plausible?('+355 85 123456')
    Phony.refute.plausible?('+355 85 12345') # too short
    Phony.refute.plausible?('+355 85 1234567') # too long

#### Armenia

    Phony.assert.plausible?('+374 12345678')
    Phony.refute.plausible?('+374 1234567') # too short
    Phony.refute.plausible?('+374 123456789') # too long

#### Aruba

    # Landline
    Phony.assert.plausible?('+297 525 5200')
    Phony.assert.plausible?('+297 586 6555')
    # Mobile
    Phony.assert.plausible?('+297 737 7667')

    Phony.refute.plausible?('+297 520 000')    # too short
    Phony.refute.plausible?('+297 520 00000')  # too long

#### Austria

    Phony.assert.plausible?('+43 699 00000000')
    Phony.assert.plausible?('+43 1 000000')
    Phony.assert.plausible?('+43 1 0000000')
    Phony.assert.plausible?('+43 501 12345')
    Phony.assert.plausible?('+43 800 123456')
    Phony.assert.plausible?('+43 800 1234567')
    Phony.assert.plausible?('+43 800 12345678')
    Phony.assert.plausible?('+43 800 123456789')
    Phony.assert.plausible?('+43 800 1234567890')
    Phony.assert.plausible?('+43 512 1234567890')
    Phony.assert.plausible?('+43 670 1234567890')
    Phony.assert.plausible?('+43 3115 3307') # See issue #246 on Github.
    Phony.assert.plausible?('+43 678 1220084')
    Phony.assert.plausible?('+43 720 116987')

Mobile.

    Phony.assert.plausible?('+43 676 0000000')
    Phony.assert.plausible?('+43 681 00000000')
    Phony.assert.plausible?('+43 688 0000000')
    Phony.assert.plausible?('+43 699 00000000')

663 mobile numbers have 6..8 digits.

    Phony.assert.plausible?('+43 663 000000')
    Phony.assert.plausible?('+43 663 12345678')

Mobile numbers can have from 7 to 10 digits in the subscriber number.

    Phony.assert.plausible?('+43 664 1234 567')
    Phony.assert.plausible?('+43 664 1234 5678')
    Phony.assert.plausible?('+43 664 1234 56789')
    Phony.assert.plausible?('+43 664 1234 567890')

#### Australia

    Phony.assert.plausible?('+614 1234 5678')
    Phony.assert.plausible?('+61 1800 123 456')
    Phony.assert.plausible?('+61 1300 123 456')
    Phony.assert.plausible?('+61 13 12 12')
    Phony.assert.plausible?('+613 1234 5678')
    Phony.refute.plausible?('+613 1234 56789') # too long
    Phony.refute.plausible?('+613 1234 567') # too short

#### Azerbaijan

    Phony.assert.plausible?('+994 12 1234567')
    Phony.refute.plausible?('+994 12 12345') # too short
    Phony.refute.plausible?('+994 12 12345678') # too long

#### Bahrain

    Phony.assert.plausible?('+973 1234 5678')
    Phony.refute.plausible?('+973 1234 567')  # too short
    Phony.refute.plausible?('+973 1234 56789') # too long

#### Bangladesh

    Phony.assert.plausible?('+880 2 1234567')
    Phony.refute.plausible?('+880 2 12345678') # too long
    Phony.refute.plausible?('+880 2 123456') # too short

    Phony.assert.plausible?('+880 9020 12345')
    Phony.refute.plausible?('+880 9020 123456') # too long
    Phony.refute.plausible?('+880 9020 1234') # too short

NDC with several subscriber number length.

    Phony.assert.plausible?('+880 3035 1234')
    Phony.assert.plausible?('+880 3035 123')
    Phony.refute.plausible?('+880 3035 12') # too short
    Phony.refute.plausible?('+880 3035 12345') # too long

#### Belarus

    Phony.assert.plausible?('+375 152 123456')
    Phony.refute.plausible?('+375 152 12345') # too short
    Phony.refute.plausible?('+375 152 1234567') # too long

    Phony.assert.plausible?('+375 800 123')
    Phony.assert.plausible?('+375 800 1234')
    Phony.assert.plausible?('+375 800 1234567')
    Phony.refute.plausible?('+375 800 123456')
    Phony.refute.plausible?('+375 800 12345678')

#### Belize

    plausible? true: '+501 205 1234'

#### Belgium

    Phony.assert.plausible?('+32 3 241 11 32')
    Phony.assert.plausible?('0032 3 241 11 32')
    Phony.assert.plausible?('0032 (0) 3 241 11 32')
    Phony.assert.plausible?('+32 460 12 34 56')
    Phony.assert.plausible?('+32 465 12 34 56')
    Phony.assert.plausible?('+32 466 12 34 56')
    Phony.assert.plausible?('+32 468 12 34 56')
    Phony.assert.plausible?('+32 471 12 34 56')
    Phony.assert.plausible?('+32 481 12 34 56')
    Phony.assert.plausible?('+32 489 12 34 56')

#### Benin

    plausible? true: '+229 1234 5678'

#### Bhutan

    plausible? true: '+975 2 889 648'

#### Bolivia

    plausible? true: '+591 2 277 2266'

#### Botswana

    plausible? true: [
      '+267 80 123 456',
      '+267 29 567 89',
      '+267 463 4567',
      '+267 58 123 45',
      '+267 7 6712 345',
      '+267 8 1234 567'
    ]

#### Brunei

    plausible? true: '+673 5 523 876'

#### Bulgaria
    plausible? true: '+359 2 492840'
    plausible? true: '+359 87 8357523'

#### Burkina Faso

    plausible? true: '+226 1476 2312'

#### Burundi

    plausible? true: '+257 1234 5678'

#### Cambodia

http://en.wikipedia.org/wiki/Telecommunications_in_Cambodia#Mobile_networks
http://en.wikipedia.org/wiki/Telephone_numbers_in_Cambodia
http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000230001MSWE.doc
http://www.khmerdigitalpost.com/national-numbering-plans-in-cambodia-by-2014/
http://www.khmerdigitalpost.com/mobile-operators-in-cambodia-by-2015/

##### Mobile Numbers

    Phony.assert.plausible?("+855762345678")    # Mobitel (7 digit id)
    Phony.refute.plausible?("+85576234567")     # Mobitel (too short)
    Phony.assert.plausible?("+85517234567")     # Mobitel (6 digit id)
    Phony.assert.plausible?("+85512999399")     # Mobitel (6 digit id)
    Phony.refute.plausible?("+855172345678")    # Mobitel (too long)
    Phony.assert.plausible?("+85592122417")     # Mobitel (6 digit extended range id)
    Phony.assert.plausible?("+855121234567")    # Mobitel (7 digit extended range id)

    Phony.assert.plausible?("+855383001801")    # CooTel (7 digit id)
    Phony.refute.plausible?("+85538300180")     # CooTel (too short)

    Phony.assert.plausible?("+85518234567")     # Excell (6 digit id)
    Phony.refute.plausible?("+855182345678")    # Excell (too long)

    Phony.assert.plausible?("+855882345678")    # Metfone (7 digit id)
    Phony.refute.plausible?("+85588234567")     # Metfone (too short)
    Phony.assert.plausible?("+855972345678")    # Metfone (7 digit id)
    Phony.refute.plausible?("+85597234567")     # Metfone (too short)
    Phony.assert.plausible?("+855714822684")    # Metfone (7 digit id)
    Phony.refute.plausible?("+85571482268")     # Metfone (too short)

    Phony.assert.plausible?("+85513234567")     # qb (6 digit id)
    Phony.refute.plausible?("+855132345678")    # qb (too long)

    Phony.assert.plausible?("+855962345678")    # Smart (7 digit id)
    Phony.refute.plausible?("+85596234567")     # Smart (too short)
    Phony.assert.plausible?("+85510234567")     # Smart (6 digit id)
    Phony.refute.plausible?("+855102345678")    # Smart (too long)

    Phony.assert.plausible?("+85518870054")     # Excell (6 digit id)
    Phony.assert.plausible?("+855189700541")    # Seatel (7 digit id)
    Phony.refute.plausible?("+855188700545")    # Excell (too long)
    Phony.refute.plausible?("+85518970054")     # Seatel (too short)

    Phony.assert.plausible?("+855399999898")    # Kingtel  (7 digit id)
    Phony.refute.plausible?("+85539999989")     # Kingtel  (too short)

    Phony.refute.plausible?("+85512023456")     # invalid numbering plan
    Phony.refute.plausible?("+85510123456")     # invalid numbering plan
    Phony.refute.plausible?("+855380234567")    # invalid numbering plan
    Phony.refute.plausible?("+855381234567")    # invalid numbering plan
    Phony.refute.plausible?("+85519234567")     # invalid mobile operator

##### Fixed Line

    Phony.assert.plausible?("+85523212345")     # Fixed line Telecom Cambodia
    Phony.refute.plausible?("+855232123456")    # Fixed line Telecom Cambodia (too long)

    Phony.assert.plausible?("+85523312345")     # Fixed line Mobitel
    Phony.refute.plausible?("+855233123456")    # Fixed line Mobitel (too long)

    Phony.assert.plausible?("+85523412345")     # Fixed line Telecom Cambodia
    Phony.refute.plausible?("+855234123456")    # Fixed line Telecom Cambodia (too long)

    Phony.assert.plausible?("+85523712345")     # Fixed line Telecom Cambodia
    Phony.refute.plausible?("+855237123456")    # Fixed line Telecom Cambodia (too long)

    Phony.assert.plausible?("+85523812345")     # Fixed line Telecom Cambodia
    Phony.refute.plausible?("+855238123456")    # Fixed line Telecom Cambodia (too long)

    Phony.assert.plausible?("+85523912345")     # Fixed line Camintel
    Phony.refute.plausible?("+855239123456")    # Fixed line Camintel (too long)

    Phony.assert.plausible?("+855234523456")    # Fixed line Smart
    Phony.refute.plausible?("+85523452345")     # Fixed line Smart (too short)

    Phony.assert.plausible?("+855234623456")    # Fixed line Metfone
    Phony.refute.plausible?("+85523462345")     # Fixed line Metfone (too short)

    Phony.assert.plausible?("+855234723456")    # Fixed line CooTel
    Phony.refute.plausible?("+85523472345")     # Fixed line CooTel (too short)

    Phony.assert.plausible?("+855234823456")    # Fixed line Excell
    Phony.refute.plausible?("+85523482345")     # Fixed line Excell (too short)

    Phony.assert.plausible?("+855234923456")    # Fixed line qb
    Phony.refute.plausible?("+85523492345")     # Fixed line qb (too short)

    Phony.assert.plausible?("+855235023456")    # Fixed line Mobitel
    Phony.refute.plausible?("+85523502345")     # Fixed line Mobitel (too short)

    Phony.assert.plausible?("+855235123456")    # Fixed line Mobitel
    Phony.refute.plausible?("+85523512345")     # Fixed line Mobitel (too short)

    Phony.assert.plausible?("+855235223456")    # Fixed line Mobitel
    Phony.refute.plausible?("+85523522345")     # Fixed line Mobitel (too short)

    Phony.assert.plausible?("+855235323456")    # Fixed line Mobitel
    Phony.refute.plausible?("+85523532345")     # Fixed line Mobitel (too short)

    Phony.assert.plausible?("+855235423456")    # Fixed line Mobitel
    Phony.refute.plausible?("+85523542345")     # Fixed line Mobitel (too short)

    Phony.assert.plausible?("+855235523456")    # Fixed line Mobitel
    Phony.refute.plausible?("+85523552345")     # Fixed line Mobitel (too short)

    Phony.assert.plausible?("+855235623456")    # Fixed line Smart
    Phony.refute.plausible?("+85523562345")     # Fixed line Smart (too short)

    Phony.assert.plausible?("+855236623456")    # Fixed line Metfone
    Phony.refute.plausible?("+85523662345")     # Fixed line Metfone (too short)

    Phony.refute.plausible?("+85527234567")     # invalid ndc
    Phony.refute.plausible?("+85523134567")     # invalid numbering plan

#### Cameroon

    plausible? true: '+237 737 28 18 65'

#### Cape Verde

    plausible? true: '+238 642 3843'

#### Central African Republic

    plausible? true: '+236 1234 5678'

#### Chad

    plausible? true: '+235 1234 5678'

#### Comoros

    plausible? true: [
      ['+269 3901 234', '+269 3401 234']
    ]

#### Croatia

Landline.

    Phony.assert.plausible?('+385 21 695900')
    Phony.assert.plausible?('+385 1 4566 666')

    Phony.refute.plausible?('+385 21 123 45') # Too short
    Phony.assert.plausible?('+385 21 123 456')
    Phony.assert.plausible?('+385 21 123 4567')
    Phony.refute.plausible?('+385 21 123 45678') # Too long

Mobile.

    Phony.refute.plausible?('+385 91 123 45') # Too short
    Phony.assert.plausible?('+385 91 123 456')
    Phony.assert.plausible?('+385 91 123 4567')
    Phony.assert.plausible?('+385 91 896 7509') # Too long

#### Colombia

    plausible? true: ['+57 1 123 4567', '+57 310 123 4567']

#### Denmark

    Phony.assert.plausible?('45 44 11 22 33')
    Phony.refute.plausible?('+45 44 11 12 23 34')
    Phony.refute.plausible?('+45 44 11 12 2')
    Phony.assert.plausible?('+45 44 55 22 33')

#### Dutch Antilles

    Phony.assert.plausible?('+599 1234567')
    Phony.refute.plausible?('+599 123456') # too short
    Phony.refute.plausible?('+599 12345678') # too long

#### Egypt

    Phony.assert.plausible?('+20 800 1234567')
    Phony.refute.plausible?('+20 800 12345678')
    Phony.assert.plausible?('+20 2 12345678')
    Phony.refute.plausible?('+20 2 1234567')
    Phony.assert.plausible?('+20 3 1234567')
    Phony.refute.plausible?('+20 3 12345678')
    Phony.assert.plausible?('+20 40 1234567')
    Phony.refute.plausible?('+20 40 12345678')
    Phony.assert.plausible?('+20 10 12345678')
    Phony.refute.plausible?('+20 10 1234567')
    Phony.assert.plausible?('+20 11 12345678')
    Phony.refute.plausible?('+20 11 1234567')
    Phony.assert.plausible?('+20 12 12345678')
    Phony.refute.plausible?('+20 12 1234567')

#### Estonia

    # the 5xxxx mobile numbers can be 7 or 8 digits (ndc + subscriber) long
    Phony.assert.plausible?('+372 532 12345')
    Phony.assert.plausible?('+372 532 1234')
    Phony.refute.plausible?('+372 532 123')
    Phony.refute.plausible?('+372 532 123456')

    # the 81x/82x are only 8 digits
    Phony.assert.plausible?('+372 822 12345')
    Phony.assert.plausible?('+372 812 12345')
    Phony.refute.plausible?('+372 822 1234')
    Phony.refute.plausible?('+372 812 1234')
    Phony.refute.plausible?('+372 822 123')
    Phony.refute.plausible?('+372 822 123456')

#### Finland

    Phony.assert.plausible?('+358 457 123 45')
    Phony.assert.plausible?('+358 457 123 45 6')
    Phony.assert.plausible?('+358 457 123 45 67')
    Phony.assert.plausible?('+358 41 123 45')
    Phony.assert.plausible?('+358 41 123 45 6')
    Phony.assert.plausible?('+358 41 123 45 67')
    Phony.assert.plausible?('+358 50 123 45')
    Phony.assert.plausible?('+358 50 123 45 6')
    Phony.assert.plausible?('+358 50 123 45 67')

#### Germany

    Phony.assert.plausible?('+49 209 169 - 0') # Gelsenkirchen
    Phony.assert.plausible?('+49 209 169 - 3530') # Gelsenkirchen
    Phony.assert.plausible?('+49 40 123 45678')
    Phony.assert.plausible?('+49 40 123 456789') # TODO ?
    Phony.assert.plausible?('+49 160 123 1234') # Mobile Number 7 digits
    Phony.assert.plausible?('+49 160 123 12345') # Mobile Number 8 digits
    Phony.assert.plausible?('+49 171 123 4567')
    Phony.assert.plausible?('+49 171 123 45678') # is a valid number according German authority "bundesnetzagentur": http://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/ONRufnr/NummernplanOrtsnetzrufnummern.pdf?__blob=publicationFile&v=2 (04.24.2014)
    Phony.assert.plausible?('+49 177 123 1234')
    Phony.assert.plausible?('+49 176 123 12345')
    Phony.assert.plausible?('+49 991 1234')   # stricter 3 digit ndc rules
    Phony.assert.plausible?('+49 2041 123') # Grandfathered numbers.
    Phony.assert.plausible?('+49 2041 1234567')
    Phony.assert.plausible?('+49 31234 123456')
    Phony.assert.plausible?('+49 7141 12345670')
    Phony.assert.plausible?('+49 1609 1234567') # Bug: https://github.com/floere/phony/issues/146
    Phony.assert.plausible?('+49 800 1234567')
    Phony.assert.plausible?('+49 1805 878323')

    # Extended service numbers
    # http://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/0800/0800_Nummernplan.pdf?__blob=publicationFile&v=1
    Phony.assert.plausible?('+49 800 222 3400 10')
    Phony.assert.plausible?('+49 800 222 3400 100')
    Phony.assert.plausible?('+49 800 222 3400 1000')
    Phony.refute.plausible?('+49 800 222 3400 10000')

    # Following tests implement specifications from
    # http://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/ONRufnr/NummernplanOrtsnetzrufnummern.pdf?__blob=publicationFile&v=2 (04.24.2014)
    # Page 3
    Phony.assert.plausible?('+49 89    12345678') # NZ-E
    Phony.assert.plausible?('+49 89    123456789') # NZ-E & NZ-Z
    Phony.assert.plausible?('+49 89    1234567890') # NZ-Z
    Phony.assert.plausible?('+49 209   1234567') # NZ-E
    Phony.assert.plausible?('+49 209   12345678') # NZ-E & NZ-Z
    Phony.assert.plausible?('+49 209   123456789') # NZ-Z
    Phony.assert.plausible?('+49 6421  123456') # NZ-E
    Phony.assert.plausible?('+49 6421  1234567') # NZ-E & NZ-Z
    Phony.assert.plausible?('+49 6421  12345678') # NZ-Z
    Phony.assert.plausible?('+49 33053 12345') # NZ-E
    Phony.assert.plausible?('+49 33053 123456') # NZ-E & NZ-Z
    Phony.assert.plausible?('+49 33053 1234567') # NZ-Z
    # Point 2.3c) Numbers can be up to 13 Digits long without prefix according to E.164
    Phony.assert.plausible?('+49 33053 12345678')
    Phony.assert.plausible?('+49 6421 123456789')
    Phony.assert.plausible?('+49 209 1234567890')
    Phony.assert.plausible?('+49 40 12345678901')

#### Greece

    plausible? true: [
      '+30 21 4234 5678',
      '+30 24 4234 5678',
      '+30 50 3457 1234',
      '+30 69 0123 4567',
      '+30 70 0123 4567',
      '+30 800 100 1234',
      '+30 801 100 1234',
      '+30 807 100 1234',
      '+30 896 100 1234',
      '+30 901 123 4565',
      '+30 909 123 4565'
    ]

#### Hong Kong
    plausible? true: [
        '+852800121234',    # Toll Free
        '+85212341234',     # Other Numbers
    ]

#### Hungary

    plausible? true: [
        '+36 1 234 5678',     # Budapest
        '+36 20 1234 567',    # Telenor
        '+36 30 1234 567',    # T-Mobile
        '+36 70 1234 567',    # Vodafone
        '+36 31 1234 567',    # UPC, Tesco Mobile
        '+36 21 1234 567',    # Voip
        '+36 40 123 456',     # Business rate numbers
        '+36 80 123 456',     # Freephone service
        '+36 90 123 456',     # Premium-rate number
        '+36 91 123 456',     # Premium-rate number
        '+36 38 123 4567',    # Corporate network numbers
        '+36 51 123 456',     # SHS
        '+36 71 12345 67890', # M2M (2+10)
        '+36 22 123 567'      # Geographic number
    ]

#### Indonesia

    plausible? true: [
      '+62 13 123',
      '+62 13 123 456',
      '+62 174 12',
      '+62 174 12 345',
      '+62 177 12',
      '+62 177 1212 3456',
      '+62 178 123',
      '+62 178 123 45',
      '+62 21 123 45',
      ['+62 21 123 4567', '+62 21 1234 5567'],
      '+62 22 123 45',
      '+62 22 123 4567',
      '+62 4 311 234',
      '+62 4 3112 3456',
      ['+62 6 221 2345', '+62 6 2212 3456'],
      '+62 70 123 456',
      ['+62 71 123 456', '+62 71 123 4567'],
      ['+62 810 123 456', '+62 810 123 4567', '+62 810 1234 5678'],
      ['+62 815 123 456', '+62 815 123 4567', '+62 815 1234 5678'],
      '+62 820 123 456',
      ['+62 823 123 456', '+62 823 123 4567', '+62 823 1234 5678'],
      '+62 870 123 45',
      ['+62 877 123 456', '+62 877 123 4567', '+62 877 1234 5678'],
      ['+62 878 123 456', '+62 878 123 4567', '+62 878 1234 5678'],
      ['+62 881 123 456', '+62 881 123 4567', '+62 881 1234 5678', '+62 881 1234 56789'],
      '+62 9 1234 567',
      '+62 9 123 456 789'
    ]

#### Israel

    plausible? true: [
      '+972 2 123 1234',
      '+972 59 123 1234',
      '+972 51 123 1234',
      '+972 79 123 1234',
    ]

#### Italy

    Phony.assert.plausible?('+39 06 1234 45')
    Phony.assert.plausible?('+39 06 1234 456')
    Phony.assert.plausible?('+39 06 1234 4567')

    Phony.refute.plausible?('+39 035 00000')
    Phony.assert.plausible?('+39 035 000000')
    Phony.assert.plausible?('+39 015 8407324')

    Phony.assert.plausible?('+39 0471 123 456')

Mobile.

    Phony.refute.plausible?('+39 335 123')
    Phony.refute.plausible?('+39 335 123 45')
    Phony.assert.plausible?('+39 335 123 456')
    Phony.assert.plausible?('+39 335 123 4567')
    Phony.assert.plausible?('+39 335 123 45678')
    Phony.refute.plausible?('+39 335 123 456789')

#### Japan

    plausible? true:[
      '+81 3 1234 5678',
      '+81 120 123 456',
      '+81 800 123 4567',
      '+81 11 1234 567',
      '+81 123 123 456',
      '+81 1267 123 45',
      '+81 90 1234 5678'
    ]

#### Jordan (Hashemite Kingdom of)

    plausible? true: [
      '+962 800 123 45',
      '+962 2 620 1234',
      '+962 7 1234 5678',
      '+962 7 4661 2345',
      '+962 900 123 45',
      '+962 85 123 456',
      '+962 70 123 456',
      '+962 6250 1456',
      '+962 8790 1456'
    ]

#### Kyrgyzstan

    plausible? true: [
      '+996 312 212 345',
      '+996 315 212 345',
      '+996 3131 212 34',
      '+996 3946 212 34',
      '+996 50 123 4567',
      '+996 52 123 4567',
      '+996 58 123 4567',
      '+996 800 123 456'
    ]

#### Malaysia

    Phony.assert.plausible?('+60 14 123 1234')
    Phony.assert.plausible?('+60 11 123 12345')
    Phony.refute.plausible?('+60 14 1234 12')     # too short
    Phony.refute.plausible?('+60 14 1234 12345')  # too long

#### Mexico

    Phony.assert.plausible?('+52 1 55 1212 1212')
    Phony.assert.plausible?('+52 55 1212 1212')
    Phony.assert.plausible?('+52 664 123 1212')
    Phony.assert.plausible?('+52 1 664 123 1212')
    Phony.assert.plausible?('+52 044 664 123 1212')
    Phony.refute.plausible?('+52 1 55 1212 1212 3')  # too long
    Phony.refute.plausible?('+52 55 1212 121')     # too short

#### Montenegro

    plausible? true: [
      '+382 80 123 456',
      ['+382 20 123 45', '+382 20 123 456'],
      '+382 32 123 456',
      '+382 78 103 456',
      '+382 63 123',
      '+382 63 123 456 7890',
      '+382 77 103 456',
      '+382 94 103 456',
      '+382 88 103 456',
      '+382 68 12',
      '+382 68 12 1234 5678',
      '+382 68 432 163',
      '+382 69 705 542',
      '+382 70 123',
      '+382 70 123 456 7890'
    ]

#### NANP

It rejects too small numbers.

    Phony.refute.plausible?('+1911')

Still need E164 conform numbers.

    Phony.refute.plausible?('4346667777', cc: '1')

Automatic country checking.

    Phony.assert.plausible?('1-4346667777')
    Phony.assert.plausible?('1-800-692-7753')
    Phony.refute.plausible?('1-911')
    Phony.refute.plausible?('1-911-123-1234')
    Phony.refute.plausible?('1-411-123-1234')
    Phony.refute.plausible?('1-040-123-1234')
    Phony.refute.plausible?('143466677777') # too long
    Phony.refute.plausible?('143466677') # too short

With string constraints.

    Phony.assert.plausible?('14346667777', cc: '1')
    Phony.assert.plausible?('14346667777', ndc: '434')
    Phony.assert.plausible?('14346667777', cc: '1', ndc: '434')

With regexp constraints.

    Phony.assert.plausible?('14346667777', cc: /[123]/)
    Phony.assert.plausible?('14346667777', ndc: /434|435/)
    Phony.assert.plausible?('14346667777', cc: /[123]/, ndc: /434|435/)

#### Netherlands

    Phony.assert.plausible?('+31 6 12 34 56 78')
    Phony.refute.plausible?('+31 6 12 34 56 7')
    Phony.assert.plausible?('+31 20 123 5678')
    Phony.refute.plausible?('+31 20 123 567')
    Phony.assert.plausible?('+31 221 123 567')
    Phony.refute.plausible?('+31 221 123 56')
    Phony.assert.plausible?('+31 880 450 245')
    Phony.refute.plausible?('+31 880 450 24')
    Phony.assert.plausible?('+31 900 123 4567')
    Phony.refute.plausible?('+31 900 001 00')
    Phony.assert.plausible?('+31 800 6080')
    Phony.assert.plausible?('+31 970 1234 5678')
    Phony.refute.plausible?('+31 971 2345 6789')
    Phony.assert.plausible?('+31 979 0000 0000')

#### New Zealand

    Phony.assert.plausible?('+64 21 123 456')
    Phony.assert.plausible?('+64 21 123 4567')
    Phony.assert.plausible?('+64 9 379 1234')
    Phony.assert.plausible?('+64 21 12 345 678')
    Phony.refute.plausible?('+64 21 1234 56789') # too long
    Phony.refute.plausible?('+64 21 12345') # too short

#### Nigeria

    plausible? true: [
      '+234 700 766 1234',
      '+234 701 766 1234',
      '+234 702 766 1234',
      '+234 703 766 1234',
      '+234 704 766 1234',
      '+234 705 766 1234',
      '+234 706 766 1234',
      '+234 707 766 1234',
      '+234 708 766 1234',
      '+234 709 766 1234',
      '+234 800 766 1234',
      '+234 801 766 1234',
      '+234 802 766 1234',
      '+234 803 766 1234',
      '+234 804 766 1234',
      '+234 805 766 1234',
      '+234 806 766 1234',
      '+234 807 766 1234',
      '+234 808 766 1234',
      '+234 809 766 1234',
      '+234 900 766 1234',
      '+234 901 766 1234',
      '+234 902 766 1234',
      '+234 903 766 1234',
      '+234 904 766 1234',
      '+234 905 766 1234',
      '+234 906 766 1234',
      '+234 907 766 1234',
      '+234 908 766 1234',
      '+234 909 766 1234',
      '+234 810 766 1234',
      '+234 811 766 1234',
      '+234 812 766 1234',
      '+234 813 766 1234',
      '+234 814 766 1234',
      '+234 815 766 1234',
      '+234 816 766 1234',
      '+234 817 766 1234',
      '+234 818 766 1234',
      '+234 819 766 1234'
    ], false: '+234 807 766 123' # too short

#### Pakistan

    plausible? true: ['+92 21 1234 5678',
      '+92 22 1234 567',
      '+92 232 123 456',
      '+92 30 1234 5678'
    ]

#### Papua New Guinea

    plausible? true: [
      '+675 3 123 567',
      '+675 180 1234',
      '+675 80 123 456',
      '+675 91 123 456',
      '+675 16 123 45',
      '+675 184 1234 5678',
      '+675 170 12',
      '+675 189 1',
      '+675 270 1234',
      '+675 275 1234',
      '+675 279 12',
      '+675 115 1234 5678',
      '+675 711 23 456',
      '+675 731 23 456',
      '+675 741 23 456',
      '+675 770 12 345',
      '+675 771 12 345',
      '+675 772 12 345',
      '+675 773 01 234',
      '+675 774 12 345',
      '+675 775 12 345'
    ]

#### Paraguay (Republic of)

    plausible? true: [
      ['+595 21 123 456', '+595 21 123 4567'],
      '+595 345 123 456',
      '+595 96 161 1234'
    ]

#### Philippines

    plausible? true: [
      '+63 2 1234567',
      '+63 2 1234567890',
      '+63 88 1234567',
      ['+63 920 123456', '+63 920 1234567']
    ]

#### Qatar

    plausible? true: [
      '+974 1245 123 456',
      '+974 26 134 56',
      '+974 33 123 456',
      '+974 44 412 456',
      '+974 800 12 34',
      '+974 900 12 34',
      '+974 92 123',
      '+974 97 123'
    ]

#### Portugal

    Phony.assert.plausible?('+351 800 123456')
    Phony.assert.plausible?('+351 90 1234567')
    Phony.refute.plausible?('+351 90 123456')
    Phony.assert.plausible?('+351 123 123456')
    Phony.refute.plausible?('+351 123 1234567')

#### Romania

    plausible? true: [
      '+40 21 123 1234',
      '+40 72 123 1234',
      '+40 79 123 1234',
      '+40 249 123 123'
    ]

#### Russia

    Phony.assert.plausible?('+7 800 2000 600')
    Phony.assert.plausible?('+7 960 301 23 45')
    Phony.refute.plausible?('+7 800 2000 60') # too short
    Phony.refute.plausible?('796030123451') # too long

#### Slovenia

    Phony.assert.plausible?('+386 41 123 456')
    Phony.assert.plausible?('+386 1 320 1234')
    Phony.refute.plausible?('+386 41 123 4567')

#### Switzerland

    Phony.assert.plausible?('+41 44 111 22 33')
    Phony.refute.plausible?('+41 44 111 22 3')
    Phony.refute.plausible?('+41 44 111 22 334')
    Phony.refute.plausible?('+41 44 111 22')
    Phony.assert.plausible?('+41 (044) 364 35 33')

#### Sweden

    Phony.assert.plausible?('+46 8 506 10 60')
    Phony.assert.plausible?('+46 8 506 106 00')
    Phony.assert.plausible?('+46 19 764 22 00')
    Phony.assert.plausible?('+46 19 20 88 50')
    Phony.assert.plausible?('+46 42 123 45')
    Phony.assert.plausible?('+46 79 123 45 67')
    Phony.assert.plausible?('+46 513 12 34 56')
    Phony.refute.plausible?('+46 513 12 34 567') # too long
    Phony.refute.plausible?('+46 19 20 88') # too short
    Phony.refute.plausible?('+46 11 22 33') # too short and starts with a service number
    Phony.assert.plausible?('+46 118 800')
    Phony.assert.plausible?('+46 11 222 333')
    Phony.assert.plausible?('+46 11 622 333')
    Phony.assert.plausible?('+46 11 822 333')

#### Vietnam

    Phony.assert.plausible?('+84 8 3827 9666')
    Phony.assert.plausible?('+84 24 1234 5678')
    Phony.assert.plausible?('+84 091 123-4567')
    Phony.assert.plausible?('+84 034 123456')
    Phony.refute.plausible?('+84 1 1234') # too short
    Phony.refute.plausible?('+84 12 3456 7891 0111213') # too long

#### Zimbabwe

http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000E90002PDFE.pdf

##### Mobile numbers

    plausible? true: [
        '+263 71 3123456',
        '+263 73 3123456',
        '+263 77 3123456',
        '+263 78 3123456'
    ]

    plausible? false: [
        '+263 78 312345',   # too short
        '+263 78 31234567'  # too long
    ]

#### Various Countries

    Phony.assert.plausible?('6327332350')
    Phony.assert.plausible?('+4231231212')
    Phony.assert.plausible?('+4755121212')
    Phony.refute.plausible?('+475512121')
    Phony.refute.plausible?('+47551212121')
    Phony.refute.plausible?("+460000")

### Special Cases

The given number is unchanged.

      number = "123-123-1234"
      Phony.plausible? number
      number.assert == '123-123-1234'

Too small numbers are rejected.

      Phony.refute.plausible?('353')

Letters-only are rejected.

    Phony.refute.plausible?('hello')
