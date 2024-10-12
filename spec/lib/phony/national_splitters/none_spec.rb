require 'spec_helper'

describe Phony::NationalSplitters::None do

  describe 'instance_for' do
    it 'caches' do
      expect(described_class.instance_for).to eq described_class.instance_for
    end
  end

  context 'with instance' do
    let(:splitter) { described_class.instance_for }

    describe 'split' do
      it 'splits correctly into ndc and rest' do
        expect(splitter.split('123456789')).to eq [nil, false, '123456789']
      end
    end

    describe 'length' do
      it 'is always 0' do
        expect(splitter.length).to be_zero
      end
    end

  end

end
