require 'spec_helper'

describe Phony::NationalSplitters::Fixed do
  
  describe 'instance_for' do
    it 'caches' do
      Phony::NationalSplitters::Fixed.instance_for(3).should equal(Phony::NationalSplitters::Fixed.instance_for(3))
    end
    it 'caches correctly' do
      Phony::NationalSplitters::Fixed.instance_for(1).should_not equal(Phony::NationalSplitters::Fixed.instance_for(2))
    end
  end
  
  describe 'split' do
    before(:each) do
      @splitter = Phony::NationalSplitters::Fixed.new 2
    end
    it 'splits correctly' do
      @splitter.split('443643532').should == [nil, '44', '3643532']
    end
    it 'splits correctly even when the number is too long' do
      @splitter.split('44364353211').should == [nil, '44', '364353211']
    end
    it 'splits correctly even when the number is too short' do
      @splitter.split('443').should == [nil, '44','3']
    end
  end
  describe 'split' do
    before(:each) do
      @splitter = Phony::NationalSplitters::Fixed.new nil
    end
    it 'splits correctly' do
      @splitter.split('443643532').should == [nil, '443643532']
    end
    it 'splits correctly even when the number is too long' do
      @splitter.split('44364353211').should == [nil, '44364353211']
    end
    it 'splits correctly even when the number is too short' do
      @splitter.split('443').should == [nil, '443']
    end
  end
  
end