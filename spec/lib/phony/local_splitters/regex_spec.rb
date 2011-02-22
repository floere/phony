require 'spec_helper'

describe Phony::LocalSplitters::Regex do
  
  describe 'instance_for' do
    it 'does not cache' do
      described_class.instance_for([],{}).should_not equal(described_class.instance_for([],{}))
    end
  end
  
  describe 'split' do
    before(:each) do
      # Norway.
      #
      @splitter = described_class.instance_for [2,2,2,2], /^[489].*$/ => [3,2,3]
    end
    it 'splits a number correctly' do
      @splitter.split('21234567').should == ['21','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('31234567').should == ['31','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('41234567').should == ['412','34','567']
    end
    it 'splits a number correctly' do
      @splitter.split('51234567').should == ['51','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('61234567').should == ['61','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('71234567').should == ['71','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('81234567').should == ['812','34','567']
    end
    it 'splits a number correctly' do
      @splitter.split('91234567').should == ['912','34','567']
    end
    it 'splits it fast' do
      performance_of { @splitter.split('21234567').should == ['21','23','45','67'] }.should < 0.00005
    end
    it 'splits it fast' do
      performance_of { @splitter.split('91234567').should == ['912','34','567'] }.should < 0.00004
    end
  end
  
end