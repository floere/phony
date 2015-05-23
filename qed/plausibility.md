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

#### Reserved

    Phony.refute.plausible?('010')
    Phony.refute.plausible?('0000000')
    Phony.refute.plausible?('+00 00 000 00 01')
    Phony.refute.plausible?('00 00 000 00 01')

#### Austria

    Phony.assert.plausible?('+43 699 00000000')

#### Denmark

    Phony.assert.plausible?('45 44 11 22 33')

#### NANP

It rejects too small numbers.

      Phony.refute.plausible?('+1911')

#### Switzerland

    Phony.assert.plausible?('+41 44 111 22 33')

### Special Cases

The given number is unchanged.

      number = "123-123-1234"
      Phony.plausible? number
      number.assert == '123-123-1234'

Too small numbers are rejected.

      Phony.refute.plausible?('353')

Letters-only are rejected.

    Phony.refute.plausible?('hello')