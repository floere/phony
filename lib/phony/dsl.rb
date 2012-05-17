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
    dsl.instance_eval &Proc.new if block_given?
    dsl
  end

  class DSL

    #
    #
    def country country_code, country, validator = nil
      Phony::CountryCodes.instance.add country_code, country
      Phony::Validators.instance.add country_code, validator if validator
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
    def fixed length, options = {}
      options[:zero] = true if options[:zero].nil?
      NationalSplitters::Fixed.instance_for length, options
    end
    def none
      NationalSplitters::None.instance_for
    end
    def one_of *ndcs
      options = Hash === ndcs.last ? ndcs.pop : {}

      # Ruby 1.8 compatibility mode.
      #
      ndcs = ndcs.first if Array === ndcs.first

      NationalSplitters::Variable.new options[:max_length], ndcs
    end
    def match regex, options = {}
      on_fail_take = options.delete :on_fail_take
      NationalSplitters::Regex.instance_for regex, options[:on_fail_take], options
    end
    def todo
      none >> NationalSplitters::Default.instance_for
    end

    # Local splitters.
    #

    #
    #
    def split *local
      local << local.pop + 10 # Allow for call-through numbers with an arbitrary size.
      LocalSplitters::Fixed.instance_for local
    end
    def matched_split options = {}
      Phony::LocalSplitters::Regex.instance_for options
    end
    
    # Validators
    #
    def invalid_ndcs ndc
      Validator.new.ndc_check ndc
    end

  end

end
