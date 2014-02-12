# encoding: utf-8
#
require 'spec_helper'

describe Phony::Vanity do
  
  describe "vanity?" do
    it 'recognizes a vanity number' do
      expect(Phony::Vanity.vanity?('800HELLOWORLD')).to eq(true)
    end
    it 'recognizes a non vanity number' do
      expect(Phony::Vanity.vanity?('444443322')).to eq(false)
    end
  end
  
  describe "replace" do
    it 'replaces all characters' do
      expect(Phony::Vanity.replace('0123456789abcdefghijklmnopqrstuvwxyz')).to eq('012345678922233344455566677778889999')
    end
  end
  
  describe 'mapping' do
    it 'caches' do
      expect(Phony::Vanity.mapping).to equal(Phony::Vanity.mapping)
    end
    it 'returns the right thing' do
      expect(Phony::Vanity.mapping).to eq([
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.freeze,
        '2223334445556667777888999922233344455566677778889999'.freeze
      ])
    end
  end
  
end