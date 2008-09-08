require File.dirname(__FILE__) + '/../../spec_helper'

describe E164::NDC::Prefix do
  
  attr_reader :splitter
  before(:each) do
    @splitter = E164::NDC::Splitter
  end
  
  describe "DSL" do
    describe "local" do
      it "should set @split_sizes" do
        splitter.local 3,2,2
        splitter.instance_variable_get(:@split_sizes).should == [3,2,2]
      end
      it "should call format" do
        splitter.should_receive(:format).once.with('%s %s %s')
        splitter.local 3,2,2
      end
    end
    describe "format" do
      it "should set @format" do
        splitter.format 'any format'
        splitter.instance_variable_get(:@format).should == 'any format'
      end
      it "should set @format_with_ndc" do
        
      end
    end
  end
  
end