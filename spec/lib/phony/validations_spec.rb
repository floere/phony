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
    
    context 'countries' do
      
      it "is correct for US numbers" do
        Phony.plausible?('1-800-692-7753').should be_true
        Phony.plausible?('1-911').should be_false
      end
      
    end
    
  end
  
end