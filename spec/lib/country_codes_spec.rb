require 'spec_helper'

describe Phony::CountryCodes do
  
  describe 'split' do
    before(:all) do
      @countries = Phony::CountryCodes.new
    end
    it 'splits correctly' do
      @countries.split('41443643532').should == ['41', '44', '364', '35', '32']
    end
  end
  
end