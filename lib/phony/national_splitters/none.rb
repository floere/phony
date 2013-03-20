module Phony
  
  module NationalSplitters
    
    # This is a national splitter for countries
    # which have no NDC / Area Code.
    #
    class None < Default
      
      # Get a splitter. Caches.
      #
      def self.instance_for(*)
        @instance ||= new
      end
      
      # On false:
      #
      # This is a hack to make phony's
      # plausible method work even with
      # this splitter.
      #
      # Promise: We will rewrite this soon
      # to beautify, but making it work for
      # people in production is most important
      # right now.
      #
      # The problem is that the validation looks
      # at whether there is a NDC - if it is nil,
      # it is not plausible.
      # (Does not work with this class, of course
      # since using nil is dangerous and breaks
      # abstraction)
      #
      # Note: Actually, it might stay in.
      #
      # TODO Flip nil/false?
      #
      def split national_number
        [nil, false, national_number]
      end
      
      # A valid length.
      #
      def length
        0
      end
      
    end
    
  end
  
end