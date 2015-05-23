# encoding: utf-8
#
require 'spec_helper'

describe Phony do

  context 'minimal cases' do
    context 'splitting' do
      it 'handles completely missing numbers well enough' do
        Phony.split('4144').should eql ['41', '44', '']
      end
      it 'handles a missing number part' do
        Phony.split('4144364').should eql ['41', '44', '364']
      end
      it 'handles a missing number part' do
        Phony.split('414436435').should eql ['41', '44', '364', '35']
      end
    end
    context 'formatting' do

    end
    context "'unsupported' countries" do
      it 'handles normalizing' do
        
      end
    end
  end

end
