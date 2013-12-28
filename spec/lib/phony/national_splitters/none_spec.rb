require 'spec_helper'

describe Phony::NationalSplitters::None do
  
  describe 'instance_for' do
    it 'caches' do
      expect(described_class.instance_for).to equal(described_class.instance_for)
    end
  end
  
  describe 'split' do
    let(:splitter) { described_class.instance_for }
    it 'splits correctly into ndc and rest' do
      expect(splitter.split('123456789')).to eq([nil, false, '123456789'])
    end
  end
  
end