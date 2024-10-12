require 'spec_helper'

describe Phony::LocalSplitters::Fixed do
  describe 'instance_for' do
    it 'caches' do
      described_class.instance_for([3, 2, 2]).should equal(described_class.instance_for([3, 2, 2]))
    end

    it 'caches correctly' do
      described_class.instance_for([1, 2, 3]).should_not equal(described_class.instance_for([9, 9, 9]))
    end

    it 'caches correctly' do
      described_class.instance_for.should equal(described_class.instance_for)
    end
  end

  describe 'split' do
    context 'without format' do
      before do
        @splitter = described_class.new
      end

      it 'splits correctly' do
        @splitter.split('3643532').should == %w[364 35 32]
      end

      it 'splits correctly even when the number is too long (but leniently)' do
        @splitter.split('3643532111').should == %w[364 35 32111]
      end

      it 'splits correctly even when the number is too short' do
        @splitter.split('364353').should == %w[364 35 3]
      end
    end

    context 'with format' do
      before do
        @splitter = described_class.new [3, 2, 2]
      end

      it 'splits correctly' do
        @splitter.split('3643532').should == %w[364 35 32]
      end

      it 'splits correctly even when the number is too long (but leniently)' do
        @splitter.split('3643532111').should == %w[364 35 32111]
      end

      it 'splits correctly even when the number is too short' do
        @splitter.split('364353').should == %w[364 35 3]
      end
    end

    context 'with hard number (iceland regression)' do
      before do
        @splitter = described_class.new [3, 4]
      end

      it 'splits correctly' do
        @splitter.split('112').should == ['112']
      end
    end
  end
end
