module Phony
  class LengthValidator

    attr_accessor :lenghts

    # takes either a number (for fixed length phone numbers) or
    # a hash where the key is the length of the ndc and the value the corresponding
    # length
    def initialize lengths
      if lengths.is_a? Hash
        @lengths = lengths
      else
        @lengths = Hash.new lengths
      end
    end

    def plausible? ndc, rest
      numbers = if ndc
                  [ndc, rest].flatten
                else
                  rest.flatten
                end
      ndc_length = ndc.length rescue 0  # if the ndc is false (example Denamrk), use 0
      lengths = [*@lengths[ndc_length]]  # we can have one or more lengths, make them into an array
      return false unless lengths.include? numbers.join('').length
      true
    end

  end
end

