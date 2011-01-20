require 'spec_helper'

describe Phony::Countries::Belgium do
  
  before(:each) do
    @belgium = Phony::Countries::Belgium
  end
  
  describe "split" do
    it "should handle Antwerpen" do
      @belgium.split('35551212').should == ['3', '555', '1212']
    end
    it "should handle Brugge" do
      @belgium.split('505551212').should == ['50', '555', '1212']
    end
    it "should handle Brussels" do
      @belgium.split('25551212').should == ['2', '555', '1212']
    end
    it "should handle Gent" do
      @belgium.split('95551914').should == ['9', '555', '1914']
    end
    it "should handle Liège" do
      @belgium.split('45551414').should == ['4', '555', '1414']
    end
    it "should handle some mobile services" do
      @belgium.split('475279584').should == ['475', '279584']
    end

  end
end
