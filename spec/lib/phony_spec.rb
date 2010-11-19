# encoding: utf-8
#
require 'spec_helper'

describe Phony do
  
  describe "split" do
    it "should handle austrian numbers" do
      Phony.split('43198110').should == ['43', '1', '98110']
    end
    it "should handle french numbers" do
      Phony.split('33112345678').should == ['33', '1', '12','34','56','78']
    end
    it "should handle german numbers" do
      Phony.split('4976112345').should == ['49', '761', '123', '45']
    end
    it "should handle hungarian numbers" do
      Phony.split('3612345678').should == ['36', '1', '234', '5678']
    end
    it "should handle italian numbers opinionatedly" do
      Phony.split('3928061371').should == ['39', '2', '806', '1371']
    end
    it "should handle swiss numbers" do
      Phony.split('41443643532').should == ['41', '44', '364', '35', '32']
    end
    it "should handle US numbers" do
      Phony.split('15551115511').should == ['1', '555', '111', '5511']
    end
    it "should handle new zealand numbers" do
      Phony.split('6491234567').should == ['64', '9', '123', '4567']
    end
    
    it "should handle swiss service numbers" do
      Phony.split('41800334455').should == ['41', '800', '334', '455']
    end
  end
  
  describe "normalize" do
    describe "some examples" do
      it "should normalize an already normalized number" do
        Phony.normalize('41443643533').should == '41443643533'
      end
      it "should normalize a formatted number" do
        Phony.normalize('+41 44 364 35 33').should == '41443643533'
      end
      it "should normalize a formatted number" do
        Phony.normalize('+41 44 364 35 33').should == '41443643533'
      end
      it "should normalize a service number" do
        Phony.normalize('+41 800 11 22 33').should == '41800112233'
      end
      it "should remove characters from the number" do
        Phony.normalize('John: +41 44 364 35 33').should == '41443643533'
      end
      it "should normalize one of these crazy american numbers" do
        Phony.normalize('1 (703) 451-5115').should == '17034515115'
      end
      it "should normalize another one of these crazy american numbers" do
        Phony.normalize('1-888-407-4747').should == '18884074747'
      end
      it "should normalize a number with colons" do
        Phony.normalize('1.906.387.1698').should == '19063871698'
      end
      it "should normalize a number with optional ndc" do
        Phony.normalize('+41 (044) 364 35 33').should == '41443643533'
      end
      it "should normalize a number with erroneous zero inside" do
        Phony.normalize('+410443643533').should == '41443643533'
      end
    end
  end
  
  describe "formatted" do
    describe "default" do
      it "should format swiss numbers" do
        Phony.formatted('41443643532').should == '+41 44 364 35 32'
      end
      # TODO
      #
      it "should format swiss service numbers" do
        Phony.formatted('41800112233').should == '+41 800 112 233'
      end
      it "should format austrian numbers" do
        Phony.formatted('43198110').should == '+43 1 98110'
      end
      it "should format american numbers" do
        Phony.formatted('18705551122').should == '+1 870 555 1122'
      end
    end
    describe "international" do
      it "should format north american numbers" do
        Phony.formatted('18091231234', :format => :international).should == '+1 809 123 1234'
      end
      it "should format austrian numbers" do
        Phony.formatted('43198110', :format => :international).should == '+43 1 98110'
      end
      it "should format austrian numbers" do
        Phony.formatted('43198110', :format => :international_absolute).should == '+43 1 98110'
      end
      it "should format french numbers" do
        Phony.formatted('33142278186', :format => :+).should == '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        Phony.formatted('43198110', :format => :international_relative).should == '0043 1 98110'
      end
      it 'should format liechtensteiner numbers' do
        Phony.formatted('4233841148', :format => :international_relative).should == '00423 384 11 48'
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
    describe "national" do
      it "should format swiss numbers" do
        Phony.formatted('41443643532', :format => :national).should == '044 364 35 32'
      end
      # TODO
      #
      it "should format swiss service numbers" do
        Phony.formatted('41800112233', :format => :national).should == '0800 112 233'
      end
      it "should format austrian numbers" do
        Phony.formatted('43198110', :format => :national).should == '01 98110'
      end
    end
    describe "local" do
      it "should format swiss numbers" do
        Phony.formatted('41443643532', :format => :local).should == '364 35 32'
      end
      it "should format german numbers" do
        Phony.formatted('493038625454', :format => :local).should == '386 25454'
      end
    end
  end
  
  context "speed" do
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
        performance_of { Phony.split(number) }.should < 0.00005
      end
      it 'is fast' do
        performance_of { @phone_numbers.each { |number| Phony.split(number) } }.should < 0.00015
      end
    end
    describe 'normalize' do
      it 'is fast' do
        number = @phone_numbers.first
        performance_of { Phony.normalize(number) }.should < 0.0001
      end
      it 'is fast' do
        performance_of { @phone_numbers.each { |number| Phony.normalize(number) } }.should < 0.00015
      end
    end
    describe 'formatted' do
      it 'is fast' do
        number = @phone_numbers.first
        performance_of { Phony.formatted(number) }.should < 0.000075
      end
      it 'is fast' do
        performance_of { @phone_numbers.each { |number| Phony.formatted(number) } }.should < 0.00015
      end
    end
  end
  
  # describe "service?" do
  # 
  # end
  # describe "mobile?" do
  #   # TODO Test dirty numbers.
  #   #
  #   it 'is correct' do
  #     Phony.mobile?('49172123456').should == true
  #   end
  #   it 'is correct' do
  #     Phony.mobile?('12172123456').should == false
  #   end
  # end
  
  describe 'vanity' do
    describe 'vanity_number?' do
      it {Phony.vanity?('41800 WEGGLI').should be_true}
      it {Phony.vanity?('41800WEGGLI').should be_true}
      it {Phony.vanity?('41848 SUCCESSMATCH').should be_true}
      it {Phony.vanity?('4180 NO NO NO').should be_false}
      it {Phony.vanity?('41900 KURZ').should be_false}
      it {Phony.vanity?('41 44 364 35 32').should be_false}
    end
    
    describe 'vanity_to_number' do
      it {Phony.vanity_to_number('41800WEGGLI').should == '41800934454'}
      it {Phony.vanity_to_number('41800weggli').should == '41800934454'}
      it {Phony.vanity_to_number('41800SUCCESSMATCH').should == '41800782237'} # Cut off according to the swiss norms.
      it {Phony.vanity_to_number('4180BLA').should == '4180252'} # Does not check for validity of number.
    end
  end

end