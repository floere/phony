require 'spec_helper'

describe Phony::CountryCodes do

  before(:all) do
    @countries = Phony::CountryCodes.instance
  end
  
  describe '#[]' do
    it 'returns a country' do
      @countries['41'].class.should eql Phony::Country
    end
  end
  
  describe '#country_for' do
    it 'returns a country' do
      @countries.send(:country_for, '41').class.should eql Phony::Country
    end
  end
  
  describe '#countrify' do
    it 'returns a country' do
      @countries.send(:countrify, '441231212', '41').should eql '41441231212'
    end
  end
  describe '#countrify!' do
    it 'in-place replaces the number' do
      number = '441231212'
      @countries.send(:countrify!, number, '41').should eql number
      
      number.should == '41441231212'
    end
  end
  
  describe '#vanity?' do
    it 'returns true if so' do
      @countries.vanity?('1800HELLOES').should eql true
    end
    it 'returns false if not' do
      @countries.vanity?('18001234567').should eql false
    end
  end

  describe 'normalize' do
    it 'normalizes correctly' do
      @countries.normalize('0041-44-364-35-32').should eql '41443643532'
    end
    it 'normalizes correctly with CC option' do
      @countries.normalize('044-364-35-32', cc: '41').should eql '41443643532'
    end

    context 'specific countries' do
      it 'handles Congo correctly' do
        @countries.normalize('+242 0571 73992').should eql '242057173992'
        @countries.normalize('+242 2221 15932').should eql '242222115932'
      end
    end
  end

  describe 'formatted' do
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international, :spaces => :-).should eql '+41-44-364-35-32'
    end
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international_relative, :spaces => :-).should eql '0041-44-364-35-32'
    end
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :national, :spaces => :-).should eql '044-364-35-32'
    end
    context 'specific' do
      it 'formats Ireland correctly' do
        @countries.formatted("3533451234", :format => :national).should eql '0345 1234'
      end
      it 'formats Ireland correctly' do
        @countries.formatted("353411231234", :format => :national).should eql '041 123 1234'
      end
      it 'formats Spain correctly' do
        @countries.formatted("34123456789", :format => :national).should eql '123 456 789'
      end
      it 'formats Cambodia correctly' do
        @countries.formatted('85512239123', :format => :national).should eql '012 239 123'
      end
      it 'formats the US correctly' do
        @countries.formatted('18005551212', :format => :national, :spaces => :-).should eql '(800)-555-1212'
      end
      it 'formats the US correctly' do
        @countries.formatted('18005551212', :format => :national, :spaces => :-).should eql '(800)-555-1212'
      end
    end
    context 'default' do
      it "should format swiss numbers" do
        @countries.formatted('41443643532').should eql '+41 44 364 35 32'
      end
      it "should format swiss service numbers" do
        @countries.formatted('41800112233').should eql '+41 800 112 233'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110').should eql '+43 1 98110'
      end
      it "should format american numbers" do
        @countries.formatted('18705551122').should eql '+1 (870) 555-1122'
      end
      it "should format irish numbers" do
        @countries.formatted('35311234567').should eql '+353 1 123 4567'
      end
    end
    describe "international" do
      it "should format north american numbers" do
        @countries.formatted('18091231234', :format => :international).should eql '+1 (809) 123-1234'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110', :format => :international).should eql '+43 1 98110'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110', :format => :international_absolute).should eql '+43 1 98110'
      end
      it "should format french numbers" do
        @countries.formatted('33142278186', :format => :+).should eql '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110', :format => :international_relative).should eql '0043 1 98110'
      end
      it 'should format liechtensteiner numbers' do
        @countries.formatted('4233841148', :format => :international_relative).should eql '00423 384 11 48'
      end
      it "should format irish numbers" do
        @countries.formatted('35311234567', :format => :international).should eql '+353 1 123 4567'
      end
      it "should format luxembourgian numbers" do
        @countries.formatted('352222809', :format => :international).should eql '+352 22 28 09'
      end
      it "should format luxembourgian 4-digit ndc numbers" do
        @countries.formatted('35226222809', :format => :international).should eql '+352 2622 28 09'
      end
      it "should format luxembourgian mobile numbers" do
        @countries.formatted('352621123456', :format => :international).should eql '+352 621 123 456'
      end
      it "should format luxembourgian city numbers" do
        @countries.formatted('3524123456', :format => :international).should eql '+352 41 23 45 6'
      end
      it "should format luxembourgian machine to machine numbers" do
        @countries.formatted('352602112345678', :format => :international).should eql '+352 6021 12 34 56 78'
      end
      it "should format luxembourgian numbers" do
        @countries.formatted('352370431', :format => :international).should eql '+352 37 04 31'
      end
      it "should format luxembourgian numbers" do
        @countries.formatted('35227855', :format => :international).should eql '+352 27 85 5'
      end
      it "should format nigerian lagosian numbers" do
        @countries.formatted('23414480000', :format => :international).should eql '+234 1 448 0000'
      end
      it "should format nigerian beninese numbers" do
        @countries.formatted('23452123456', :format => :international).should eql '+234 52 123 456'
      end
      it "should format nigerian mobile numbers" do
        @countries.formatted('2347061234567', :format => :international).should eql '+234 706 123 4567'
      end
      context 'with no spaces' do
        it "should format north american numbers" do
          Phony.formatted('18091231234', :format => :international, :spaces => '').should eql '+1(809)123-1234'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international, :spaces => '').should eql '+43198110'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_absolute, :spaces => '').should eql '+43198110'
        end
        it "should format french numbers" do
          Phony.formatted('33142278186', :format => :+, :spaces => '').should eql '+33142278186'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_relative, :spaces => '').should eql '0043198110'
        end
        it 'should format liechtensteiner numbers' do
          Phony.formatted('4233841148', :format => :international_relative, :spaces => '').should eql '004233841148'
        end
      end
      context 'with special spaces' do
        it "should format swiss numbers" do
          Phony.formatted('41443643532', :format => :international).should eql '+41 44 364 35 32'
        end
        it "should format north american numbers" do
          Phony.formatted('18091231234', :format => :international, :spaces => :-).should eql '+1-(809)-123-1234'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international, :spaces => :-).should eql '+43-1-98110'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_absolute, :spaces => :-).should eql '+43-1-98110'
        end
        it "should format french numbers" do
          Phony.formatted('33142278186', :format => :+, :spaces => :-).should eql '+33-1-42-27-81-86'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_relative, :spaces => :-).should eql '0043-1-98110'
        end
        it 'should format liechtensteiner numbers' do
          Phony.formatted('4233841148', :format => :international_relative, :spaces => :-).should eql '00423-384-11-48'
        end

      end
    end
  end

end
