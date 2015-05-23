## Performance

We'll take 5 numbers as an example.

    phone_numbers = [
      '41443643532',
      '18091231234',
      '43198110',
      '33142278186',
      '4233841148'
    ]

    number = phone_numbers.first

These examples show that you can render many many phone numbers in a very short time.

### Phony.split

It is fast.

    performance_of { Phony.split(number) }.assert < 0.00005
    performance_of { phone_numbers.each { |number| Phony.split(number) } }.assert < 0.00015

### Phony.normalize

It is fast.

    performance_of { Phony.normalize(number) }.assert < 0.0001
    performance_of { phone_numbers.each { |number| Phony.normalize(number) } }.assert < 0.00015

### Phony.format

It is fast.

    performance_of { Phony.format(number) }.assert < 0.000075
    performance_of { phone_numbers.each { |number| Phony.format(number) } }.assert < 0.00015