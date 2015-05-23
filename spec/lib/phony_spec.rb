# encoding: utf-8
#
require 'spec_helper'

describe Phony do

  describe 'OO interface' do
    describe '[]' do
      it '' do
        us = described_class['1']
        us.plausible?('4159224711').should be_true
        us.normalize('4159224711').should eql '4159224711'
      end
    end
  end

  context 'minimal cases' do
    context 'splitting' do
      describe 'exceptions' do
        it 'should raise on split nil' do
          expect {
            Phony.split nil
          }.to raise_error(ArgumentError, 'Phone number cannot be nil. Use e.g. number && Phony.split(number).')
        end
      end
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
      it 'handles completely missing numbers well enough' do
        Phony.format('4144').should eql '+41 44 '
      end
      it 'handles a missing number part' do
        Phony.format('4144364').should eql '+41 44 364'
      end
      it 'handles a missing number part' do
        Phony.format('414436435').should eql '+41 44 364 35'
      end
    end
    context "'unsupported' countries" do
      it 'handles formatting' do
        Phony.format('88132155605220').should eql '+881 32155605220'
      end
      it 'handles normalizing' do
        Phony.normalize('+881-321 5560 5220').should eql '88132155605220'
      end
    end
  end

end
