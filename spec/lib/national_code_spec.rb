require 'spec_helper'

describe Phony::NationalCode do
  
  describe 'split' do
    context 'with fixed ndc (Swiss)' do
      before(:each) do
        national_splitter = Phony::NationalSplitters::Fixed.instance_for 2
        local_splitter    = Phony::LocalSplitter.instance_for [3, 2, 2]
        
        @national         = Phony::NationalCode.new national_splitter, local_splitter
      end
      it 'splits correctly' do
        @national.split('443643532').should == ['44', '364', '35', '32']
      end
      it 'splits correctly' do
        @national.split('44364353').should == ['44', '364', '35', '3']
      end
    end
    context 'with fixed ndc (French)' do
      before(:each) do
        national_splitter = Phony::NationalSplitters::Fixed.instance_for 1
        local_splitter    = Phony::LocalSplitter.instance_for [2, 2, 2, 2]
        
        @national         = Phony::NationalCode.new national_splitter, local_splitter
      end
      it 'splits correctly' do
        @national.split('142278186').should == ['1', '42', '27', '81', '86']
      end
      it 'splits correctly' do
        @national.split('14227818').should == ['1', '42', '27', '81', '8']
      end
    end
  end
  
end