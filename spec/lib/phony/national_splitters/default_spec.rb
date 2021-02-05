require 'spec_helper'

describe Phony::NationalSplitters::Default do
  
  describe 'instance_for' do
    it 'caches' do
      described_class.instance_for.should equal(described_class.instance_for)
    end
  end
  
  context 'with instance' do
    let(:splitter) { described_class.instance_for }
    
    describe 'split' do
      it 'does only pretend split' do
        splitter.split(:anything).should == [nil, :anything]
      end
    end
    
    describe 'plausible?' do
      it 'is always plausible' do
        splitter.plausible?(:anything, :anything).should be_truthy
      end
    end
    
    describe 'length' do
      it 'needs to be at least 3' do
        splitter.length.should == 3
      end
    end
    
  end
  
end