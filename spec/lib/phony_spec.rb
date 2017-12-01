require 'spec_helper'

describe Phony do
  
  describe described_class::NormalizationError do
    it 'is correctly raised on normalize' do
      expect do
        described_class.normalize('000')
      end.to raise_error(described_class::NormalizationError)
    end
    it 'is correctly raised on normalize' do
      expect do
        described_class.normalize('000')
      end.to raise_error(%Q{Phony could not normalize the given number. Is it a phone number?})
    end
    it 'is correctly raised on normalize!' do
      expect do
        described_class.normalize!('000')
      end.to raise_error(described_class::NormalizationError)
    end
    it 'is correctly raised on normalize!' do
      expect do
        described_class.normalize!('000')
      end.to raise_error(%Q{Phony could not normalize the given number. Is it a phone number?})
    end
  end

  describe described_class::SplittingError do
    it 'is correctly raised on split' do
      expect do
        described_class.split('000')
      end.to raise_error(described_class::SplittingError)
    end
    it 'is correctly raised on split' do
      expect do
        described_class.split('000')
      end.to raise_error(%Q{Phony could not split the given number. Is "000" a phone number?})
    end
    it 'is correctly raised on split!' do
      expect do
        described_class.split!('000')
      end.to raise_error(described_class::SplittingError)
    end
    it 'is correctly raised on split!' do
      expect do
        described_class.split!('000')
      end.to raise_error(%Q{Phony could not split the given number. Is it a phone number?})
    end
  end
  
  describe described_class::FormattingError do
    it 'is correctly raised on format' do
      expect do
        described_class.format('000')
      end.to raise_error(described_class::FormattingError)
    end
    it 'is correctly raised on format' do
      expect do
        described_class.format('000')
      end.to raise_error(%Q{Phony could not format the given number. Is it a phone number?})
    end
    it 'is correctly raised on format!' do
      expect do
        described_class.format!('000')
      end.to raise_error(described_class::FormattingError)
    end
    it 'is correctly raised on format!' do
      expect do
        described_class.format!('000')
      end.to raise_error(%Q{Phony could not format the given number. Is it a phone number?})
    end
  end
  
end