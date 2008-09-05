require File.dirname(__FILE__) + '/../../../spec_helper'

describe E164::NDC::Austria do

  attr_reader :splitter
  before(:each) do
    @splitter = E164::NDC::Austria
  end

  describe "split" do
    it "should handle Vienna" do
      splitter.split('1123456789123').should == ['1', '123456789123']
    end
    it "should handle some mobile services" do
      splitter.split('6712345678912').should == ['67', '12345678912']
    end
    it "should handle Graz" do
      splitter.split('3161234567891').should == ['316', '1234567891']
    end
    it "should handle Rohrau" do
      splitter.split('2164123456789').should == ['2164', '123456789']
    end
  end

  describe "formatted" do
    it "should format Vienna" do
      splitter.formatted('198110').should == '1 98110'
    end
    it "should format some mobile services" do
      splitter.formatted('6712345678912').should == '67 12345678912'
    end
    it "should format Graz" do
      splitter.formatted('3161234567891').should == '316 1234567891'
    end
    it "should format Rohrau" do
      splitter.formatted('2164123456789').should == '2164 123456789'
    end
  end

end