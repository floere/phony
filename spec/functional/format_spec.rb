require 'spec_helper'

describe 'Phony#format' do

  describe 'formatted' do
    it 'is an alias of format' do
      Phony.formatted('41443643532').should eql '+41 44 364 35 32'
    end
  end

  describe 'with templates' do
    it 'handles a basic template correctly' do
      Phony.format('41443643532', :format => 'A%{cc}B%{ndc}C%{local}').should eql 'A41B44C364 35 32'
    end
    it 'handles a funky template correctly' do
      Phony.format('41443643532', :format => '%{local}%{ndc}%{cc}', :local_spaces => '').should eql '36435324441'
    end
    it 'handles local_spaces correctly' do
      Phony.format('41443643532', :format => 'A%{cc}B%{ndc}C%{local}', :local_spaces => '/').should eql 'A41B44C364/35/32'
    end
    it 'handles a russian example correctly' do
      # https://github.com/floere/phony/issues/214
      Phony.format('71234567890', :format => '(+%{cc} %{ndc}) %{local}', :local_spaces => '-').should eql '(+7 123) 45-67890'
    end
  end

  describe 'cases' do

    describe 'exceptions' do
      it 'raises on nil' do
        expect {
          Phony.format nil
        }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.format(number).')
      end
    end
    describe 'default' do
      it 'should format Swiss numbers' do
        Phony.format('41443643532').should eql '+41 44 364 35 32'
      end
      it 'should format Swiss national numbers' do
        Phony.format('41443643532', :format => :national).should eql '044 364 35 32'
      end
      # TODO
      #
      it 'should format Swiss service numbers' do
        Phony.format('41800112233').should eql '+41 800 112 233'
      end
      it 'should format Austrian numbers' do
        Phony.format('43198110').should eql '+43 1 98110'
      end
      it 'should format American numbers' do
        Phony.format('18705551122').should eql '+1 870 555 1122'
      end
      it 'should format New Zealand 021 6-digit mobile numbers' do
        Phony.format('6421123456').should eql '+64 21 123 456'
      end
      it 'should format New Zealand 021 7-digit mobile numbers' do
        Phony.format('64211234567').should eql '+64 21 123 4567'
      end
      it 'should format New Zealand 021 8-digit mobile numbers' do
        Phony.format('642112345678').should eql '+64 21 12 345 678'
      end
      it 'should format New Zealand landline numbers' do
        Phony.format('6493791234').should eql '+64 9 379 1234'
      end
      it 'should format Indian numbers' do
        Phony.format('914433993939').should eql '+91 44 339 93 939'
      end
      it 'should format Russian numbers' do
        Phony.format(Phony.normalize('+370 800 12345'), :format => :international).should eql '+370 800 12 345'
      end
      it 'should format Russian numbers' do
        Phony.format(Phony.normalize('+7 812 123 4567'), :format => :international).should eql '+7 812 123-45-67'
      end
      it 'should format Russian numbers' do
        Phony.format(Phony.normalize('+370 800 12345'), :format => :national).should eql '8800 12 345'
      end
      it 'should format Russian numbers' do
        Phony.format(Phony.normalize('+7 812 123 4567'), :format => :national).should eql '8812 123-45-67'
      end
    end
    describe 'international' do
      it 'should format north american numbers' do
        Phony.format('18091231234', :format => :international).should eql '+1 809 123 1234'
      end
      it 'should format austrian numbers' do
        Phony.format('43198110', :format => :international).should eql '+43 1 98110'
      end
      it 'should format austrian numbers' do
        Phony.format('43198110', :format => :international_absolute).should eql '+43 1 98110'
      end
      it 'should format french numbers' do
        Phony.format('33142278186', :format => :+).should eql '+33 1 42 27 81 86'
      end
      it 'should format austrian numbers' do
        Phony.format('43198110', :format => :international_relative).should eql '0043 1 98110'
      end
      it 'should format liechtensteiner numbers' do
        Phony.format('4233841148', :format => :international_relative).should eql '00423 384 11 48'
      end
      context 'with no spaces' do
        it 'should format north american numbers' do
          Phony.format('18091231234', :format => :international, :spaces => '').should eql '+18091231234'
        end
        it 'should format austrian numbers' do
          Phony.format('43198110', :format => :international, :spaces => '').should eql '+43198110'
        end
        it 'should format austrian numbers' do
          Phony.format('43198110', :format => :international_absolute, :spaces => '').should eql '+43198110'
        end
        it 'should format french numbers' do
          Phony.format('33142278186', :format => :+, :spaces => '').should eql '+33142278186'
        end
        it 'should format austrian numbers' do
          Phony.format('43198110', :format => :international_relative, :spaces => '').should eql '0043198110'
        end
        it 'should format liechtensteiner numbers' do
          Phony.format('4233841148', :format => :international_relative, :spaces => '').should eql '004233841148'
        end
      end
      context 'with special spaces' do
        it 'should format swiss numbers' do
          Phony.format('41443643532', :format => :international).should eql '+41 44 364 35 32'
        end
        it 'should format north american numbers' do
          Phony.format('18091231234', :format => :international, :spaces => :-).should eql '+1-809-123-1234'
        end
        it 'should format austrian numbers' do
          Phony.format('43198110', :format => :international, :spaces => :-).should eql '+43-1-98110'
        end
        it 'should format austrian numbers' do
          Phony.format('43198110', :format => :international_absolute, :spaces => :-).should eql '+43-1-98110'
        end
        it 'should format french numbers' do
          Phony.format('33142278186', :format => :+, :spaces => :-).should eql '+33-1-42-27-81-86'
        end
        it 'should format austrian numbers' do
          Phony.format('43198110', :format => :international_relative, :spaces => :-).should eql '0043-1-98110'
        end
        it 'should format liechtensteiner numbers' do
          Phony.format('4233841148', :format => :international_relative, :spaces => :-).should eql '00423-384-11-48'
        end
      end
      describe "'unsupported' countries" do
        it 'should format as a single block' do
          Phony.format('88132155605220').should eql '+881 32155605220'
        end
        it 'should format as a single block, regardless of format' do
          Phony.format('8811819372205', :format => :international).should eql '+881 1819372205'
        end
        it 'should format as a single block, respecting custom spaces' do
          Phony.format('8811819372205', :spaces => :-).should eql '+881-1819372205'
        end
        it 'should format as a single block, even without spaces' do
          Phony.format('8811819372205', :spaces => '').should eql '+8811819372205'
        end
      end
    end
    describe 'national' do
      it 'should format swiss numbers' do
        Phony.format('41443643532', :format => :national).should eql '044 364 35 32'
      end
      # TODO
      #
      it 'should format swiss service numbers' do
        Phony.format('41800112233', :format => :national).should eql '0800 112 233'
      end
      it 'should format austrian numbers' do
        Phony.format('43198110', :format => :national).should eql '01 98110'
      end
      it 'should format US numbers with a leading trunk 1' do
        Phony.format('14159224711', :format => :national).should eql '1 415 922 4711'
      end
      it 'should format Dutch numbers with a trunk code' do
        Phony.format('311012341234', :format => :national).should eql '010 123 41234'
      end
    end
    describe 'local' do
      it 'should format swiss numbers' do
        Phony.format('41443643532', :format => :local).should eql '364 35 32'
      end
      it 'should format german numbers' do
        Phony.format('493038625454', :format => :local).should eql '386 25454'
      end
    end

  end

end
