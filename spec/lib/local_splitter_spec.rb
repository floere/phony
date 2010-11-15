require 'spec_helper'

describe Phony::LocalSplitter do
  
  describe 'instance_for' do
    it 'caches' do
      Phony::LocalSplitter.instance_for([3,2,2]).should equal(Phony::LocalSplitter.instance_for([3,2,2]))
    end
    it 'caches correctly' do
      Phony::LocalSplitter.instance_for([1,2,3]).should_not equal(Phony::LocalSplitter.instance_for([9,9,9]))
    end
  end
  
  describe 'split' do
    before(:each) do
      @splitter = Phony::LocalSplitter.new [3, 2, 2]
    end
    it 'splits correctly' do
      @splitter.split('3643532').should == ['364','35','32']
    end
    it 'splits correctly even when the number is too long' do
      @splitter.split('3643532111').should == ['364','35','32']
    end
    it 'splits correctly even when the number is too short' do
      @splitter.split('364353').should == ['364','35','3'] # TODO Redo correctly.
    end
  end
  
end