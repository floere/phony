require 'spec_helper'

describe Phony::Countries::UnitedKingdom do
  
  before(:each) do
    @uk = Phony::Countries::UnitedKingdom
  end
  
  # Note: Many Specs
  #
  describe "split" do
    it "should handle London" do
      @uk.split('2045671113').should == ['20', '4567', '1113']
    end
    it "should handle Cardiff" do
      @uk.split('2076229901').should == ['20', '7622', '9901']
    end
    it "should handle Leeds" do
      @uk.split('1136770011').should == ['113', '677', '0011']
    end
    it "should handle Dundee" do
      @uk.split('1382229845').should == ['1382', '229845']
    end
    it "should handle Bolten" do
      @uk.split('120499532').should == ['1204', '99532']
    end
    it "should handle Sedbergh" do
      @uk.split('1539618756').should ==['15396', '18756']
    end
    it "should handle Mobile Numbers" do
      @uk.split('7780605207').should == ['7780', '605207']
    end
    it "should handle Mobile Numbers" do
      @uk.split('7480605207').should == ['7480', '605207']
    end
    it "should handle service numbers with 800 [regression]" do
      @uk.split('8005878323').should == ['800', '587', '8323']
    end
    #
    # 44 116 xxx xxxx Leicester
    # 44 131 xxx xxxx Edinburgh
    # 44 151 xxx xxxx Liverpool
    # 44 1382  xxxxxx Dundee
    # 44 1386  xxxxxx Evesham
    # 44 1865  xxxxxx Oxford
    # 44 153 96 xxxxx Sedbergh
    # 44 169 77  xxxx Brampton
  end
  
end