require 'spec_helper'

describe Phony::TrunkCode do
  
  describe '#format' do
    it 'is correct' do
      code = described_class.new('0')
      expect(code.format('%s %s')).to eq '0'
    end
    it 'is correct' do
      code = described_class.new('0', format: true)
      expect(code.format('%s %s')).to eq '0'
    end
    it 'is correct' do
      code = described_class.new('0', format: false)
      expect(code.format('%s %s')).to eq nil
    end
    it 'is correct' do
      code = described_class.new('06')
      expect(code.format('%s %s')).to eq '06'
    end
    it 'is correct' do
      code = described_class.new('06', format: true)
      expect(code.format('%s %s')).to eq '06'
    end
    it 'is correct' do
      code = described_class.new('06', format: false)
      expect(code.format('%s %s')).to eq nil
    end
  end
  
  describe '#normalize' do
    it 'is correct' do
      code = described_class.new('0')
      expect(code.normalize('0123')).to eq '0123'
    end
    it 'is correct' do
      code = described_class.new('0', normalize: true)
      expect(code.normalize('0123')).to eq '0123'
    end
    it 'is correct' do
      code = described_class.new('0', normalize: false)
      expect(code.normalize('0123')).to eq '0123'
    end
    it 'is correct' do
      code = described_class.new('06')
      expect(code.normalize('06123')).to eq '06123'
    end
    it 'is correct' do
      code = described_class.new('06', normalize: true)
      expect(code.normalize('06123')).to eq '06123'
    end
    it 'is correct' do
      code = described_class.new('06', normalize: false)
      expect(code.normalize('0123')).to eq '0123'
    end
  end
  
  describe '#split' do
    it 'is correct' do
      code = described_class.new('0')
      expect(code.split('0123')).to eq [code, '0123']
    end
    it 'is correct' do
      code = described_class.new('0', split: true)
      expect(code.split('0123')).to eq [code, '123']
    end
    it 'is correct' do
      code = described_class.new('0', split: false)
      expect(code.split('0123')).to eq [code, '0123']
    end
    it 'is correct' do
      code = described_class.new('06')
      expect(code.split('06123')).to eq [code, '06123']
    end
    it 'is correct' do
      code = described_class.new('06', split: true)
      expect(code.split('06123')).to eq [code, '123']
    end
    it 'is correct' do
      code = described_class.new('06', split: false)
      expect(code.split('06123')).to eq [code, '06123']
    end
  end
end