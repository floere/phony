require 'spec_helper'

describe 'Issues' do

  describe '#136' do
    
    it 'is correct for country 39' do
      Phony.normalize('+39 393 0000000').should == '393930000000'
    end
    
    it 'fixes #136' do
      italia = Phony['39']
      italia.normalize('363 000000').should == '363000000'
    end

    it 'is correct for country 46' do
      Phony.normalize('+46 (0)46 222 0000').should == '46462220000'
    end
    
  end
  
end