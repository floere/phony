require 'spec_helper'

describe Phony::Countries::Egypt do
  
  before(:each) do
    @egypt = Phony::Countries::Egypt
  end
  
  describe "split" do
    it "works" do
      @egypt.split('233453756').should == ['2', '33453756']
    end
    it "works" do
      @egypt.split('921234567').should == ['92', '1234567']
    end
  end
  
end