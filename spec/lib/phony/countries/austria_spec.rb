require 'spec_helper'

describe Phony::Countries::Austria do
  
  before(:each) do
    @austria = Phony::Countries::Austria.new
  end
  
  describe "split" do
    it "should handle Vienna" do
      @austria.split('198110').should == ['1', '98110']
    end
    it "should handle some mobile services" do
      @austria.split('66914093902').should == ['669', '14093902']
    end
    it "should handle Graz" do
      @austria.split('3161234567891').should == ['316', '1234567891']
    end
    it "should handle Rohrau" do
      @austria.split('2164123456789').should == ['2164', '123456789']
    end
  end
  
end