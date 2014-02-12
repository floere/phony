require 'spec_helper'

describe Phony::LocalSplitters::Regex do
  
  describe 'instance_for' do
    it 'does not cache' do
      expect(described_class.instance_for({})).not_to equal(described_class.instance_for({}))
    end
  end
  
  describe 'split' do
    before(:each) do
      # Norway as example.
      #
      @splitter = described_class.instance_for /^[489].*$/ => [3,2,3], :fallback => [2,2,2,2]
    end
    it 'splits a number correctly' do
      expect(@splitter.split('21234567')).to eq(['21','23','45','67'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('31234567')).to eq(['31','23','45','67'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('41234567')).to eq(['412','34','567'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('51234567')).to eq(['51','23','45','67'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('61234567')).to eq(['61','23','45','67'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('71234567')).to eq(['71','23','45','67'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('81234567')).to eq(['812','34','567'])
    end
    it 'splits a number correctly' do
      expect(@splitter.split('91234567')).to eq(['912','34','567'])
    end
    it 'splits it fast' do
      expect(performance_of { expect(@splitter.split('21234567')).to eq(['21','23','45','67']) }).to be < 0.00005
    end
    it 'splits it fast' do
      expect(performance_of { expect(@splitter.split('91234567')).to eq(['912','34','567']) }).to be < 0.00004
    end
  end

  describe 'plausible?' do
    let(:number) {['123', '456']}
    let(:result) { local_splitter.plausible?(number) }

    context 'Local splitter without mappings' do
      let(:local_splitter) { described_class.instance_for({})}
      it 'returns false' do
        expect(result).to be false
      end
    end

    context 'Mapping does not exist for a number' do
      let(:local_splitter) { described_class.instance_for /\A5/ => [1,2,3]}
      it 'returns false' do
        expect(result).to be false
      end
    end

    context "Mapping exists, but the length is greater" do
      let(:local_splitter) { described_class.instance_for /\A123/ => [2,2]}
      it 'returns false' do
        expect(result).to be false
      end
    end

    context "Mapping exists, but the length is less" do
      let(:local_splitter) { described_class.instance_for /\A123/ => [2,2,3]}
      it 'returns false' do
        expect(result).to be false
      end
    end

    context 'Mapping exists and the length is equal' do
      let(:local_splitter) { described_class.instance_for /\A123/ => [2,2,2]}
      it 'returns true' do
        expect(result).to be true
      end
    end

  end
  
end