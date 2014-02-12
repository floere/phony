require 'spec_helper'

describe 'Phony.normalize' do

  describe 'cases' do
    
    it 'handles the US (with cc) correctly' do
      expect(Phony.normalize('+1 724 999 9999')).to eq('17249999999')
    end
    it 'handles the Dutch number (without US cc) correctly' do
      expect(Phony.normalize('310 5552121')).to eq('315552121')
    end
    it 'handles the US (with cc and cc option) correctly' do
      expect(Phony.normalize('+1 724 999 9999', cc: '1')).to eq('17249999999')
    end
    it 'handles the US (without cc) correctly' do
      expect(Phony.normalize('(310) 555-2121', cc: '1')).to eq('13105552121')
    end
    
  end
  
end