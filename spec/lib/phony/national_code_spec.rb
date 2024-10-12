require 'spec_helper'

describe Phony::NationalCode do
  
  describe 'split' do
    context 'regression' do
      describe 'iceland' do
        let(:national) do
          national_splitter = Phony::NationalSplitters::None.instance_for
          local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 4]

          Phony::NationalCode.new national_splitter, local_splitter
        end
        it 'splits correctly' do
          expect(national.split('112')).to eq [nil, false, '112']
        end
      end
    end

    context 'with fixed ndc (Swiss)' do
      let(:national) do
        national_splitter = Phony::NationalSplitters::Fixed.instance_for 2
        local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
        
        Phony::NationalCode.new national_splitter, local_splitter
      end
      it 'splits correctly' do
        expect(national.split('443643532')).to eq [nil, '44', '364', '35', '32']
      end
      it 'splits correctly' do
        expect(national.split('44364353')).to eq [nil, '44', '364', '35', '3']
      end
      it 'normalizes correctly' do
        expect(national.normalize('044364353')).to eq '44364353'
      end
      it 'normalizes correctly' do
        expect(national.normalize('44364353')).to eq '44364353'
      end
    end

    context 'with fixed ndc (French)' do
      let(:national) do
        national_splitter = Phony::NationalSplitters::Fixed.instance_for 1
        local_splitter    = Phony::LocalSplitters::Fixed.instance_for [2, 2, 2, 2]
        
        Phony::NationalCode.new national_splitter, local_splitter
      end
      it 'splits correctly' do
        expect(national.split('142278186')).to eq [nil, '1', '42', '27', '81', '86']
      end
      it 'splits correctly' do
        expect(national.split('14227818')).to eq [nil, '1', '42', '27', '81', '8']
      end
      it 'normalizes correctly' do
        expect(national.normalize('0142278186')).to eq '142278186'
      end
      it 'normalizes correctly' do
        expect(national.normalize('142278186')).to eq '142278186'
      end
    end
  end
  
end