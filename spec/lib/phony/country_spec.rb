require 'spec_helper'

describe Phony::Country do
  
  context 'regression' do
    describe 'iceland' do
      before(:each) do
        national_splitter = Phony::NationalSplitters::None.instance_for
        local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 4]

        national_code     = Phony::NationalCode.new national_splitter, local_splitter
        @iceland          = described_class.new national_code
      end
      it 'splits correctly' do
        expect(@iceland.split('112')).to eq([nil, false, '112'])
      end
    end
  end
  
  context "without special cases" do
    before(:each) do
      national_splitter = Phony::NationalSplitters::Variable.new 4, ['44']
      local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter
      
      @switzerland      = Phony::Country.new national_code
      @switzerland.with '41' # TODO Remove this kludge.
    end
    
    describe "split" do
      it "should handle ZH" do
        expect(@switzerland.split('443643532')).to eq(['0', '44', '364', '35', '32'])
      end
    end
    describe 'normalize' do
      it "should handle ZH" do
        expect(@switzerland.normalize('0443643532')).to eq('41443643532')
      end
    end
  end
  
  context "without special cases" do
    before(:each) do
      special_national_splitter = Phony::NationalSplitters::Variable.new nil, ['800']
      special_local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 3]
      special_code              = Phony::NationalCode.new special_national_splitter, special_local_splitter
      
      national_splitter         = Phony::NationalSplitters::Variable.new 4, ['44']
      local_splitter            = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
      national_code             = Phony::NationalCode.new national_splitter, local_splitter
      
      @switzerland              = Phony::Country.new special_code, national_code
    end
    
    describe "split" do
      it "should handle ZH" do
        expect(@switzerland.split('443643532')).to eq(['0', '44', '364', '35', '32'])
      end
      it "should handle 800" do
        expect(@switzerland.split('800333666')).to eq(['0', '800', '333', '666'])
      end
    end
  end
  
end
