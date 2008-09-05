require File.dirname(__FILE__) + '/../spec_helper'

describe E164 do

  describe "split" do
    it "should handle austrian numbers" do
      E164.split('43112345678').should == ['43', '1', '12345678']
    end
    it "should handle french numbers" do
      E164.split('33112345678').should == ['33', '1', '12345678']
    end
    it "should handle german numbers opinionatedly" do
      E164.split('49123123456').should == ['49', '123', '123456']
    end
    it "should handle italian numbers opinionatedly" do
      E164.split('39123123456').should == ['39', '123', '123456']
    end
    it "should handle swiss numbers" do
      E164.split('41443643532').should == ['41', '44', '3643532']
    end
    it "should handle US numbers" do
      E164.split('15551115511').should == ['1', '555', '1115511']
    end
    it "should handle new zealand numbers" do
      E164.split('6491231234').should == ['64', '9', '1231234']
    end
  end

  describe "formatted" do
    describe "default" do
      it "should format austrian numbers" do
        E164.formatted('43198110').should == '+43 1 98110'
      end
    end
    describe "international" do
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international).should == '+43 1 98110'
      end
    end
  end

end