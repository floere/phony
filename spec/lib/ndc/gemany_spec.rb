require File.dirname(__FILE__) + '/../../../spec_helper'

describe E164::NDC::Germany do

  attr_reader :splitter
  before(:each) do
    @splitter = E164::NDC::Germany
  end

  describe "split" do
    it "should handle Cologne" do
      splitter.split('221123456').should == ['221', '123456']
    end
  end

  describe "formatted" do
    it "should format Cologne" do
      splitter.formatted('221123456').should == '221 123456'
    end
  end

end