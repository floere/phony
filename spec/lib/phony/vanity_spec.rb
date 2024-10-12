#
require 'spec_helper'

describe Phony::Vanity do
  let(:vanity) { described_class }

  describe '.replace' do
    it 'replaces letters with digits' do
      expect(vanity.replace('1-800-HELLO')).to eq '1-800-43556'
    end
  end

  describe '.vanity?' do
    it 'returns true on a vanity number' do
      expect(vanity.vanity?('800HELLOES')).to eq true
    end

    it 'returns false on a non-vanity number' do
      expect(vanity.vanity?('8004355637')).to eq false
    end
  end

  describe '.normalized' do
    it 'normalizes the vanity number' do
      expect(vanity.normalized('1-800-HELLO')).to eq '1800HELLO'
    end
  end
end
