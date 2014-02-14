require 'spec_helper'

describe 'Issues' do

  describe '#136' do
    
    it 'is correct for country 39' do
      Phony.normalize('+39 393 0000000').should == '393930000000'
    end

    it 'is correct for country 46' do
      Phony.normalize('+46 (0)46 222 0000').should == '46462220000'
    end
    
  end
  
end