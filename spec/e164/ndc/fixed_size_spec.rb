require File.dirname(__FILE__) + '/../../../spec_helper'

describe E164::NDC::FixedSize do

  attr_reader :splitter

  describe "size 1" do
    before(:each) do
      @splitter = E164::NDC::FixedSize.new 1
    end

    describe "formatted" do
      it "should format correctly" do
        splitter.formatted('12345678901234').should == '1 2345678901234'
      end
    end
  end
  describe "size 2" do
    before(:each) do
      @splitter = E164::NDC::FixedSize.new 2
    end

    describe "formatted" do
      it "should format correctly" do
        splitter.formatted('12345678901234').should == '12 345678901234'
      end
    end
  end
  describe "size 3" do
    before(:each) do
      @splitter = E164::NDC::FixedSize.new 3
    end

    describe "formatted" do
      it "should format correctly" do
        splitter.formatted('12345678901234').should == '123 45678901234'
      end
    end
  end
  describe "size 4" do
    before(:each) do
      @splitter = E164::NDC::FixedSize.new 4
    end

    describe "formatted" do
      it "should format correctly" do
        splitter.formatted('12345678901234').should == '1234 5678901234'
      end
    end
  end

end