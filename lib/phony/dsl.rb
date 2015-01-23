# # Switzerland (simplified):
# #
# country('41', fixed(2) >> local([3,2,2]))
#
# # Germany. Too big, we use a separate file:
# #
# Phony.define do
#   country '49', match(...) >> split([...]) ||
#                 one_of([...], :max_length => 5) >> split([...])
# end
#
# # Denmark:
# #
# country('45', none >> split([2,2,2,2]))
#
# # Hungary:
# #
# country('36',
#         match(/^104|105|107|112/) >> split([3,3]) ||
#         one_of([1], :max_length => 2) >> split([3,4])
# )
#
# Note: Perhaps the DSL should operate directly on country codes.
#
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

  class DSL

    # Start defining a country.
    #
    # Example:
    #   country '27', # CC, followed by rules, for example fixed(2) >> ...
    #
    def country country_code, definition, options = {}
      definition.with country_code, options
      Phony::CountryCodes.instance.add country_code, definition
    end
    
    # Designates a country code as reserved.
    #
    def reserved country_code
      # Does nothing, will just fail with an exception.
    end
    
    # This country still uses a default NDC (and needs to be done, hence the todo).
    #
    def todo
      none >> split(10)
    end
    
    # This country uses a trunk code.
    #
    # Examples:
    #  * Hungary uses 06.
    #  * North America uses 1.
    #  * Most countries which use a trunk code use 0.
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
    # Options:
    #  * length: Length of the fixed length NDC.
    #  * options: Set :zero to false to not add a zero on format :national.
    #
    # Example:
    #   # France, uses a fixed NDC of size 1.
    #   country '33', fixed(1) >> split(2,2,2,2)
    #
    def fixed length, options = {}
      options[:zero] = true if options[:zero].nil?
      NationalSplitters::Fixed.instance_for length, options
    end
    
    # This country does not use an NDC. This rule will always match.
    #
    # Examples:
    #   * Denmark
    #   * Norway
    #   * Iceland
    #   (and more)
    #
    def none
      NationalSplitters::None.instance_for
    end
    
    # If you have a number of (possibly) variable length NDCs
    # that cannot be well expressed via regexp, use this.
    #
    # Parameters:
    #   * ndcs A list of ndcs of variable length.
    #   * Can contain :max_length => number to denote a maximum NDC length.
    #
    # Example:
    #   country '51',
    #     # If it's either 103 or 105, then split ...
    #     one_of('103', '105') >> split(3,3)
    #
    def one_of *ndcs
      options = Hash === ndcs.last ? ndcs.pop : {}

      # Ruby 1.8 compatibility mode.
      #
      ndcs = ndcs.first if Array === ndcs.first

      NationalSplitters::Variable.new options[:max_length], ndcs
    end
    
    # If you have a number of (possibly) variable length NDCs
    # that can be well expressed via regexp, use this.
    #
    # Parameters:
    #   * regex A regexp describing the NDCs (First group must contain the NDC, eg. /^(0\d{2})\d+$/) contains all NDCs with 0xx...
    #
    # Example:
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
    # Example:
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
    # Options:
    #   * fallback A fallback amount of group sizes in case it doesn't match.
    #
    # Example:
    #   # Norway
    #   country '47',
    #     none >> matched_split(/^[1].*$/   => [3],
    #                           /^[489].*$/ => [3,2,3],
    #                           :fallback   => [2,2,2,2])
    #
    def matched_split options = {}
      Phony::LocalSplitters::Regex.instance_for options
    end
    
    # Validators
    #
    
    # Which NDCs are explicitly invalid?
    #
    # Takes a regexp or a string.
    #
    # Example:
    #   country '1',
    #     fixed(3, :zero => false) >> split(3,4),
    #     invalid_ndcs('911') # The regexp /911/ would also work.
    #
    def invalid_ndcs *ndc
      Validators::NDC.new invalid: ndc
    end


  end

end
