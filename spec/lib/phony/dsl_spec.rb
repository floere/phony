# encoding: utf-8
#
require 'spec_helper'

describe Phony::DSL do
  
  let(:dsl) { described_class.new }

  it 'has a todo' do
    Phony.define do
      todo.split("123456789012345").should == [nil, false, '123456789012345']
    end
  end
  
  describe 'match' do
    it 'checks for ( in regex' do
      expect { dsl.match(/123/) }.to raise_error("Regexp /123/ needs a group in it that defines which digits belong to the NDC.")
    end
    it 'should return a Phony::NationalSplitters::Regex' do
      dsl.match(/(123)/).class.name.should == Phony::NationalSplitters::Regex.name
    end
  end

end