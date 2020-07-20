require 'spec_helper'

describe Phony::NormalizationError do
  it 'is correctly raised on normalize' do
    expect do
      Phony.normalize('000')
    end.to raise_error(Phony::NormalizationError)
  end
  it 'is correctly raised on normalize' do
    expect do
      Phony.normalize('000')
    end.to raise_error(%Q{Phony could not normalize the given number. Is it a phone number?})
  end
  it 'is correctly raised on normalize!' do
    expect do
      Phony.normalize!('000')
    end.to raise_error(Phony::NormalizationError)
  end
  it 'is correctly raised on normalize!' do
    expect do
      Phony.normalize!('000')
    end.to raise_error(%Q{Phony could not normalize the given number. Is it a phone number?})
  end
end

describe Phony::SplittingError do
  it 'is correctly raised on split' do
    expect do
      Phony.split('000')
    end.to raise_error(Phony::SplittingError)
  end
  it 'is correctly raised on split' do
    expect do
      Phony.split('000')
    end.to raise_error(%Q{Phony could not split the given number. Is "000" a phone number?})
  end
  it 'is correctly raised on split!' do
    expect do
      Phony.split!('000')
    end.to raise_error(Phony::SplittingError)
  end
  it 'is correctly raised on split!' do
    expect do
      Phony.split!('000')
    end.to raise_error(%Q{Phony could not split the given number. Is it a phone number?})
  end
end

describe Phony::FormattingError do
  it 'is correctly raised on format' do
    expect do
      Phony.format('000')
    end.to raise_error(Phony::FormattingError)
  end
  it 'is correctly raised on format' do
    expect do
      Phony.format('000')
    end.to raise_error(%Q{Phony could not format the given number. Is it a phone number?})
  end
  it 'is correctly raised on format!' do
    expect do
      Phony.format!('000')
    end.to raise_error(Phony::FormattingError)
  end
  it 'is correctly raised on format!' do
    expect do
      Phony.format!('000')
    end.to raise_error(%Q{Phony could not format the given number. Is it a phone number?})
  end
end