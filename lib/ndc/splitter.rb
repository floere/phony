# Splits a national number into a fixed size NDC and rest.
#
module E164
  module NDC
    class Splitter
      
      def self.local(*split_sizes)
        @split_sizes = split_sizes.flatten
        format((['%s']*@split_sizes.size).join(' '))
      end
      
      # Define a format for the country's local format, converting spaces to non breaking spaces
      #
      def self.format(format)
        @format ||= format.gsub(/ /, ' ')
        @format_with_ndc = '%s ' + @format
      end
      
      def self.split(number)
        ndc_part = split_ndc(number)
        ndc_part + split_local(ndc_part.pop)
      end
      
      # Formats the given E164 Number according to the country specific format / ndcs splitting.
      #
      def self.formatted(number)
        @format % split(number)
      end
      
      def self.locally_formatted(local_number)
        @format % split_local(local_number)
      end
      
      def self.split_local(number)
        local = []
        @split_sizes.each do |size|
          local << number.slice!(0..size-1)
          break if number.empty?
        end
        local
      end
      
    end
  end
end