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


      it 'is correct for egyptian numbers' do
        Phony.plausible?('+20 800 1234567').should be_true
        Phony.plausible?('+20 800 12345678').should be_false
        Phony.plausible?('+20 2 12345678').should be_true
        Phony.plausible?('+20 2 1234567').should be_false
        Phony.plausible?('+20 40 12345678').should be_true
        Phony.plausible?('+20 40 1234567').should be_false
      end

      it 'is correct for Dutch numbers' do
        Phony.plausible?('+31 6 12 34 56 78').should be_true
        Phony.plausible?('+31 6 12 34 56 7').should be_false
        Phony.plausible?('+31 20 123 5678').should be_true
        Phony.plausible?('+31 20 123 567').should be_false
        Phony.plausible?('+31 221 123 567').should be_true
        Phony.plausible?('+31 221 123 56').should be_false
      end
      it 'is correct for Nigerian numbers' do
        Phony.plausible?('+234 807 766 1234').should be_true
        Phony.plausible?('+234 807 766 123').should be_false
      end
      it 'is correct for Italian numbers' do
        Phony.plausible?('+39 06 123 4567').should be_true
        Phony.plausible?('+39 335 123 4567').should be_true
        Phony.plausible?('+39 335 123').should be_false
      end
      it 'is correct for German numbers' do
        Phony.plausible?('+49 40 123 45678').should be_true
        Phony.plausible?('+49 40 123 456789').should be_false
        Phony.plausible?('+49 171 123 456789').should be_true
        Phony.plausible?('+49 171 123').should be_false
        # Phony.plausible?('+49 991 1234').should be_true   # stricter 3 digit ndc rules
        Phony.plausible?('+49 2041 123').should be_true
        Phony.plausible?('+49 2041 1234567').should be_true
        Phony.plausible?('+49 2041 12345689').should be_false
        Phony.plausible?('+49 31234 123456').should be_true
        Phony.plausible?('+49 31234 1234567').should be_false
      end

      it 'is correct for Isralian numbers' do
        Phony.plausible?('+972 2 123 1234').should be_true
        Phony.plausible?('+972 59 123 1234').should be_true
      end

      it 'is correct for Iraqi numbers' do
        Phony.plausible?('+964 75 5123 4567').should be_true
        Phony.plausible?('+964 1 123 4567').should be_true
        Phony.plausible?('+964 50 123 456').should be_true
        Phony.plausible?('+964 75 5123 45678').should be_false
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

      it "is correct for Portugese numbers" do
        Phony.plausible?('+351 800 123456').should be_true
        Phony.plausible?('+351 90 1234567').should be_true
        Phony.plausible?('+351 90 123456').should be_false
        Phony.plausible?('+351 123 1234567').should be_true

      end
    end
    
  end
  
end
