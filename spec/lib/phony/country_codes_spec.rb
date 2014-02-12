require 'spec_helper'

describe Phony::CountryCodes do
  
  before(:all) do
    @countries = Phony::CountryCodes.instance
  end
  
  describe 'international_absolute_format=' do
    it 'formats correctly' do
      expect(@countries.formatted('41443643532', :format => :international)).to eq('+41 44 364 35 32')
    end
    it 'formats correctly' do
      old_format = @countries.international_absolute_format
      @countries.international_absolute_format = '!!! %s%s%s'
      
      expect(@countries.formatted('41443643532', :format => :international)).to eq('!!! 41 44 364 35 32')
      
      @countries.international_absolute_format = old_format
    end
  end
  describe 'international_relative_format=' do
    it 'formats correctly' do
      expect(@countries.formatted('41443643532', :format => :international_relative)).to eq('0041 44 364 35 32')
    end
    it 'formats correctly' do
      old_format = @countries.international_relative_format
      @countries.international_relative_format = '000 %s%s%s'
      
      expect(@countries.formatted('41443643532', :format => :international_relative)).to eq('000 41 44 364 35 32')
      
      @countries.international_relative_format = old_format
    end
  end
  describe 'national_format=' do
    it 'formats correctly' do
      expect(@countries.formatted('41443643532', :format => :international_relative)).to eq('0041 44 364 35 32')
    end
    it 'formats correctly' do
      old_format = @countries.national_format
      @countries.national_format = '%s%s'
      
      expect(@countries.formatted('11231231234', :format => :national)).to eq('123 123 1234')
      
      @countries.national_format = old_format
    end
  end
  
  describe 'split' do
    it 'splits correctly' do
      expect(@countries.split('41443643532')).to eq(['41', '0', '44', '364', '35', '32'])
    end
  end
  
  describe 'formatted' do
    it 'formats correctly' do
      expect(@countries.formatted('41443643532', :format => :international, :spaces => :-)).to eq('+41-44-364-35-32')
    end
    it 'formats correctly' do
      expect(@countries.formatted('41443643532', :format => :international_relative, :spaces => :-)).to eq('0041-44-364-35-32')
    end
    it 'formats correctly' do
      expect(@countries.formatted('41443643532', :format => :national, :spaces => :-)).to eq('044-364-35-32')
    end
    context 'specific' do
      it 'formats ireland correctly' do
        expect(@countries.formatted("3533451234", :format => :national)).to eq('0345 1234')
      end
      it 'formats ireland correctly' do
        expect(@countries.formatted("353411231234", :format => :national)).to eq('041 123 1234')
      end
    end
    context 'default' do
      it "should format swiss numbers" do
        expect(@countries.formatted('41443643532')).to eq('+41 44 364 35 32')
      end
      it "should format swiss service numbers" do
        expect(@countries.formatted('41800112233')).to eq('+41 800 112 233')
      end
      it "should format austrian numbers" do
        expect(@countries.formatted('43198110')).to eq('+43 1 98110')
      end
      it "should format american numbers" do
        expect(@countries.formatted('18705551122')).to eq('+1 870 555 1122')
      end
      it "should format irish numbers" do
        expect(@countries.formatted('35311234567')).to eq('+353 1 123 4567')
      end
    end
    describe "international" do
      it "should format north american numbers" do
        expect(@countries.formatted('18091231234', :format => :international)).to eq('+1 809 123 1234')
      end
      it "should format austrian numbers" do
        expect(@countries.formatted('43198110', :format => :international)).to eq('+43 1 98110')
      end
      it "should format austrian numbers" do
        expect(@countries.formatted('43198110', :format => :international_absolute)).to eq('+43 1 98110')
      end
      it "should format french numbers" do
        expect(@countries.formatted('33142278186', :format => :+)).to eq('+33 1 42 27 81 86')
      end
      it "should format austrian numbers" do
        expect(@countries.formatted('43198110', :format => :international_relative)).to eq('0043 1 98110')
      end
      it 'should format liechtensteiner numbers' do
        expect(@countries.formatted('4233841148', :format => :international_relative)).to eq('00423 384 11 48')
      end
      it "should format irish numbers" do
        expect(@countries.formatted('35311234567', :format => :international)).to eq('+353 1 123 4567')
      end
      it "should format luxembourgian numbers" do
        expect(@countries.formatted('352222809', :format => :international)).to eq('+352 22 28 09')
      end
      it "should format luxembourgian 4-digit ndc numbers" do
        expect(@countries.formatted('35226222809', :format => :international)).to eq('+352 26 22 28 09')
      end
      it "should format luxembourgian mobile numbers" do
        expect(@countries.formatted('352621123456', :format => :international)).to eq('+352 621 123 456')
      end
      it "should format luxembourgian city numbers" do
        expect(@countries.formatted('3524123456', :format => :international)).to eq('+352 4 12 34 56')
      end
      it "should format luxembourgian machine to machine numbers" do
        expect(@countries.formatted('352602112345678', :format => :international)).to eq('+352 6021 12 34 56 78')
      end
      it "should format luxembourgian numbers" do
        expect(@countries.formatted('352370431', :format => :international)).to eq('+352 37 04 31')
      end
      it "should format luxembourgian numbers" do
        expect(@countries.formatted('35227855', :format => :international)).to eq('+352 27 85 5')
      end
      it "should format nigerian numbers" do
        expect(@countries.formatted('23414480000', :format => :international)).to eq('+234 1 448 0000')
      end
      it "should format nigerian mobile numbers" do
        expect(@countries.formatted('2347061234567', :format => :international)).to eq('+234 706 123 4567')
      end
      context 'with no spaces' do
        it "should format north american numbers" do
          expect(Phony.formatted('18091231234', :format => :international, :spaces => '')).to eq('+18091231234')
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international, :spaces => '')).to eq('+43198110')
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_absolute, :spaces => '')).to eq('+43198110')
        end
        it "should format french numbers" do
          expect(Phony.formatted('33142278186', :format => :+, :spaces => '')).to eq('+33142278186')
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_relative, :spaces => '')).to eq('0043198110')
        end
        it 'should format liechtensteiner numbers' do
          expect(Phony.formatted('4233841148', :format => :international_relative, :spaces => '')).to eq('004233841148')
        end
      end
      context 'with special spaces' do
        it "should format swiss numbers" do
          expect(Phony.formatted('41443643532', :format => :international)).to eq('+41 44 364 35 32')
        end
        it "should format north american numbers" do
          expect(Phony.formatted('18091231234', :format => :international, :spaces => :-)).to eq('+1-809-123-1234')
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international, :spaces => :-)).to eq('+43-1-98110')
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_absolute, :spaces => :-)).to eq('+43-1-98110')
        end
        it "should format french numbers" do
          expect(Phony.formatted('33142278186', :format => :+, :spaces => :-)).to eq('+33-1-42-27-81-86')
        end
        it "should format austrian numbers" do
          expect(Phony.formatted('43198110', :format => :international_relative, :spaces => :-)).to eq('0043-1-98110')
        end
        it 'should format liechtensteiner numbers' do
          expect(Phony.formatted('4233841148', :format => :international_relative, :spaces => :-)).to eq('00423-384-11-48')
        end

      end
    end
  end
  
end