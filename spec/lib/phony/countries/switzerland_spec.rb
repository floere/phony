require 'spec_helper'

describe 'Switzerland' do
  
  before(:each) do
    @switzerland = Phony::Countries.with_cc '41'
  end
  
  describe "split" do
    it "works" do
      @switzerland.split('443643532').should == ['44', '364', '35', '32']
    end
    it "works" do
      @switzerland.split('800123456').should == ['800', '123', '456']
    end
  end
  
end