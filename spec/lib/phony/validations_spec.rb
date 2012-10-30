# encoding: utf-8
#
require 'spec_helper'

describe 'validations' do

  describe 'plausible?' do
    
    it 'does not change the given number' do
      number = "123-123-1234"
      
      Phony.plausible? number
      
      number.should == '123-123-1234'
    end
    
    it 'handles small numbers' do
      Phony.plausible?('353').should be_false
    end

    # TODO
    # it 'is correct' do
    #   Phony.plausible?('+1911').should be_false
    # end
    it "correctly plausibilizes to#{}do countries" do
      Phony.plausible?('6327332350').should be_true
    end
    it 'is correct' do
      Phony.plausible?('45 44 11 22 33').should be_true
    end
    it 'is correct' do
      Phony.plausible?('+4231231212').should be_true
    end
    it 'is correct' do
      Phony.plausible?('010').should be_false
    end
    it 'is correct' do
      Phony.plausible?("+460000").should be_false
    end
    it 'is correct' do
      Phony.plausible?('0000000').should be_false
    end
    it 'is correct' do
      Phony.plausible?('hello').should be_false
    end
    
    it "is correct" do
      Phony.plausible?('+41 44 111 22 33').should be_true
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', cc: '41').should be_true
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', ndc: '44').should be_true
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', cc: '1').should be_false
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', ndc: '43').should be_false
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', cc: '41', ndc: '44').should be_true
    end
    it "works with regexps" do
      Phony.plausible?('+41 44 111 22 33', cc: /4(0|2)/, ndc: /4(4|5)/).should be_false
    end
    it "works with regexps" do
      Phony.plausible?('+41 44 111 22 33', cc: /4(0|1)/, ndc: /4(4|5)/).should be_true
    end
    
    context 'specific countries' do


      # TODO: more needs to be done here
      #
      it "is correct for Swiss numbers" do
        Phony.plausible?('+41 44 111 22 33').should be_true
        Phony.plausible?('+41 44 111 22 334').should be_false
        Phony.plausible?('+41 44 111 22').should be_false

      end

      it "is correct for Danish numbers" do
        Phony.plausible?('+45 44 11 12 23 34').should be_false
        Phony.plausible?('+45 44 11 12 2').should be_false
        Phony.plausible?('+45 44 55 22 33').should be_true
      end


      
      it "is correct for US numbers" do
        # Sorry, still need E164 conform numbers.
        #
        Phony.plausible?('4346667777', cc: '1').should be_false
        
        # Automatic country checking.
        #
        Phony.plausible?('1-4346667777').should be_true
        Phony.plausible?('1-800-692-7753').should be_true
        Phony.plausible?('1-911').should be_false
        Phony.plausible?('1-911-123-1234').should be_false
        Phony.plausible?('143466677777').should be_false # too long
        Phony.plausible?('143466677').should be_false # too short


        
        # With string constraints.
        #
        Phony.plausible?('14346667777', cc: '1').should be_true
        Phony.plausible?('14346667777', ndc: '434').should be_true
        Phony.plausible?('14346667777', cc: '1', ndc: '434').should be_true
        
        # With regexp constraints.
        #
        Phony.plausible?('14346667777', cc: /[123]/).should be_true
        Phony.plausible?('14346667777', ndc: /434|435/).should be_true
        Phony.plausible?('14346667777', cc: /[123]/, ndc: /434|435/).should be_true
      end
      
    end
    
  end
  
end