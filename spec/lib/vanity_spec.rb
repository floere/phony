# encoding: utf-8
#
require 'spec_helper'

describe Phony::Vanity do
  
  describe "replace" do
    it 'replaces all characters' do
      Phony::Vanity.replace('0123456789abcdefghijklmnopqrstuvwxyz').should == '012345678922233344455566677778889999'
    end
  end
  
  describe 'mapping' do
    it 'caches' do
      Phony::Vanity.mapping.should equal(Phony::Vanity.mapping)
    end
    it 'returns the right thing' do
      Phony::Vanity.mapping.should == [
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.freeze,
        '2223334445556667777888999922233344455566677778889999'.freeze
      ]
    end
  end
  
end