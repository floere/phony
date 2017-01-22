# encoding: utf-8
#
require 'spec_helper'

describe Phony::Vanity do
  
  let(:vanity) { described_class }

  describe '.replace' do
    it 'replaces letters with digits' do
      vanity.replace('1-800-HELLO').should == '1-800-43556'
    end
  end
  
  describe '.vanity?' do
    it 'returns true on a vanity number' do
      vanity.vanity?('800HELLOES').should == true
    end
    it 'returns false on a non-vanity number' do
      vanity.vanity?('8004355637').should == false
    end
  end
  
  describe '.normalized' do
    it 'normalizes the vanity number' do
      vanity.normalized('1-800-HELLO').should == '1800HELLO'
    end
  end

end