require 'spec_helper'

describe Phony::Countries::Greece do
  
  before(:each) do
    @greece = Phony::Countries::Greece
  end
  
  describe "split" do
    it 'works' do
      @greece.split('21123456').should == ['21', '123456']
    end
    it 'works' do
      @greece.split('25941234').should == ['2594', '1234']
    end
  end
  
end