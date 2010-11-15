require 'spec_helper'

describe Phony::NationalCodes::FixedSplitter do
  
  describe 'instance_for' do
    it 'caches' do
      Phony::NationalCodes::FixedSplitter.instance_for(3).should equal(Phony::NationalCodes::FixedSplitter.instance_for(3))
    end
    it 'caches correctly' do
      Phony::NationalCodes::FixedSplitter.instance_for(1).should_not equal(Phony::NationalCodes::FixedSplitter.instance_for(2))
    end
  end
  
  describe 'split' do
    before(:each) do
      @splitter = Phony::NationalCodes::FixedSplitter.new 2
    end
    it 'splits correctly' do
      @splitter.split('443643532').should == ['44', '3643532']
    end
    it 'splits correctly even when the number is too long' do
      @splitter.split('44364353211').should == ['44', '364353211']
    end
    it 'splits correctly even when the number is too short' do
      @splitter.split('443').should == ['44','3']
    end
  end
  
end