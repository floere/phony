require 'spec_helper'

describe Phony::SpecialCode do
  
  describe 'split' do
    before(:each) do
      options = {
        :service => %w{800 840 842 844 848},
        :mobile  => %w{74 76 77 78 79},
        :local_format => [3, 3]
      }
      @splitter = Phony::SpecialCode.new options
    end
    it 'splits correctly' do
      @splitter.split('800333666').should == ['800', '333', '666']
    end
    it 'splits correctly' do
      @splitter.split('123456789').should == [nil, nil]
    end
  end
  
end