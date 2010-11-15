require 'spec_helper'

describe Phony::NDC::Austria do

  attr_reader :splitter
  before(:each) do
    @splitter = Phony::NDC::Austria
  end

  describe "split" do
    it "should handle Vienna" do
      splitter.split('198110').should == ['1', '98110']
    end
    it "should handle some mobile services" do
      splitter.split('66914093902').should == ['669', '14093902']
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
      splitter.formatted('671234567891').should == '67 1234567891'
    end
    it "should format Graz" do
      splitter.formatted('316123456789').should == '316 123456789'
    end
    it "should format Rohrau" do
      splitter.formatted('216412345678').should == '2164 12345678'
    end
  end

end