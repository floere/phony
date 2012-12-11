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
      ndc ||= ''  # handle 'false' ndc's (like Denmark)
      lengths = [*@lengths[ndc.length]]  # we can have one or more lengths, make them into an array

      length = ndc.size + rest.inject(0) { |sum, part| part ? sum + part.size : sum }

      return false unless lengths.include? length
      true
    end

  end
end

