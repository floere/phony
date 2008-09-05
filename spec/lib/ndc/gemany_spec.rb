require File.dirname(__FILE__) + '/../../spec_helper'

describe E164::NDC::Germany do

  attr_reader :splitter
  before(:each) do
    @splitter = E164::NDC::Germany
  end

  describe "split" do
    it "should handle Berlin" do
      splitter.split('30700173079').should == ['30', '700173079']
    end
    it "should handle Cologne" do
      splitter.split('221123456').should == ['221', '123456']
    end
    it "should handle Freiburg im Breisgau" do
      splitter.split('7614767676').should == ['761', '4767676']
    end
    it "should handle Nettetal-Lobberich" do
      splitter.split('21535100').should == ['2153', '5100']
    end
  end

  describe "formatted" do
    it "should format Berlin" do
      splitter.formatted('30700173079').should == '30 700173079'
    end
    it "should format Cologne" do
      splitter.formatted('221123456').should == '221 123456'
    end
    it "should format Freiburg im Breisgau" do
      splitter.formatted('7614767676').should == '761 4767676'
    end
    it "should format Nettetal-Lobberich" do
      splitter.formatted('21535100').should == '2153 5100'
    end
  end

end