require 'spec_helper'

describe Phony::CountryCodes do
  
  let(:countries) { Phony::CountryCodes.instance }
  
  describe '#plausible?' do
    it 'raises an error on a too long ccc' do
      expect do
        countries.plausible?('+1 868 7620266', ccc: '1868123')
      end.to raise_error(ArgumentError, %Q{The provided ccc option is too long and includes more than a cc ('1') and ndc ('868'). It also includes '123'.})
    end
  end
  
  describe 'ccc handling' do
    it 'splits a ccc correctly' do
      cc, ndc, *local = countries.split('1868')
      
      expect(cc).to eq '1'
      expect(ndc).to eq '868'
    end
    it 'splits a ccc correctly' do
      cc, ndc, *local = countries.split('1868')
      
      expect(cc).to eq '1'
      expect(ndc).to eq '868'
    end
  end
  
  describe '#[]' do
    it 'returns a country' do
      expect(countries['41'].class).to eq Phony::Country
    end
  end
  
  describe '#country_for' do
    it 'returns a country' do
      expect(countries.send(:country_for, '41').class).to eq Phony::Country
    end
  end
  
  describe '#countrify' do
    it 'returns a country' do
      expect(countries.send(:countrify, '441231212', '41')).to eq '41441231212'
    end
  end

  describe '#countrify!' do
    it 'in-place replaces the number' do
      number = '441231212'
      expect(countries.send(:countrify!, number, '41')).to eq number
      
      expect(number).to eq '41441231212'
    end
  end
  
  describe '#vanity?' do
    it 'returns true if so' do
      expect(countries.vanity?('1800HELLOES')).to eq true
    end
    it 'returns false if not' do
      expect(countries.vanity?('18001234567')).to eq false
    end
  end

  describe 'normalize' do
    it 'normalizes correctly' do
      expect(countries.normalize('0041-44-364-35-32')).to eq '41443643532'
    end
    it 'normalizes correctly with CC option' do
      expect(countries.normalize('044-364-35-32', cc: '41')).to eq '41443643532'
    end

    context 'specific countries' do
      it 'handles Congo correctly' do
        expect(countries.normalize('+242 0571 73992')).to eq '242057173992'
        expect(countries.normalize('+242 2221 15932')).to eq '242222115932'
      end
    end
  end

  describe 'formatted' do
    it 'formats correctly' do
      expect(countries.formatted('41443643532', :format => :international, :spaces => :-)).to eq '+41-44-364-35-32'
    end
    it 'formats correctly' do
      expect(countries.formatted('41443643532', :format => :international_relative, :spaces => :-)).to eq '0041-44-364-35-32'
    end
    it 'formats correctly' do
      expect(countries.formatted('41443643532', :format => :national, :spaces => :-)).to eq '044-364-35-32'
    end
    context 'specific' do
      it 'formats Ireland correctly' do
        expect(countries.formatted("3533451234", :format => :national)).to eq '0345 1234'
      end
      it 'formats Ireland correctly' do
        expect(countries.formatted("353411231234", :format => :national)).to eq '041 123 1234'
      end
      it 'formats Spain correctly' do
        expect(countries.formatted("34123456789", :format => :national)).to eq '123 456 789'
      end
      it 'formats Cambodia correctly' do
        expect(countries.formatted('85512239123', :format => :national)).to eq '012 239 123'
      end
      it 'formats the US correctly' do
        expect(countries.formatted('18005551212', :format => :national, :spaces => :-)).to eq '(800)-555-1212'
      end
      it 'formats the US correctly' do
        expect(countries.formatted('18005551212', :format => :national, :spaces => :-)).to eq '(800)-555-1212'
      end
    end

    context 'default' do
      it "should format swiss numbers" do
        expect(countries.formatted('41443643532')).to eq '+41 44 364 35 32'
      end
      it "should format swiss service numbers" do
        expect(countries.formatted('41800112233')).to eq '+41 800 112 233'
      end
      it "should format austrian numbers" do
        expect(countries.formatted('43198110')).to eq '+43 1 98110'
      end
      it "should format american numbers" do
        expect(countries.formatted('18705551122')).to eq '+1 (870) 555-1122'
      end
      it "should format irish numbers" do
        expect(countries.formatted('35311234567')).to eq '+353 1 123 4567'
      end
    end

    describe "international" do
      it "should format north american numbers" do
        expect(countries.formatted('18091231234', :format => :international)).to eq '+1 (809) 123-1234'
      end
      it "should format austrian numbers" do
        expect(countries.formatted('43198110', :format => :international)).to eq '+43 1 98110'
      end
      it "should format austrian numbers" do
        expect(countries.formatted('43198110', :format => :international_absolute)).to eq '+43 1 98110'
      end
      it "should format french numbers" do
        expect(countries.formatted('33142278186', :format => :+)).to eq '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        expect(countries.formatted('43198110', :format => :international_relative)).to eq '0043 1 98110'
      end
      it 'should format liechtensteiner numbers' do
        expect(countries.formatted('4233841148', :format => :international_relative)).to eq '00423 384 11 48'
      end
      it "should format irish numbers" do
        expect(countries.formatted('35311234567', :format => :international)).to eq '+353 1 123 4567'
      end
      it "should format luxembourgian numbers" do
        expect(countries.formatted('352222809', :format => :international)).to eq '+352 22 28 09'
      end
      it "should format luxembourgian 4-digit ndc numbers" do
        expect(countries.formatted('35226222809', :format => :international)).to eq '+352 2622 28 09'
      end
      it "should format luxembourgian mobile numbers" do
        expect(countries.formatted('352621123456', :format => :international)).to eq '+352 621 123 456'
      end
      it "should format luxembourgian city numbers" do
        expect(countries.formatted('3524123456', :format => :international)).to eq '+352 41 23 45 6'
      end
      it "should format luxembourgian machine to machine numbers" do
        expect(countries.formatted('352602112345678', :format => :international)).to eq '+352 6021 12 34 56 78'
      end
      it "should format luxembourgian numbers" do
        expect(countries.formatted('352370431', :format => :international)).to eq '+352 37 04 31'
      end
      it "should format luxembourgian numbers" do
        expect(countries.formatted('35227855', :format => :international)).to eq '+352 27 85 5'
      end
      it "should format nigerian lagosian numbers" do
        expect(countries.formatted('23414480000', :format => :international)).to eq '+234 1 448 0000'
      end
      it "should format nigerian beninese numbers" do
        expect(countries.formatted('23452123456', :format => :international)).to eq '+234 52 123 456'
      end
      it "should format nigerian mobile numbers" do
        expect(countries.formatted('2347061234567', :format => :international)).to eq '+234 706 123 4567'
      end
      context 'with no spaces' do
        it "should format north american numbers" do
          expect(Phony.formatted('18091231234', :format => :international, :spaces => '')).to eq '+1(809)123-1234'
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international, :spaces => '')).to eq '+43198110'
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_absolute, :spaces => '')).to eq '+43198110'
        end
        it "should format french numbers" do
          expect(Phony.formatted('33142278186', :format => :+, :spaces => '')).to eq '+33142278186'
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_relative, :spaces => '')).to eq '0043198110'
        end
        it 'should format liechtensteiner numbers' do
          expect(Phony.formatted('4233841148', :format => :international_relative, :spaces => '')).to eq '004233841148'
        end
      end

      context 'with special spaces' do
        it "should format swiss numbers" do
          expect(Phony.formatted('41443643532', :format => :international)).to eq '+41 44 364 35 32'
        end
        it "should format north american numbers" do
          expect(Phony.formatted('18091231234', :format => :international, :spaces => :-)).to eq '+1-(809)-123-1234'
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international, :spaces => :-)).to eq '+43-1-98110'
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_absolute, :spaces => :-)).to eq '+43-1-98110'
        end
        it "should format french numbers" do
          expect(Phony.formatted('33142278186', :format => :+, :spaces => :-)).to eq '+33-1-42-27-81-86'
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_relative, :spaces => :-)).to eq '0043-1-98110'
        end
        it 'should format liechtensteiner numbers' do
          expect(Phony.formatted('4233841148', :format => :international_relative, :spaces => :-)).to eq '00423-384-11-48'
        end

      end
    end
  end

end
