require 'spec_helper'

# This is a very helpful page for phone number formatting:
# http://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers 
#
describe 'Phony#format' do
  
  describe 'cases' do
    
    def self.for_each_from tsv_file_name
      require 'csv'
      describe "from file #{tsv_file_name}" do
        CSV.open(tsv_file_name, headers: true, col_sep: "\t").each.with_index do |row, index|
          country, expected, original, format, spaces, local_spaces = *row.
            values_at('Country', 'Expected', 'Original', 'Format', 'Spaces', 'Local Spaces')
          options = {}
          options[:format] = format.to_sym if format
          options[:spaces] = spaces.to_sym if spaces
          it "(row #{index + 2}) #{country}: #{expected} from #{original} with #{format}, #{spaces}, #{local_spaces}" do
            Phony.format(original, options).should eql expected
          end
        end
      end
    end
    
    # Countries.
    #
    for_each_from 'spec/functional/format.tab'

  end
  
end
