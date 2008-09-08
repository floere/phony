require File.dirname(__FILE__) + '/../spec_helper'

describe E164 do
  
  describe "normalize" do
    describe "some examples" do
      it "should normalize an already normalized number" do
        E164.normalize('41443643533').should == '41443643533'
      end
      it "should normalize a formatted number" do
        E164.normalize('+41 44 364 35 33').should == '41443643533'
      end
      it "should normalize a formatted number" do
        E164.normalize('+41 44 364 35 33').should == '41443643533'
      end
      it "should remove characters from the number" do
        E164.normalize('John: +41 44 364 35 33').should == '41443643533'
      end
      it "should normalize one of these crazy american numbers" do
        E164.normalize('1 (703) 451-5115').should == '17034515115'
      end
      it "should normalize another one of these crazy american numbers" do
        E164.normalize('1-888-407-4747').should == '18884074747'
      end
      it "should normalize a number with colons" do
        E164.normalize('1.906.387.1698').should == '19063871698'
      end
      it "should normalize a number with optional ndc" do
        E164.normalize('+41 (044) 364 35 33').should == '41443643533'
      end
    end
  end
  
  describe "remove_relative_zeros" do
    it "should remove an ndc zero from an almost normalized number and return it" do
      in_the E164 do
        remove_relative_zeros!('410443643533').should == '41443643533'
      end
    end
  end
  
  describe "formatted_cc_ndc" do
    describe "international" do
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', nil).should == '+41 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :international_absolute).should == '+41 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :international).should == '+41 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :+).should == '+41 44 '
        end
      end
      it "should return an relative internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :international_relative).should == '0041 44 '
        end
      end
    end
    describe "national" do
      it "should return a nationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :national).should == '044 '
        end
      end
    end
    describe "local" do
      it "should return a locally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :local).should == ''
        end
      end
    end
  end

  describe "split" do
    it "should handle austrian numbers" do
      E164.split('43198110').should == ['43', '1', '98110']
    end
    it "should handle french numbers" do
      E164.split('33112345678').should == ['33', '1', '12','34','56','78']
    end
    it "should handle german numbers" do
      E164.split('4976112345').should == ['49', '761', '123', '45']
    end
    it "should handle italian numbers opinionatedly" do
      E164.split('3928061371').should == ['39', '280', '613', '71']
    end
    it "should handle swiss numbers" do
      E164.split('41443643532').should == ['41', '44', '364', '35', '32']
    end
    it "should handle US numbers" do
      E164.split('15551115511').should == ['1', '555', '111', '5511']
    end
    it "should handle new zealand numbers" do
      E164.split('6491234567').should == ['64', '9', '123', '4567']
    end
  end

  describe "formatted" do
    describe "default" do
      it "should format swiss numbers" do
        E164.formatted('41443643532').should == '+41 44 364 35 32'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110').should == '+43 1 98110'
      end
      it "should format american numbers" do
        E164.formatted('18705551122').should == '+1 870 555 1122'
      end
    end
    describe "international" do
      it "should format north american numbers" do
        E164.formatted('18091231234', :format => :international).should == '+1 809 123 1234'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international).should == '+43 1 98110'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international_absolute).should == '+43 1 98110'
      end
      it "should format french numbers" do
        E164.formatted('33142278186', :format => :+).should == '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international_relative).should == '0043 1 98110'
      end
    end
    describe "national" do
      it "should format swiss numbers" do
        E164.formatted('41443643532', :format => :national).should == '044 364 35 32'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :national).should == '01 98110'
      end
    end
    describe "local" do
      it "should format swiss numbers" do
        E164.formatted('41443643532', :format => :local).should == '364 35 32'
      end
      it "should format german numbers" do
        E164.formatted('493038625454', :format => :local).should == '386 25454'
      end
    end
  end

end