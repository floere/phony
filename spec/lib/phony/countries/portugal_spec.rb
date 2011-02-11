require 'spec_helper'

describe Phony::Countries::Portugal do
  
  before(:each) do
    @portugal = Phony::Countries::Portugal
  end
  
  describe "split" do
    it "works with Lisboa" do
      @portugal.split('211231234').should == ['21', '123', '1234']
    end
    it "works with Abrantes" do
      @portugal.split('241123123').should == ['241', '123', '123']
    end
    it 'works with a mobile' do
      @portugal.split('931231234').should == ['93', '123', '1234']
    end
  end
  
end