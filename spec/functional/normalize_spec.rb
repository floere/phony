require 'spec_helper'

describe 'Phony#normalize' do

  describe 'cases' do

    describe 'regressions' do
      it '#151' do
        # Normalizes, but this is a non-real case.
        #
        Phony.normalize('1-111-111-1111').should        eql '1111111111'
        Phony.normalize('111-111-1111', cc: '1').should eql '1111111111'
      end
    end

    it 'handles the US (with cc) correctly' do
      Phony.normalize('+1 724 999 9999').should eql '17249999999'
    end
    it 'handles the Dutch number (without US cc) correctly' do
      Phony.normalize('310 5552121').should eql '315552121'
    end
    it 'handles the US (with cc and cc option) correctly' do
      Phony.normalize('+1 724 999 9999', cc: '1').should eql '17249999999'
    end
    it 'handles the US (without cc) correctly' do
      Phony.normalize('(310) 555-2121', cc: '1').should eql '13105552121'
    end
    it 'handles a German number with extra (0)' do
      Phony.normalize('+49 (0) 209 22 33 44 55').should eql '4920922334455'
    end
    it 'handles a German number with extra 0' do
      Phony.normalize('+49 0 209 22 33 44 55').should eql '4920922334455'
    end
    it 'handles Cambodian numbers with an extra 0' do
      Phony.normalize('+855012239134').should eql "85512239134"
    end
    it 'should normalize a too short number' do
      Phony.normalize('+972').should eql '972'
    end
    it 'should normalize an already normalized number' do
      Phony.normalize('41443643533').should eql '41443643533'
    end
    it 'should normalize a format number' do
      Phony.normalize('+41 44 364 35 33').should eql '41443643533'
    end
    it 'should normalize a 00 number' do
      Phony.normalize('0041 44 364 35 33').should eql '41443643533'
    end
    it 'should normalize a service number' do
      Phony.normalize('+41 800 11 22 33').should eql '41800112233'
    end
    it 'should remove characters from the number' do
      Phony.normalize('John: +41 44 364 35 33').should eql '41443643533'
    end
    it 'should normalize one of these crazy american numbers' do
      Phony.normalize('1 (703) 451-5115').should eql '17034515115'
    end
    it 'should normalize another one of these crazy american numbers' do
      Phony.normalize('1-888-407-4747').should eql '18884074747'
    end
    it 'should normalize a number with colons' do
      Phony.normalize('1.906.387.1698').should eql '19063871698'
    end
    it 'should normalize a number with erroneous zero inside' do
      Phony.normalize('+410443643533').should eql '41443643533'
    end
    it 'should not normalize a number with a correct zero inside' do
      Phony.normalize('+390909709511').should eql '390909709511'
    end

    it "handles completely crazy 'numbers'" do
      Phony.normalize('Hello, I am Cora, the 41th parrot, and 44 is my 364 times 35 funky number. 32.').should eql '41443643532'
    end

    context 'special trunk prefixes are not handled' do
      it 'normalizes Hungary' do
        Phony.normalize('36 0630245506').should eql '360630245506'
      end
      it 'normalizes Russia' do
        Phony.normalize('7 8 342 1234567').should eql '783421234567'
      end
      it 'normalizes Lithuania' do
        Phony.normalize('370 8 5 1234567').should eql '370851234567'
      end
      it 'normalizes Belarus' do
        Phony.normalize('375 152450911').should eql '375152450911'
      end
    end

    describe 'exceptions' do
      it 'raises on nil' do
        expect {
          Phony.normalize nil
        }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.normalize(number).')
      end
      it 'raises if number starts with reserved zero code' do
        expect do
          Phony.normalize '+00 00 00 00 01'
        end.to raise_error(Phony::NormalizationError, 'Phony could not normalize the given number. Is it a phone number?')
      end
      it 'raises a nice error message' do
        expect do
          Phony.normalize 'test'
        end.to raise_error(Phony::NormalizationError, 'Phony could not normalize the given number. Is it a phone number?')
      end
    end

    describe 'country-based' do
      it 'normalizes the US correctly' do
        Phony["1"].normalize("555 1234567890").should eql '5551234567890'
        Phony["1"].normalize("+1 555 1234567890").should eql '5551234567890'
        Phony["1"].normalize("+1 (0) 555 1234567890").should eql '5551234567890'
      end
      it 'normalizes Japan correctly' do
        Phony["81"].normalize("80 1234 5634").should eql '8012345634'
        Phony["81"].normalize("Hello    80 1234 5634").should eql '8012345634'
      end
    end
  end

end
