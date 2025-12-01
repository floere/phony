# frozen_string_literal: true

require 'phony'

numbers = %w[
  225784367
  64225784367
  +64225784367
  0064225784367
  0225784367
]

result = numbers.map do |number|
  number = number.sub(/^[0+]*(64+|\b)/, '64')
  Phony.normalize(number)
end

puts result
