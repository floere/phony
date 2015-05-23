
This gem normalizes, formats and splits *E164 phone numbers*. A valid E164 phone number *must* include a country code.

E164 numbers are international numbers with a country dial prefix, usually an area code and a subscriber number. For example, the Austalian number number @+61 412 345 678@ can be broken down into the following components:
* Country Code (CC): a country code of @61@
* National Destination Code (NDC): a mobile number denoted by the @4@ (specific to Australia)
* Local Number Part: a subscriber number of @12 345 678@

Learn more about E164 numbers "here":http://en.wikipedia.org/wiki/E.164.

If it doesn't work, please "enter an issue":http://github.com/floere/phony/issues or better, fork and send a pull request.

# Phony

Phony acts like a helper class, so every public method is on the phony object, for example normalize:

```ruby
  Phony.normalize('+1 (555) 123-4567890').assert == '15551234567890'
```

Often, you combine multiple `Phony` methods.

```ruby
  Phony.format(Phony.normalize('+1 (555) 123-4567890'), :format => :national).assert == '(555) 123-4567890'
```

There are 4 main methods: `#normalize`, `#format`, `#split`, `#plausible?`

```ruby
  Phony.normalize('41443643533').assert == '41443643533'
  Phony.format('41443643533').assert == '+41 44 364 35 33'
  Phony.split('41443643533').assert == ['41', '44', '364', '35', '33']
  Phony.assert.plausible?('41443643533')
```