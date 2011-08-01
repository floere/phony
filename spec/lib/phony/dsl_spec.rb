# encoding: utf-8
#
require 'spec_helper'

describe Phony::DSL do

  it 'has a todo' do
    Phony.define do
      todo.split("123456789012345").should == ["123456789012345"]
    end
  end

end