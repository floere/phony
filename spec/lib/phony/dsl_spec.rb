# encoding: utf-8
#
require 'spec_helper'

describe Phony::DSL do
  
  let(:dsl) { described_class.new }

  it 'has a todo' do
    result = nil
    
    Phony.define do
      result = todo.split("123456789012345")
    end
    
    expect(result).to eq [nil, false, '123456789012345']
  end
  
  describe 'match' do
    it 'checks for ( in regex' do
      expect { dsl.match(/123/) }.to raise_error("Regexp /123/ needs a group in it that defines which digits belong to the NDC.")
    end
    it 'should return a Phony::NationalSplitters::Regex' do
      expect(dsl.match(/(123)/).class.name).to eq Phony::NationalSplitters::Regex.name
    end
  end

end