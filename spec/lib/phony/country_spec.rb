require 'spec_helper'

describe Phony::Country do
  
  describe "configured" do
    context "with variable ndcs" do
      before(:each) do
        @country = Phony::Country.configured :local_format         => [3, 2, 2],
                                             :special_local_format => [3, 3],
                                             :ndc_fallback_length  => 4,
                                             :ndc_mapping => {
                                               :normal  => ['44'],
                                               :service => ['800'],
                                               :mobile  => ['76']
                                             }
      end
    end
    context "with fixed ndcs" do
      before(:each) do
        @country = Phony::Country.fixed :ndc_length => 4,
                                        :local_format => [3, 2, 2],
                                        :special_local_format => [3, 3],
                                        :special_ndc_mapping => {
                                           :service => ['800'],
                                           :mobile  => ['76']
                                         }
                                        
      end
    end
  end
  
  context "without special cases" do
    before(:each) do
      national_splitter = Phony::NationalSplitters::Variable.new 4, { :normal => ['44'] }
      local_splitter    = Phony::LocalSplitter.instance_for [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter
      
      @switzerland      = Phony::Country.new national_code
    end
    
    describe "split" do
      it "should handle ZH" do
        @switzerland.split('443643532').should == ['44', '364', '35', '32']
      end
    end
  end
  
  context "without special cases" do
    before(:each) do
      national_splitter         = Phony::NationalSplitters::Variable.new 4, { :normal => ['44'] }
      local_splitter            = Phony::LocalSplitter.instance_for [3, 2, 2]
      national_code             = Phony::NationalCode.new national_splitter, local_splitter
      
      special_national_splitter = Phony::NationalSplitters::Variable.new nil, { :service => ['800'] }
      special_local_splitter    = Phony::LocalSplitter.instance_for [3, 3]
      special_code              = Phony::SpecialCode.new special_national_splitter, special_local_splitter
      
      @switzerland              = Phony::Country.new national_code, special_code
    end
    
    describe "split" do
      it "should handle ZH" do
        @switzerland.split('443643532').should == ['44', '364', '35', '32']
      end
      it "should handle 800" do
        @switzerland.split('800333666').should == ['800', '333', '666']
      end
    end
  end
  
end