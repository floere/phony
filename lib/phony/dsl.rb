module Phony

  # For country definitions.
  #
  # There are two styles: With or without block.
  # Use the block if you have multiple.
  #
  # Examples:
  # Phony.define do
  #   country ...
  # end
  #
  # Phony.define.country ...
  #
  def self.define
    dsl = DSL.new
    dsl.instance_eval(&Proc.new) if block_given?
    dsl
  end

  # Contains a number of DSL methods. Is used e.g. in the countries.rb file.
  #
  # Do not use directly, but instead use {Phony.define} to execute a block
  # in the DSL instance's context.
  #
  # @example
  #   Phony.define { ... }
  #
  class DSL

    # Define a country's rules.
    #
    # Use the other DSL methods to define the country's rules.
    #
    # @param [String] country_code The country code of the country.
    # @param [Phony::CountryCodes] definition Rules for this country.
    #
    # @return Undefined.
    #
    # @example Add a country with country code 27.
    #   country '27', # CC, followed by rules, for example fixed(2) >> ...
    #
    def country country_code, definition, options = {}
      return unless Phony.config.load?(country_code)
      
      definition.with country_code, options
      Phony::CountryCodes.instance.add country_code, definition
    end
    
    # Designates a country code as reserved.
    # A reserved country will result in an exception when trying to be used.
    #
    # @param [String] country_code The country code of the country.
    #
    # @return nil
    #
    # @example Designate country code 27 as reserved.
    #   reserved('27')
    #
    def reserved country_code
      # Does nothing, will just fail with an exception.
    end
    
    # Define a country to use default rules (and to be done at some point).
    #
    # @return Rules for a country.
    #
    # @example Define country 27 to use default rules.
    #   country '27', todo
    #
    def todo
      none >> split(10)
    end
    
    # This country uses a trunk code.
    #
    # @param [String] code The trunk code.
    # @param [Hash] options Options hash. Pass :normalize (true/false) to indicate whether it needs to be normalized.
    #
    # @return TrunkCode A trunk code handler.
    #
    # @example Hungary uses 06.
    #   country '36', trunk('06', normalize: false) | ...
    #
    # @example North America uses 1.
    #   country '1', trunk('1%s', normalize: true) | ...
    #
    # @example Most countries which use a trunk code use 0. E.g. Romania.
    #   country '40', trunk('0') | ...
    #
    def trunk code, options = {}
      TrunkCode.new code, options
    end

    # National matcher & splitters.
    #

    # By default, a fixed length NDC
    # uses a zero prefix when formatted
    # with format :national.
    #
    # @param [Fixnum] length The length of the fixed length NDC.
    # @param [Hash] options An options hash (set zero: false to not add a zero on format :national).
    #
    # @return NationalSplitters::Fixed A fixed length national splitter.
    #
    # @example France. Uses a fixed NDC of size 1.
    #   country '33', fixed(1) >> split(2,2,2,2)
    #
    def fixed length, options = {}
      options[:zero] = true if options[:zero].nil?
      NationalSplitters::Fixed.instance_for length, options
    end
    
    # Marks the country as not using an NDC. This rule will always match.
    #
    # @return NationalSplitters::None A no-ndc national splitter.
    #
    # @example Denmark, Norway, Iceland.
    #
    def none
      NationalSplitters::None.instance_for
    end
    
    # If you have a number of (possibly) variable length NDCs
    # that cannot be well expressed via regexp, use this.
    #
    # @param [Array<String>] ndcs A list of NDCs of variable length. Can contain :max_length => number to denote a maximum NDC length.
    #
    # @return NationalSplitters::Variable A variable size national splitter.
    #
    # @example With two NDCs
    #   country '51',
    #     # If it's either 103 or 105, then split ...
    #     one_of('103', '105') >> split(3,3)
    #
    def one_of *ndcs
      options = Hash === ndcs.last ? ndcs.pop : {}

      # Ruby 1.8 compatibility mode.
      #
      ndcs = ndcs.first if Array === ndcs.first

      NationalSplitters::Variable.new options[:max_length], ndcs.map(&:freeze)
    end
    
    # If you have a number of (possibly) variable length NDCs
    # that can be well expressed via regexp, use this.
    #
    # @param [Regexp] regex A Regexp describing the NDCs (First group must contain the NDC, eg. /^(0\d{2})\d+$/) contains all NDCs with 0xx...
    #
    # @return NationalSplitters::Regex A regexp-based national splitter.
    #
    # @example With several NDC matchers.
    #   country '52',
    #     match(/^(0\d{2})\d+$/)   >> split(2,2,2,2) |
    #     match(/^(33|55|81)\d+$/) >> split(2,2,2,2) |
    #     match(/^(\d{3})\d+$/)    >> split(3,2,2)
    #
    def match regex, options = {}
      # Check if regexp has a group in it.
      #
      raise "Regexp /#{regex.source}/ needs a group in it that defines which digits belong to the NDC." unless regex.source =~ /\(/
      
      NationalSplitters::Regex.instance_for regex, options[:on_fail_take], options
    end

    # Local splitters.
    #

    # Splits the number into groups of given sizes.
    #
    # Also takes ranges.
    #
    # @param [Array<Fixnum>] local The local group sizes to split the local number part into.
    #
    # @return LocalSplitters::Fixed A fixed size local splitter.
    #
    # @example Splitting in 4 even groups of two digits.
    #   match(/^(0\d{2})\d+$/) >> split(2,2,2,2) # If it matches, split in 4 groups of size 2.
    #
    def split *local
      # local << local.pop + 10 # Allow for call-through numbers with an arbitrary size.
      LocalSplitters::Fixed.instance_for local
    end
    
    # Matches on the rest of the number and splits according
    # to the given value for the regexp key.
    #
    # Also takes ranges.
    #
    # @param [Hash] options Can contain option :fallback A fallback amount of group sizes in case it doesn't match.
    #
    # @return LocalSplitters::Regex A regexp-based local splitter.
    #
    # @example Norway
    #   country '47',
    #     none >> matched_split(/^[1].*$/   => [3],
    #                           /^[489].*$/ => [3,2,3],
    #                           :fallback   => [2,2,2,2])
    #
    def matched_split options = {}
      LocalSplitters::Regex.instance_for options
    end
    
    # Validators
    #
    
    # Which NDCs are explicitly invalid?
    #
    # @param [Regexp, String] ndc A regexp or a string of invalid NDCs.
    #
    # @return Validators::NDC An NDC validator 
    #
    # @example NANP
    #   country '1',
    #     fixed(3, :zero => false) >> split(3,4),
    #     invalid_ndcs('911') # The regexp /911/ would also work.
    #
    def invalid_ndcs *ndc
      Validators::NDC.new invalid: ndc
    end


  end

end
