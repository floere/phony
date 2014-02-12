# encoding: utf-8
#
require 'spec_helper'

describe Phony do

  describe 'OO interface' do
    describe '[]' do
      it '' do
        us = described_class['1']
        expect(us.plausible?('4159224711')).to be true
        expect(us.countrify!('4159224711')).to eq('14159224711')
      end
    end
  end

  describe 'normalize' do
    describe 'exceptions' do
      it 'raises on nil' do
        expect {
          Phony.normalize nil
        }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.normalize(number).')
      end
      it 'raises a nice error message' do
        expect do
          Phony.normalize 'test'
        end.to raise_error(Phony::NormalizationError, 'Phony could not normalize the given number. Is it a phone number?')
      end
    end
    describe 'some examples' do
      it 'should normalize a too short number' do
        expect(Phony.normalize('+972')).to eq('972')
      end
      it 'should normalize an already normalized number' do
        expect(Phony.normalize('41443643533')).to eq('41443643533')
      end
      it 'should normalize a format number' do
        expect(Phony.normalize('+41 44 364 35 33')).to eq('41443643533')
      end
      it 'should normalize a 00 number' do
        expect(Phony.normalize('0041 44 364 35 33')).to eq('41443643533')
      end
      it 'should normalize a service number' do
        expect(Phony.normalize('+41 800 11 22 33')).to eq('41800112233')
      end
      it 'should remove characters from the number' do
        expect(Phony.normalize('John: +41 44 364 35 33')).to eq('41443643533')
      end
      it 'should normalize one of these crazy american numbers' do
        expect(Phony.normalize('1 (703) 451-5115')).to eq('17034515115')
      end
      it 'should normalize another one of these crazy american numbers' do
        expect(Phony.normalize('1-888-407-4747')).to eq('18884074747')
      end
      it 'should normalize a number with colons' do
        expect(Phony.normalize('1.906.387.1698')).to eq('19063871698')
      end
      it 'should normalize a number with optional ndc' do
        expect(Phony.normalize('+41 (044) 364 35 33')).to eq('41443643533')
      end
      it 'should normalize a number with erroneous zero inside' do
        expect(Phony.normalize('+410443643533')).to eq('41443643533')
      end
      it 'should not normalize a number with a correct zero inside' do
        expect(Phony.normalize('+390909709511')).to eq('390909709511')
      end

      context 'special trunk prefixes' do
        it 'normalizes Hungary' do
          expect(Phony.normalize('36 0630245506')).to eq('3630245506')
        end
        it 'normalizes Russia' do
          expect(Phony.normalize('7 8 342 1234567')).to eq('73421234567')
        end
        it 'normalizes Lithuania' do
          expect(Phony.normalize('370 8 5 1234567')).to eq('37051234567')
        end
        it 'normalizes Belarus' do
          expect(Phony.normalize('375 152450911')).to eq('375152450911')
        end
      end
    end
    describe 'country-based' do
      it 'normalizes the US correctly' do
        expect(Phony["1"].normalize("555 1234567890")).to eq('15551234567890')
        expect(Phony["1"].normalize("+1 555 1234567890")).to eq('15551234567890')
        expect(Phony["1"].normalize("+1 (0) 555 1234567890")).to eq('15551234567890')
      end
      it 'normalizes Japan correctly' do
        expect(Phony["81"].normalize("80 1234 5634")).to eq('818012345634')
        expect(Phony["81"].normalize("+81 80 1234 5634")).to eq('818012345634')
      end
    end
  end

  describe 'formatted' do
    it 'is an alias of format' do
      expect(Phony.formatted('41443643532')).to eq('+41 44 364 35 32')
    end
  end

  describe 'format' do
    describe 'exceptions' do
      it 'raises on nil' do
        expect {
          Phony.format nil
        }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.format(number).')
      end
    end
    describe 'default' do
      it 'should format swiss numbers' do
        expect(Phony.format('41443643532')).to eq('+41 44 364 35 32')
      end
      # TODO
      #
      it 'should format swiss service numbers' do
        expect(Phony.format('41800112233')).to eq('+41 800 112 233')
      end
      it 'should format austrian numbers' do
        expect(Phony.format('43198110')).to eq('+43 1 98110')
      end
      it 'should format american numbers' do
        expect(Phony.format('18705551122')).to eq('+1 870 555 1122')
      end
      it 'should format New Zealand 021 mobile numbers' do
        expect(Phony.format('64211234567')).to eq('+64 21 123 4567')
      end
      it 'should format New Zealand landline numbers' do
        expect(Phony.format('6493791234')).to eq('+64 9 379 1234')
      end
      it 'should format Indian numbers' do
        expect(Phony.format('914433993939')).to eq('+91 44 339 93 939')
      end
    end
    describe 'international' do
      it 'should format north american numbers' do
        expect(Phony.format('18091231234', :format => :international)).to eq('+1 809 123 1234')
      end
      it 'should format austrian numbers' do
        expect(Phony.format('43198110', :format => :international)).to eq('+43 1 98110')
      end
      it 'should format austrian numbers' do
        expect(Phony.format('43198110', :format => :international_absolute)).to eq('+43 1 98110')
      end
      it 'should format french numbers' do
        expect(Phony.format('33142278186', :format => :+)).to eq('+33 1 42 27 81 86')
      end
      it 'should format austrian numbers' do
        expect(Phony.format('43198110', :format => :international_relative)).to eq('0043 1 98110')
      end
      it 'should format liechtensteiner numbers' do
        expect(Phony.format('4233841148', :format => :international_relative)).to eq('00423 384 11 48')
      end
      context 'with no spaces' do
        it 'should format north american numbers' do
          expect(Phony.format('18091231234', :format => :international, :spaces => '')).to eq('+18091231234')
        end
        it 'should format austrian numbers' do
          expect(Phony.format('43198110', :format => :international, :spaces => '')).to eq('+43198110')
        end
        it 'should format austrian numbers' do
          expect(Phony.format('43198110', :format => :international_absolute, :spaces => '')).to eq('+43198110')
        end
        it 'should format french numbers' do
          expect(Phony.format('33142278186', :format => :+, :spaces => '')).to eq('+33142278186')
        end
        it 'should format austrian numbers' do
          expect(Phony.format('43198110', :format => :international_relative, :spaces => '')).to eq('0043198110')
        end
        it 'should format liechtensteiner numbers' do
          expect(Phony.format('4233841148', :format => :international_relative, :spaces => '')).to eq('004233841148')
        end
      end
      context 'with special spaces' do
        it 'should format swiss numbers' do
          expect(Phony.format('41443643532', :format => :international)).to eq('+41 44 364 35 32')
        end
        it 'should format north american numbers' do
          expect(Phony.format('18091231234', :format => :international, :spaces => :-)).to eq('+1-809-123-1234')
        end
        it 'should format austrian numbers' do
          expect(Phony.format('43198110', :format => :international, :spaces => :-)).to eq('+43-1-98110')
        end
        it 'should format austrian numbers' do
          expect(Phony.format('43198110', :format => :international_absolute, :spaces => :-)).to eq('+43-1-98110')
        end
        it 'should format french numbers' do
          expect(Phony.format('33142278186', :format => :+, :spaces => :-)).to eq('+33-1-42-27-81-86')
        end
        it 'should format austrian numbers' do
          expect(Phony.format('43198110', :format => :international_relative, :spaces => :-)).to eq('0043-1-98110')
        end
        it 'should format liechtensteiner numbers' do
          expect(Phony.format('4233841148', :format => :international_relative, :spaces => :-)).to eq('00423-384-11-48')
        end
      end
      describe "'unsupported' countries" do
        it 'should format as a single block' do
          expect(Phony.format('88132155605220')).to eq('+881 32155605220')
        end
        it 'should format as a single block, regardless of format' do
          expect(Phony.format('8811819372205', :format => :international)).to eq('+881 1819372205')
        end
        it 'should format as a single block, respecting custom spaces' do
          expect(Phony.format('8811819372205', :spaces => :-)).to eq('+881-1819372205')
        end
        it 'should format as a single block, even without spaces' do
          expect(Phony.format('8811819372205', :spaces => '')).to eq('+8811819372205')
        end
      end
    end
    describe 'national' do
      it 'should format swiss numbers' do
        expect(Phony.format('41443643532', :format => :national)).to eq('044 364 35 32')
      end
      # TODO
      #
      it 'should format swiss service numbers' do
        expect(Phony.format('41800112233', :format => :national)).to eq('0800 112 233')
      end
      it 'should format austrian numbers' do
        expect(Phony.format('43198110', :format => :national)).to eq('01 98110')
      end
      it 'should format US numbers without a leading zero' do
        expect(Phony.format('14159224711', :format => :national)).to eq('415 922 4711')
      end
    end
    describe 'local' do
      it 'should format swiss numbers' do
        expect(Phony.format('41443643532', :format => :local)).to eq('364 35 32')
      end
      it 'should format german numbers' do
        expect(Phony.format('493038625454', :format => :local)).to eq('386 25454')
      end
    end
  end

  context 'minimal cases' do
    context 'normalizing' do
      it "handles completely crazy 'numbers'" do
        expect(Phony.normalize('Hello, I am Cora, the 41th parrot, and 044 is my 364 times 35 funky number. 32.')).to eq('41443643532')
      end
    end
    context 'splitting' do
      describe 'exceptions' do
        it 'should raise on split nil' do
          expect {
            Phony.split nil
          }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.split(number).')
        end
      end
      it 'handles completely missing numbers well enough' do
        expect(Phony.split('4144')).to eq(['41', '44', ''])
      end
      it 'handles a missing number part' do
        expect(Phony.split('4144364')).to eq(['41', '44', '364'])
      end
      it 'handles a missing number part' do
        expect(Phony.split('414436435')).to eq(['41', '44', '364', '35'])
      end
    end
    context 'formatting' do
      it 'handles completely missing numbers well enough' do
        expect(Phony.format('4144')).to eq('+41 44 ')
      end
      it 'handles a missing number part' do
        expect(Phony.format('4144364')).to eq('+41 44 364')
      end
      it 'handles a missing number part' do
        expect(Phony.format('414436435')).to eq('+41 44 364 35')
      end
    end
    context "'unsupported' countries" do
      it 'handles formatting' do
        expect(Phony.format('88132155605220')).to eq('+881 32155605220')
      end
      it 'handles normalizing' do
        expect(Phony.normalize('+881-321 5560 5220')).to eq('88132155605220')
      end
    end
  end

  context 'speed' do
    before(:each) do
      @phone_numbers = [
        '41443643532',
        '18091231234',
        '43198110',
        '33142278186',
        '4233841148'
      ]
    end
    describe 'split' do
      it 'is fast' do
        number = @phone_numbers.first
        expect(performance_of { Phony.split(number) }).to be < 0.00005
      end
      it 'is fast' do
        expect(performance_of { @phone_numbers.each { |number| Phony.split(number) } }).to be < 0.00015
      end
    end
    describe 'normalize' do
      it 'is fast' do
        number = @phone_numbers.first
        expect(performance_of { Phony.normalize(number) }).to be < 0.0001
      end
      it 'is fast' do
        expect(performance_of { @phone_numbers.each { |number| Phony.normalize(number) } }).to be < 0.00016
      end
    end
    describe 'format' do
      it 'is fast' do
        number = @phone_numbers.first
        expect(performance_of { Phony.format(number) }).to be < 0.000075
      end
      it 'is fast' do
        expect(performance_of { @phone_numbers.each { |number| Phony.format(number) } }).to be < 0.00016
      end
    end
  end

  describe 'vanity' do
    describe 'vanity_number?' do
      it {expect(Phony.vanity?('41800 WEGGLI')).to be true}
      it {expect(Phony.vanity?('41800WEGGLI')).to be true}
      it {expect(Phony.vanity?('41848 SUCCESSMATCH')).to be true}
      it {expect(Phony.vanity?('4180 NO NO NO')).to be false}
      it {expect(Phony.vanity?('41900 KURZ')).to be false}
      it {expect(Phony.vanity?('41 44 364 35 32')).to be false}
    end

    describe 'vanity_to_number' do
      it {expect(Phony.vanity_to_number('41800WEGGLI')).to eq('41800934454')}
      it {expect(Phony.vanity_to_number('41800weggli')).to eq('41800934454')}
      # it {Phony.vanity_to_number('41800SUCCESSMATCH').should == '41800782237'} # Cut off according to the swiss norms.
      it {expect(Phony.vanity_to_number('41800SUCCESSMATCH')).to eq('41800782237762824')} # Allow for call-through numbers (>= 1.6.0)
      it {expect(Phony.vanity_to_number('4180BLA')).to eq('4180252')} # Does not check for validity of number.
    end
  end

end
