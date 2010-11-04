require 'spec_helper'

describe E164::NDC::Prefix do
  
  attr_reader :prefix
  before(:each) do
    @prefix = E164::NDC::Prefix
  end
  
  describe "optimize" do
    it "should convert an array into a hash" do
      prefix.optimize(Array.new).should be_kind_of(Hash)
    end
    it "should convert an empty array into an empty thing" do
      prefix.optimize([]).should be_empty
    end
    it "should convert an empty array into an empty hash" do
      prefix.optimize([]).should == {}
    end
    it "should convert a various string length array into a hash(size=>array(entries))" do
      prefix.optimize(['1', '22', '333', '4444']).should == { 1 => ['1'], 2 => ['22'], 3 => ['333'], 4 => ['4444'] }
    end
  end
  
end