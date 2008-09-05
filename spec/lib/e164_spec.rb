require File.dirname(__FILE__) + '/../spec_helper'

describe E164 do

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
        E164.formatted('41443643532').should == '+41 44 364 35 32'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110').should == '+43 1 98110'
      end
    end
    describe "international" do
      it "should format north american numbers" do
        E164.formatted('18091231234', :format => :international).should == '+1 809 123 1234'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international).should == '+43 1 98110'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international_absolute).should == '+43 1 98110'
      end
      it "should format french numbers" do
        E164.formatted('33142278186', :format => :+).should == '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international_relative).should == '0043 1 98110'
      end
    end
    describe "national" do
      it "should format swiss numbers" do
        E164.formatted('41443643532', :format => :national).should == '044 364 35 32'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :national).should == '01 98110'
      end
    end
    describe "local" do
      it "should format swiss numbers" do
        E164.formatted('41443643532', :format => :local).should == '364 35 32'
      end
      it "should format german numbers" do
        E164.formatted('493038625454', :format => :local).should == '386 25454'
      end
    end
  end

end