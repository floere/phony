require 'spec_helper'

main = self

describe Phony::LocalSplitters::Regex do
  
  before do
    load 'spec_helper_extensions.rb'
    main.send :include, SpecHelperExtensions
  end
  
  describe 'instance_for' do
    it 'does not cache' do
      described_class.instance_for({}).should_not equal(described_class.instance_for({}))
    end
  end
  
  describe 'split' do
    before(:each) do
      # Norway as example.
      #
      @splitter = described_class.instance_for(/^[489].*$/ => [3,2,3], :fallback => [2,2,2,2])
    end
    it 'splits a number correctly' do
      @splitter.split('21234567').should == ['21','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('31234567').should == ['31','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('41234567').should == ['412','34','567']
    end
    it 'splits a number correctly' do
      @splitter.split('51234567').should == ['51','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('61234567').should == ['61','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('71234567').should == ['71','23','45','67']
    end
    it 'splits a number correctly' do
      @splitter.split('81234567').should == ['812','34','567']
    end
    it 'splits a number correctly' do
      @splitter.split('91234567').should == ['912','34','567']
    end
    it 'splits it fast' do
      performance_of { @splitter.split('21234567').should == ['21','23','45','67'] }.should < 0.00005
    end
    it 'splits it fast' do
      performance_of { @splitter.split('91234567').should == ['912','34','567'] }.should < 0.00004
    end
  end

  describe 'plausible?' do
    let(:number) {['123', '456']}
    let(:result) { local_splitter.plausible?(number) }

    context 'Local splitter without mappings' do
      let(:local_splitter) { described_class.instance_for({})}
      it 'returns false' do
        result.should be_falsey
      end
    end

    context 'Mapping does not exist for a number' do
      let(:local_splitter) { described_class.instance_for(/\A5/ => [1,2,3])}
      it 'returns false' do
        result.should be_falsey
      end
    end

    context "Mapping exists, but the length is greater" do
      let(:local_splitter) { described_class.instance_for(/\A123/ => [2,2])}
      it 'returns false' do
        result.should be_falsey
      end
    end

    context "Mapping exists, but the length is less" do
      let(:local_splitter) { described_class.instance_for(/\A123/ => [2,2,3])}
      it 'returns false' do
        result.should be_falsey
      end
    end

    context 'Mapping exists and the length is equal' do
      let(:local_splitter) { described_class.instance_for(/\A123/ => [2,2,2])}
      it 'returns true' do
        result.should be_truthy
      end
    end

  end
  
end
