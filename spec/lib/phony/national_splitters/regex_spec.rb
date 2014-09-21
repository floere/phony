require 'spec_helper'

describe Phony::NationalSplitters::Regex do
  
  describe 'instance_for' do
    it 'caches correctly (not)' do
      described_class.instance_for(//).should_not equal(described_class.instance_for(//))
    end
  end
  
  describe 'split' do
    context 'without on_fail' do
      let(:splitter) { described_class.instance_for(/^(123)\d+$/) }
    end
    context 'with on_fail 2' do
      let(:splitter) { described_class.instance_for(/^(123)\d+$/, 2) }
      it 'uses the on_fail_take' do
        splitter.split('23456789').should == [nil, '23', '456789']
      end
    end
  end
  
end