require 'spec_helper'

describe Phony::LocalSplitter do
  
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
      @splitter.split('364353').should == ['364','35','3']
    end
  end
  
end