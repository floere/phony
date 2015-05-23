## Plausibility

### Phony#plausible?

### Special Cases

The given number is unchanged.

      number = "123-123-1234"
      Phony.plausible? number
      number.assert == '123-123-1234'

Too small numbers are rejected.

      Phony.refute.plausible?('353')

Letters-only are rejected.

    Phony.refute.plausible?('hello')

### Example countries

#### Reserved

    Phony.refute.plausible?('010')
    Phony.refute.plausible?('0000000')
    Phony.refute.plausible?('+00 00 000 00 01')
    Phony.refute.plausible?('00 00 000 00 01')

#### Denmark

    Phony.assert.plausible?('45 44 11 22 33')

#### NANP

It rejects too small numbers.

      Phony.refute.plausible?('+1911')