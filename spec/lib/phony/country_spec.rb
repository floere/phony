require 'spec_helper'

describe Phony::Country do
  
  describe "configured" do
    context "with variable ndcs" do
      before(:each) do
        @country = Phony::Country.configured :local_format         => [3, 2, 2],
                                             :service_local_format => [3, 3],
                                             :mobile_local_format  => [1, 2, 4],
                                             :ndc_fallback_length  => 4,
                                             :ndc_mapping => {
                                               :normal  => ['44'],
                                               :service => ['800'],
                                               :mobile  => ['76']
                                             }
      end
      it 'works for normal numbers' do
        @country.split('443643532').should == ['44', '364', '35', '32']
      end
      it 'works with service numbers' do
        @country.split('800333666').should == ['800', '333', '666']
      end
      it 'works with mobile numbers' do
        @country.split('764333532').should == ['76', '4', '33', '3532']
      end
      it 'uses the fallback if it is not in the mapping' do
        @country.split('123456789').should == ['1234', '567', '89']
      end
    end
    context "with fixed ndcs" do
      before(:each) do
        @country = Phony::Country.fixed :ndc_length           => 2,
                                        :local_format         => [3, 2, 2],
                                        :service_local_format => [3, 3],
                                        :service_ndcs         => ['800']
      end
      it 'works for non-service numbers' do
        @country.split('443643532').should == ['44', '364', '35', '32']
      end
      it 'works for service numbers' do
        @country.split('800333666').should == ['800', '333', '666']
      end
      it 'works with mobile numbers' do
        @country.split('764333532').should == ['76', '433', '35', '32']
      end
      it 'uses a fixed length' do
        @country.split('123456789').should == ['12', '345', '67', '89']
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
    describe 'normalize' do
      it "should handle ZH" do
        @switzerland.normalize('0443643532').should == '443643532'
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
      special_code              = Phony::NationalCode.new special_national_splitter, special_local_splitter
      
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