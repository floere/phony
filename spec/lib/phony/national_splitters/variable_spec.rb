require 'spec_helper'

describe Phony::NationalSplitters::Variable do
  
  describe 'split' do
    context 'normal' do
      before(:each) do
        @splitter = Phony::NationalSplitters::Variable.new 4, ['1', '316', '67', '68', '669', '711']
      end
      it "handles Vienna" do
        @splitter.split('198110').should == [nil, '1', '98110']
      end
      it "handles some mobile services" do
        @splitter.split('66914093902').should == [nil, '669', '14093902']
      end
      it "handles Graz" do
        @splitter.split('3161234567891').should == [nil, '316', '1234567891']
      end
      it "handles Rohrau" do
        @splitter.split('2164123456789').should == [nil, '2164', '123456789']
      end
      it 'has an NDC length of 3' do
        @splitter.length.should == (1..3)
      end
    end
    context 'special handling for using the variable size splitter for Swiss service numbers' do
      before(:each) do
        @splitter = Phony::NationalSplitters::Variable.new 2, ['800']
      end
      it "should handle swiss service numbers" do
        @splitter.split('800223344').should == [nil, '800', '223344']
      end
      it 'has an NDC length of 3' do
        @splitter.length.should == (3..3)
      end
    end
  end
  
end