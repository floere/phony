require 'spec_helper'

describe 'Phony.normalize' do

  describe 'cases' do
    
    it 'handles the US (with cc) correctly' do
      Phony.normalize('+1 724 999 9999').should == '17249999999'
    end
    it 'handles the Dutch number (without US cc) correctly' do
      Phony.normalize('310 5552121').should == '315552121'
    end
    it 'handles the US (with cc and cc option) correctly' do
      Phony.normalize('+1 724 999 9999', cc: '1').should == '17249999999'
    end
    it 'handles the US (without cc) correctly' do
      Phony.normalize('(310) 555-2121', cc: '1').should == '13105552121'
    end
    it 'handles a German number with extra (0)' do
      Phony.normalize('+49 (0) 209 22 33 44 55').should == '4920922334455'
    end
    it 'handles a German number with extra 0' do
      Phony.normalize('+49 0 209 22 33 44 55').should == '4920922334455'
    end
  end
  
end