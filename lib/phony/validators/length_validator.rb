module Phony
  class LengthValidator

    attr_reader :length

    def initialize length
      @length = length
    end

    def plausible? ndc, rest
      numbers = if ndc
                  [ndc, rest].flatten
                else
                  rest.flatten
                end
      return false if numbers.join('').length != @length
      true
    end

  end
end

