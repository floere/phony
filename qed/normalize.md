This will often raise an error if you try normalizing a non E164-izable number (a number that does not contain enough information to be normalized into an E164 conform number). Use Phony.plausible? for checking if it can be normalized first.

Example:

```ruby
  # No. Wrong. Nada.
  Phony.normalize('364 35 33')
```

Always use it with a country code, as Phony needs it to know what country to normalize for:

```ruby
  Phony.normalize('41443643533').assert            == '41443643533'
  Phony.normalize('+41 44 364 35 33').assert       == '41443643533'
  Phony.normalize('+41 44 364 35 33').assert       == '41443643533'
  Phony.normalize('+41 800 11 22 33').assert       == '41800112233'
  Phony.normalize('John: +41 44 364 35 33').assert == '41443643533'
  Phony.normalize('1 (703) 451-5115').assert       == '17034515115'
  Phony.normalize('1-888-407-4747').assert         == '18884074747'
  Phony.normalize('1.906.387.1698').assert         == '19063871698'
  Phony.normalize('+41 (044) 364 35 33').assert    == '41443643533'
```