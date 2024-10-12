require 'spec_helper'

describe Phony::NationalSplitters::Default do
  describe 'instance_for' do
    it 'caches' do
      expect(described_class.instance_for).to equal(described_class.instance_for)
    end
  end

  context 'with instance' do
    let(:splitter) { described_class.instance_for }

    describe 'split' do
      it 'does only pretend split' do
        expect(splitter.split(:anything)).to eq [nil, :anything]
      end
    end

    describe 'plausible?' do
      it 'is always plausible' do
        expect(splitter.plausible?(:anything, :anything)).to be_truthy
      end
    end

    describe 'length' do
      it 'needs to be at least 3' do
        expect(splitter.length).to eq 3
      end
    end
  end
end
