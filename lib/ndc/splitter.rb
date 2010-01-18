# Splits a national number into a fixed size NDC and rest.
#
module E164
  module NDC
    class Splitter
            
      # Sets the local grouping format.
      #
      # Examples
      # * local 3, 2, 2     # Switzerland, 364 35 33, thus: 3-2-2.
      # * local 2, 2, 2, 2  # France, 12 34 56 78, thus: 2-2-2-2.
      #
      def self.local *split_sizes
        @split_sizes = split_sizes.flatten
        format((['%s']*@split_sizes.size).join('%s'))
      end
      
      # Define a format for the country's local format.
      #
      # Examples
      # * format '%s%s%s%s%s' # Switzerland, spaces between the groups, e.g. 364˽35˽32
      #
      def self.format format
        @format = format
        @format_with_ndc = ndc_format + @format
      end
      
      # Define a format for the country's national format.
      #
      # Default is NN followed by a space character.
      #
      def self.ndc_format
        '%s%s'
      end
      
      # Split an E164 number without country code into its NDC-Local parts.
      #
      # Examples
      # * split '443643533' # => ['44', '364', '35', '33'] # (Switzerland)
      #
      def self.split number
        ndc_part = split_ndc(number)
        [ndc_part, split_local(ndc_part.pop)].flatten
      end
      
      # Split a local number according to an assumed country specific format.
      #
      # Examples
      # * split '3643533' # => ['364', '35', '33'] # (Switzerland)
      #
      def self.split_local number
        local = []
        @split_sizes.each do |size|
          local << number.slice!(0..size-1)
          break if number.empty?
        end
        local
      end
      
      # Formats the given E164 Number (NDC-Local without CC) according to the country specific format / ndcs splitting.
      #
      def self.formatted number, space = ' '
        formatted_with_spaces @format_with_ndc, split(number), space
      end
      
      # Formats the given local number according to the country specific format.
      #
      def self.locally_formatted number, space = ' '
        formatted_with_spaces @format, split_local(number), space
      end
      
      def self.formatted_with_spaces format, split_number, space
        space ||= ' '
        number_and_spaces = (split_number).zip([space]*split_number.size).flatten
        format % number_and_spaces
      end
      
    end
    
  end
end