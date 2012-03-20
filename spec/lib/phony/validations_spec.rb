# encoding: utf-8
#
require 'spec_helper'

describe 'validations' do

  describe 'plausible?' do

    it "is correct" do
      Phony.plausible?('0000000').should be_false
    end
    it "is correct" do
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
      
      # TODO
      #
      # it "is correct for Swiss numbers" do
      #   Phony.plausible?('+41 44 111 22 33').should be_true
      # end
      
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