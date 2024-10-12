require 'spec_helper'

describe Phony::NationalSplitters::Fixed do
  describe 'instance_for' do
    it 'caches' do
      expect(Phony::NationalSplitters::Fixed.instance_for(3)).to eq Phony::NationalSplitters::Fixed.instance_for(3)
    end

    it 'caches correctly' do
      expect(Phony::NationalSplitters::Fixed.instance_for(1)).to_not eq Phony::NationalSplitters::Fixed.instance_for(2)
    end
  end

  describe 'split' do
    let(:splitter) { Phony::NationalSplitters::Fixed.new(2) }
    it 'splits correctly' do
      expect(splitter.split('443643532')).to eq [nil, '44', '3643532']
    end

    it 'splits correctly even when the number is too long' do
      expect(splitter.split('44364353211')).to eq [nil, '44', '364353211']
    end

    it 'splits correctly even when the number is too short' do
      expect(splitter.split('443')).to eq [nil, '44', '3']
    end

    it 'has a length of 2' do
      expect(splitter.length).to eq 2
    end
  end

  describe 'split' do
    let(:splitter) { Phony::NationalSplitters::Fixed.new(nil) }
    it 'splits correctly' do
      expect(splitter.split('443643532')).to eq [nil, '443643532']
    end

    it 'splits correctly even when the number is too long' do
      expect(splitter.split('44364353211')).to eq [nil, '44364353211']
    end

    it 'splits correctly even when the number is too short' do
      expect(splitter.split('443')).to eq [nil, '443']
    end

    it 'has a length of nil' do
      expect(splitter.length).to be nil
    end
  end
end
