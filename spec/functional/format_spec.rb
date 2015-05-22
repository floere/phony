require 'spec_helper'

# This is a very helpful page for phone number formatting:
# http://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers 
#
describe 'Phony#format' do

  describe 'cases' do
    describe 'Exceptions' do
      it 'raises on nil' do
        expect {
          Phony.format nil
        }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.format(number).')
      end
    end
    
    describe 'Templates' do
      it 'handles a basic template correctly' do
        Phony.format('41443643532', :format => 'A%{cc}B%{trunk}C%{ndc}D%{local}').should eql 'A41B0C44D364 35 32'
      end
      it 'handles a funky template correctly' do
        Phony.format('41443643532', :format => '%{local} %{ndc} %{trunk} %{cc}', :local_spaces => '').should eql '3643532 44 0 41'
      end
      it 'handles local_spaces correctly' do
        Phony.format('41443643532', :format => 'A%{cc}B%{ndc}C%{local}', :local_spaces => '/').should eql 'A41B44C364/35/32'
      end
      it 'handles a Russian example correctly' do
        # https://github.com/floere/phony/issues/214
        Phony.format('71234567890', :format => '+%{cc} (%{trunk}%{ndc}) %{local}', :local_spaces => '-').should eql '+7 (8123) 45-67890'
      end
      it 'handles an American example correctly' do
        Phony.format('13015550100', :format => '+%{cc} %{trunk}%{ndc} %{local}', :local_spaces => '-').should eql '+1 301 555-0100'
      end
    end
    
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
    
    describe 'Austria' do
      it { Phony.format('43198110').should eql '+43 1 98110' }
      it { Phony.format('43198110', :format => :international).should eql '+43 1 98110' }
      it { Phony.format('43198110', :format => :international_absolute).should eql '+43 1 98110' }
      it { Phony.format('43198110', :format => :international_relative).should eql '0043 1 98110' }
      it { Phony.format('43198110', :format => :international, :spaces => '').should eql '+43198110' }
      it { Phony.format('43198110', :format => :international_absolute, :spaces => '').should eql '+43198110' }
      it { Phony.format('43198110', :format => :international_relative, :spaces => '').should eql '0043198110' }
      it { Phony.format('43198110', :format => :international, :spaces => :-).should eql '+43-1-98110' }
      it { Phony.format('43198110', :format => :international_absolute, :spaces => :-).should eql '+43-1-98110' }
      it { Phony.format('43198110', :format => :international_relative, :spaces => :-).should eql '0043-1-98110' }
      it { Phony.format('43198110', :format => :national).should eql '01 98110' }
    end
    describe 'Denmark' do
      it { Phony.format('4540506070', format: :national).should eql '40 50 60 70' }
    end
    describe 'France' do
      it { Phony.format('33142278186', :format => :+).should eql '+33 1 42 27 81 86' }
      it { Phony.format('33142278186', :format => :+, :spaces => '').should eql '+33142278186' }
      it { Phony.format('33142278186', :format => :+, :spaces => :-).should eql '+33-1-42-27-81-86' }
    end
    describe 'India' do
      it { Phony.format('914433993939').should eql '+91 44 339 93 939' }
    end
    describe 'Italy' do
      it { Phony.format('393333337647', :format => :international).should eql '+39 333 333 7647' }
      it { Phony.format('390108480161', :format => :international).should eql '+39 010 8480161' }
      it { Phony.format('393333337647', :format => :national).should eql '333 333 7647' }
      it { Phony.format('390108480161', :format => :national).should eql '010 8480161' }
    end
    describe 'Liechtenstein' do
      it { Phony.format('4233841148', :format => :international_relative).should eql '00423 384 11 48' }
      it { Phony.format('4233841148', :format => :international_relative, :spaces => '').should eql '004233841148' }
      it { Phony.format('4233841148', :format => :international_relative, :spaces => :-).should eql '00423-384-11-48' }
    end
    describe 'NANP' do
      it { Phony.format('18705551122').should eql '+1 (870) 555-1122' }
      it { Phony.format('18091231234', :format => :international).should eql '+1 (809) 123-1234' }
      it { Phony.format('18091231234', :format => :international, :spaces => '').should eql '+1(809)123-1234' }
      it { Phony.format('18091231234', :format => :international, :spaces => :-).should eql '+1-(809)-123-1234' }
      # Does not show a trunk code by default on national level.
      it { Phony.format('14152223333', :format => :national).should eql '(415) 222-3333' }
      it { Phony.format('14159224711', :format => :national).should eql '(415) 922-4711' }
      # With forced trunk option.
      it { Phony.format('14159224711', :format => :national, :trunk => true).should eql '1 (415) 922-4711' }
      it { Phony.format('14159224711', :format => :national, :trunk => false).should eql '(415) 922-4711' }
      # With forced parentheses option.
      it { Phony.format('14159224711', :format => :national, :parentheses => true).should eql '(415) 922-4711' }
      it { Phony.format('14159224711', :format => :national, :parentheses => false).should eql '415 922-4711' }
    end
    describe 'Netherlands' do
      it { Phony.format('311012341234', :format => :national).should eql '010 123 41234' }
      # With forced trunk.
      it { Phony.format('311012341234', :format => :national, :trunk => true).should eql '010 123 41234' }
    end
    describe 'New Zealand' do
      it { Phony.format('6421123456').should eql '+64 21 123 456' }
      it { Phony.format('64211234567').should eql '+64 21 123 4567' }
      it { Phony.format('642112345678').should eql '+64 21 12 345 678' }
      it { Phony.format('6493791234').should eql '+64 9 379 1234' }
    end
    describe 'Russia' do
      it { Phony.format(Phony.normalize('+370 800 12345'), :format => :international).should eql '+370 800 12 345' }
      it { Phony.format(Phony.normalize('+7 812 123 4567'), :format => :international).should eql '+7 812 123-45-67' }
      it { Phony.format(Phony.normalize('+370 800 12345'), :format => :national).should eql '8800 12 345' }
      it { Phony.format(Phony.normalize('+7 812 123 4567'), :format => :national).should eql '8812 123-45-67' }
    end
    describe 'Switzerland' do
      it { Phony.format('41443643532').should eql '+41 44 364 35 32' }
      it { Phony.format('41443643532', :format => :national).should eql '044 364 35 32' }
      it { Phony.format('41800112233').should eql '+41 800 112 233' }
      it { Phony.format('41443643532', :format => :international).should eql '+41 44 364 35 32' }
      it { Phony.format('41443643532', :format => :national).should eql '044 364 35 32' }
      it { Phony.format('41800112233', :format => :national).should eql '0800 112 233' }
      it { Phony.format('41443643532', :format => :local).should eql '364 35 32' }
      it { Phony.format('493038625454', :format => :local).should eql '386 25454' }
    end
    describe 'yet unsupported' do
      # formats as a single block
      it { Phony.format('88132155605220').should eql '+881 32155605220' }
      # formats as a single block, regardless of format
      it { Phony.format('8811819372205', :format => :international).should eql '+881 1819372205' }
      # formats as a single block, respecting custom spaces
      it { Phony.format('8811819372205', :spaces => :-).should eql '+881-1819372205' }
      # formats as a single block, even without spaces
      it { Phony.format('8811819372205', :spaces => '').should eql '+8811819372205' }
    end

  end
  
  describe 'formatted' do
    it 'is an alias of format' do
      Phony.formatted('41443643532').should eql '+41 44 364 35 32'
    end
  end

end
