# frozen_string_literal: true

require 'spec_helper'

describe Phony::LocalSplitters::Fixed do
  describe 'instance_for' do
    it 'caches' do
      expect(described_class.instance_for([3, 2, 2])).to equal(described_class.instance_for([3, 2, 2]))
    end

    it 'caches correctly' do
      expect(described_class.instance_for([1, 2, 3])).not_to equal(described_class.instance_for([9, 9, 9]))
    end

    it 'caches correctly' do
      expect(described_class.instance_for).to equal(described_class.instance_for)
    end
  end

  describe 'split' do
    context 'without format' do
      let(:splitter) { described_class.new }

      it 'splits correctly' do
        expect(splitter.split('3643532')).to eq %w[364 35 32]
      end

      it 'splits correctly even when the number is too long (but leniently)' do
        expect(splitter.split('3643532111')).to eq %w[364 35 32111]
      end

      it 'splits correctly even when the number is too short' do
        expect(splitter.split('364353')).to eq %w[364 35 3]
      end
    end

    context 'with format' do
      let(:splitter) { described_class.new([3, 2, 2]) }

      it 'splits correctly' do
        expect(splitter.split('3643532')).to eq %w[364 35 32]
      end

      it 'splits correctly even when the number is too long (but leniently)' do
        expect(splitter.split('3643532111')).to eq %w[364 35 32111]
      end

      it 'splits correctly even when the number is too short' do
        expect(splitter.split('364353')).to eq %w[364 35 3]
      end
    end

    context 'with hard number (iceland regression)' do
      let(:splitter) { described_class.new([3, 4]) }

      it 'splits correctly' do
        expect(splitter.split('112')).to eq ['112']
      end
    end
  end
end
