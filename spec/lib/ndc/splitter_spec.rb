require File.dirname(__FILE__) + '/../../spec_helper'

describe E164::NDC::Prefix do
  
  attr_reader :splitter
  
  describe "DSL" do
    before(:each) do
      @splitter = E164::NDC::Splitter
    end
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
        splitter.format 'any format'
        splitter.instance_variable_get(:@format_with_ndc).should == '%s any format'
      end
    end
  end
  
  describe "split_local" do
    describe "with local" do
      before(:each) do
        @splitter = E164::NDC.fixed(2, :local => [3, 2, 2])
      end
      it "should split it according to the local format" do
        splitter.split_local('3643533').should == ['364', '35', '33']
      end
    end
  end
  
end