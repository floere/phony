require 'spec_helper'

describe 'Phony.normalize' do

  describe 'cases' do
    
    it 'handles the US (with cc) correctly' do
      Phony.normalize('+1 724 999 9999').should == '17249999999'
    end
    it 'handles the US (with cc and cc option) correctly' do
      Phony.normalize('+1 724 999 9999', cc: '1').should == '17249999999'
    end
    it 'handles the US (without cc) correctly' do
      Phony.normalize('(310) 555-2121', cc: '1').should == '13105552121'
    end
    
  end
  
end