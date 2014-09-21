require 'spec_helper'

describe Phony::NationalCode do
  
  describe 'split' do
    context 'regression' do
      describe 'iceland' do
        before(:each) do
          national_splitter = Phony::NationalSplitters::None.instance_for
          local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 4]

          @national         = Phony::NationalCode.new national_splitter, local_splitter
        end
        it 'splits correctly' do
          @national.split('112').should == [nil, false, '112']
        end
      end
    end
    context 'with fixed ndc (Swiss)' do
      before(:each) do
        national_splitter = Phony::NationalSplitters::Fixed.instance_for 2
        local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
        
        @national         = Phony::NationalCode.new national_splitter, local_splitter
      end
      it 'splits correctly' do
        @national.split('443643532').should == [nil, '44', '364', '35', '32']
      end
      it 'splits correctly' do
        @national.split('44364353').should == [nil, '44', '364', '35', '3']
      end
      it 'normalizes correctly' do
        @national.normalize('044364353').should == '44364353'
      end
      it 'normalizes correctly' do
        @national.normalize('44364353').should == '44364353'
      end
    end
    context 'with fixed ndc (French)' do
      before(:each) do
        national_splitter = Phony::NationalSplitters::Fixed.instance_for 1
        local_splitter    = Phony::LocalSplitters::Fixed.instance_for [2, 2, 2, 2]
        
        @national         = Phony::NationalCode.new national_splitter, local_splitter
      end
      it 'splits correctly' do
        @national.split('142278186').should == [nil, '1', '42', '27', '81', '86']
      end
      it 'splits correctly' do
        @national.split('14227818').should == [nil, '1', '42', '27', '81', '8']
      end
      it 'normalizes correctly' do
        @national.normalize('0142278186').should == '142278186'
      end
      it 'normalizes correctly' do
        @national.normalize('142278186').should == '142278186'
      end
    end
    # context 'normalizing' do
    #   context 'false' do
    #     before(:each) do
    #       @national = Phony::NationalCode.new nil, nil, false
    #     end
    #     it 'normalizes an italian case correctly' do
    #       @national.normalize('0909709511').should == '0909709511'
    #     end
    #   end
    #   context 'true' do
    #     before(:each) do
    #       national_splitter = Phony::NationalSplitters::Fixed.instance_for 2
    #       local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
    #       @national = Phony::NationalCode.new national_splitter, local_splitter, true
    #     end
    #     it 'normalizes a swiss case correctly' do
    #       @national.normalize('044364353').should == '44364353'
    #     end
    #   end
    #   context 'nil (true)' do
    #     before(:each) do
    #       national_splitter = Phony::NationalSplitters::Fixed.instance_for 2
    #       local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
    #       @national = Phony::NationalCode.new national_splitter, local_splitter, nil
    #     end
    #     it 'normalizes a swiss case correctly' do
    #       @national.normalize('044364353').should == '44364353'
    #     end
    #   end
    # end
  end
  
end