## Exceptions

### Phony#normalize

If a nil number is given, Phony will tell a user specifically.

    expect ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.normalize(number).' do
      Phony.format nil
    end

Raises if number starts with reserved zero code.

    expect Phony::NormalizationError, 'Phony could not normalize the given number. Is "+00 00 00 00 01" a phone number?' do
      Phony.normalize '+00 00 00 00 01'
    end

Raises a nice error message.

    expect Phony::NormalizationError, 'Phony could not normalize the given number. Is "test" a phone number?' do
      Phony.normalize 'test'
    end

### Phony#format

If a nil number is given, Phony will tell a user specifically.

    expect ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.format(number).' do
      Phony.format nil
    end

### Phony#split

If a nil number is given, Phony will tell a user specifically.

    expect ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.split(number).' do
      Phony.split nil
    end
