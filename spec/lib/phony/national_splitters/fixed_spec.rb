require 'spec_helper'

describe Phony::NationalSplitters::Fixed do
  
  describe 'instance_for' do
    it 'caches' do
      expect(Phony::NationalSplitters::Fixed.instance_for(3)).to equal(Phony::NationalSplitters::Fixed.instance_for(3))
    end
    it 'caches correctly' do
      expect(Phony::NationalSplitters::Fixed.instance_for(1)).not_to equal(Phony::NationalSplitters::Fixed.instance_for(2))
    end
  end
  
  describe 'split' do
    before(:each) do
      @splitter = Phony::NationalSplitters::Fixed.new 2
    end
    it 'splits correctly' do
      expect(@splitter.split('443643532')).to eq(['0', '44', '3643532'])
    end
    it 'splits correctly even when the number is too long' do
      expect(@splitter.split('44364353211')).to eq(['0', '44', '364353211'])
    end
    it 'splits correctly even when the number is too short' do
      expect(@splitter.split('443')).to eq(['0', '44','3'])
    end
  end
  describe 'split' do
    before(:each) do
      @splitter = Phony::NationalSplitters::Fixed.new nil
    end
    it 'splits correctly' do
      expect(@splitter.split('443643532')).to eq(['0', '443643532'])
    end
    it 'splits correctly even when the number is too long' do
      expect(@splitter.split('44364353211')).to eq(['0', '44364353211'])
    end
    it 'splits correctly even when the number is too short' do
      expect(@splitter.split('443')).to eq(['0', '443'])
    end
  end
  
end