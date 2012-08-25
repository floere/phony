require 'spec_helper'

describe Phony::CountryCodes do
  
  before(:all) do
    @countries = Phony::CountryCodes.instance
  end
  
  describe 'international_absolute_format=' do
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international).should == '+41 44 364 35 32'
    end
    it 'formats correctly' do
      old_format = @countries.international_absolute_format
      @countries.international_absolute_format = '!!! %s%s%s'
      
      @countries.formatted('41443643532', :format => :international).should == '!!! 41 44 364 35 32'
      
      @countries.international_absolute_format = old_format
    end
  end
  describe 'international_relative_format=' do
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international_relative).should == '0041 44 364 35 32'
    end
    it 'formats correctly' do
      old_format = @countries.international_relative_format
      @countries.international_relative_format = '000 %s%s%s'
      
      @countries.formatted('41443643532', :format => :international_relative).should == '000 41 44 364 35 32'
      
      @countries.international_relative_format = old_format
    end
  end
  describe 'national_format=' do
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international_relative).should == '0041 44 364 35 32'
    end
    it 'formats correctly' do
      old_format = @countries.national_format
      @countries.national_format = '%s%s'
      
      @countries.formatted('11231231234', :format => :national).should == '123 123 1234'
      
      @countries.national_format = old_format
    end
  end
  
  describe 'split' do
    it 'splits correctly' do
      @countries.split('41443643532').should == ['41', '0', '44', '364', '35', '32']
    end
  end
  
  describe 'formatted' do
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international, :spaces => :-).should == '+41-44-364-35-32'
    end
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international_relative, :spaces => :-).should == '0041-44-364-35-32'
    end
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :national, :spaces => :-).should == '044-364-35-32'
    end
    context 'specific' do
      it 'formats ireland correctly' do
        @countries.formatted("3533451234", :format => :national).should == '0345 1234'
      end
      it 'formats ireland correctly' do
        @countries.formatted("353411231234", :format => :national).should == '041 123 1234'
      end
    end
    context 'default' do
      it "should format swiss numbers" do
        @countries.formatted('41443643532').should == '+41 44 364 35 32'
      end
      it "should format swiss service numbers" do
        @countries.formatted('41800112233').should == '+41 800 112 233'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110').should == '+43 1 98110'
      end
      it "should format american numbers" do
        @countries.formatted('18705551122').should == '+1 870 555 1122'
      end
      it "should format irish numbers" do
        @countries.formatted('35311234567').should == '+353 1 123 4567'
      end
    end
    describe "international" do
      it "should format north american numbers" do
        @countries.formatted('18091231234', :format => :international).should == '+1 809 123 1234'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110', :format => :international).should == '+43 1 98110'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110', :format => :international_absolute).should == '+43 1 98110'
      end
      it "should format french numbers" do
        @countries.formatted('33142278186', :format => :+).should == '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        @countries.formatted('43198110', :format => :international_relative).should == '0043 1 98110'
      end
      it 'should format liechtensteiner numbers' do
        @countries.formatted('4233841148', :format => :international_relative).should == '00423 384 11 48'
      end
      it "should format irish numbers" do
        @countries.formatted('35311234567', :format => :international).should == '+353 1 123 4567'
      end
      it "should format luxembourgian numbers" do
        @countries.formatted('352222809', :format => :international).should == '+352 22 28 09'
      end
      it "should format luxembourgian 4-digit ndc numbers" do
        @countries.formatted('35226222809', :format => :international).should == '+352 26 22 28 09'
      end
      it "should format luxembourgian mobile numbers" do
        @countries.formatted('352621123456', :format => :international).should == '+352 621 123 456'
      end
      it "should format luxembourgian city numbers" do
        @countries.formatted('3524123456', :format => :international).should == '+352 4 12 34 56'
      end
      it "should format luxembourgian machine to machine numbers" do
        @countries.formatted('352602112345678', :format => :international).should == '+352 6021 12 34 56 78'
      end
      it "should format luxembourgian numbers" do
        @countries.formatted('352370431', :format => :international).should == '+352 37 04 31'
      end
      it "should format luxembourgian numbers" do
        @countries.formatted('35227855', :format => :international).should == '+352 27 85 5'
      end
      it "should format nigerian numbers" do
        @countries.formatted('23414480000', :format => :international).should == '+234 1 448 0000'
      end
      it "should format nigerian mobile numbers" do
        @countries.formatted('2347061234567', :format => :international).should == '+234 706 123 4567'
      end
      context 'with no spaces' do
        it "should format north american numbers" do
          Phony.formatted('18091231234', :format => :international, :spaces => '').should == '+18091231234'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international, :spaces => '').should == '+43198110'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_absolute, :spaces => '').should == '+43198110'
        end
        it "should format french numbers" do
          Phony.formatted('33142278186', :format => :+, :spaces => '').should == '+33142278186'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_relative, :spaces => '').should == '0043198110'
        end
        it 'should format liechtensteiner numbers' do
          Phony.formatted('4233841148', :format => :international_relative, :spaces => '').should == '004233841148'
        end
      end
      context 'with special spaces' do
        it "should format swiss numbers" do
          Phony.formatted('41443643532', :format => :international).should == '+41 44 364 35 32'
        end
        it "should format north american numbers" do
          Phony.formatted('18091231234', :format => :international, :spaces => :-).should == '+1-809-123-1234'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international, :spaces => :-).should == '+43-1-98110'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_absolute, :spaces => :-).should == '+43-1-98110'
        end
        it "should format french numbers" do
          Phony.formatted('33142278186', :format => :+, :spaces => :-).should == '+33-1-42-27-81-86'
        end
        it "should format austrian numbers" do
          Phony.formatted('43198110', :format => :international_relative, :spaces => :-).should == '0043-1-98110'
        end
        it 'should format liechtensteiner numbers' do
          Phony.formatted('4233841148', :format => :international_relative, :spaces => :-).should == '00423-384-11-48'
        end

      end
    end
  end
  
end