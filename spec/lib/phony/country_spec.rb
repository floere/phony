require 'spec_helper'

describe Phony::Country do
  
  describe 'general' do
    let(:country) do
      national_splitter = Phony::NationalSplitters::Variable.new 4, ['44']
      local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter
      
      Phony::Country.new national_code
    end
    describe '#clean' do
      it 'cleans the number' do
        country.clean('+41-44-123-12-12').should eql '41441231212'
      end
    end
    describe '#vanity_to_number' do
      it 'turns the vanity number into a number' do
        country.vanity_to_number('1-800-HELLO').should eql '1-800-43556'
      end
    end
  end
  
  context 'regression' do
    describe 'Iceland' do
      let(:country) do
        national_splitter = Phony::NationalSplitters::None.instance_for
        local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 4]

        national_code     = Phony::NationalCode.new national_splitter, local_splitter
        described_class.new national_code
      end
      it 'splits correctly' do
        country.split('112').should == [nil, false, '112']
      end
    end
    describe 'San Marino' do
      it 'normalizes correctly' do
        Phony.normalize('+3780549903549').should == '3780549903549'
      end
      xit 'automatically adds the sole NC' do
        Phony.normalize('+378903549').should == '3780549903549'
      end
    end
  end
  
  context "without special cases (with switzerland)" do
    let(:country) do
      national_splitter = Phony::NationalSplitters::Variable.new 4, ['44']
      local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
      national_code     = Phony::NationalCode.new national_splitter, local_splitter
      
      Phony::Country.new national_code
    end
    
    describe "split" do
      it "should handle ZH" do
        country.split('443643532').should == [nil, '44', '364', '35', '32']
      end
    end
    describe 'normalize' do
      it "should handle ZH" do
        country.normalize('0443643532').should == '443643532'
      end
    end
  end
  
  context "without special cases" do
    let(:country) do
      special_national_splitter = Phony::NationalSplitters::Variable.new nil, ['800']
      special_local_splitter    = Phony::LocalSplitters::Fixed.instance_for [3, 3]
      special_code              = Phony::NationalCode.new special_national_splitter, special_local_splitter
      
      national_splitter         = Phony::NationalSplitters::Variable.new 4, ['44']
      local_splitter            = Phony::LocalSplitters::Fixed.instance_for [3, 2, 2]
      national_code             = Phony::NationalCode.new national_splitter, local_splitter
      
      Phony::Country.new special_code, national_code
    end
    
    describe "split" do
      it "should handle ZH" do
        country.split('443643532').should == [nil, '44', '364', '35', '32']
      end
      it "should handle 800" do
        country.split('800333666').should == [nil, '800', '333', '666']
      end
    end
  end
  
end
