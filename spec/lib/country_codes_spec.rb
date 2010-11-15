require 'spec_helper'

describe Phony::CountryCodes do
  
  before(:all) do
    @countries = Phony::CountryCodes.new
  end
  
  describe 'split' do
    it 'splits correctly' do
      @countries.split('41443643532').should == ['41', '44', '364', '35', '32']
    end
  end
  
  describe 'remove_relative_zeros' do
    it "should remove an ndc zero from an almost normalized number and return it" do
      @countries.remove_relative_zeros!('410443643533').should == '41443643533'
    end
  end
  
  describe 'formatted' do
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international, :spaces => :-).should == '+41-44-364-35-32'
    end
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :international_relative, :spaces => :-).should == '0041-44-364-35-32'
    end
    it 'formats correctly' do
      @countries.formatted('41443643532', :format => :national, :spaces => :-).should == '044-364-35-32'
    end
    
  end
  
end