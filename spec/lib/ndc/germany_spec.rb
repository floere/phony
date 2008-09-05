require File.dirname(__FILE__) + '/../../spec_helper'

describe E164::NDC::Germany do

  attr_reader :splitter
  before(:each) do
    @splitter = E164::NDC::Germany
  end

  describe "split" do
    it "should handle Berlin" do
      splitter.split('3038625454').should == ['30', '386', '25454']
    end
    it "should handle Cologne" do
      splitter.split('22137683323').should == ['221', '376', '83323']
    end
    it "should handle Freiburg im Breisgau" do
      splitter.split('7614767676').should == ['761', '476', '7676']
    end
    it "should handle Nettetal-Lobberich" do
      splitter.split('21535100').should == ['2153', '510', '0']
    end
  end

  describe "formatted" do
    it "should format Berlin" do
      splitter.formatted('3038625454').should == '30 386 25454'
    end
    it "should format Cologne" do
      splitter.formatted('22137683323').should == '221 376 83323'
    end
    it "should format Freiburg im Breisgau" do
      splitter.formatted('7614767676').should == '761 476 7676'
    end
    it "should format Nettetal-Lobberich" do
      splitter.formatted('21535100').should == '2153 510 0'
    end
  end

end