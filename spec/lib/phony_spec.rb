# encoding: utf-8
#
require 'spec_helper'

describe Phony do

  describe 'safe_format' do
    it 'formats number' do
      Phony.safe_format("1234567890").should eq("+1 (234) 567-890")
    end

    it 'returns the given argument when formatting fails' do
      Phony.safe_format("sip:41441234567@example.com").should eq("sip:41441234567@example.com")
    end

    it 'returns nils too' do
      Phony.safe_format(nil).should eq(nil)
    end
  end

end
