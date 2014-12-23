# encoding: utf-8
#
require 'spec_helper'

describe Phony do

  describe 'regression' do
    it 'best effort #152' do
      described_class.split('39694805123').should eql ['39', '694805123', []]
      described_class.format('39694805123').should eql '+39 694805123 '
    end
  end

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

  context 'speed' do
    before(:each) do
      @phone_numbers = [
        '41443643532',
        '18091231234',
        '43198110',
        '33142278186',
        '4233841148'
      ]
    end
    describe 'split' do
      it 'is fast' do
        number = @phone_numbers.first
        performance_of { Phony.split(number) }.should < 0.00005
      end
      it 'is fast' do
        performance_of { @phone_numbers.each { |number| Phony.split(number) } }.should < 0.00015
      end
    end
    describe 'normalize' do
      it 'is fast' do
        number = @phone_numbers.first
        performance_of { Phony.normalize(number) }.should < 0.0001
      end
      it 'is fast' do
        performance_of { @phone_numbers.each { |number| Phony.normalize(number) } }.should < 0.00016
      end
    end
    describe 'format' do
      it 'is fast' do
        number = @phone_numbers.first
        performance_of { Phony.format(number) }.should < 0.000075
      end
      it 'is fast' do
        performance_of { @phone_numbers.each { |number| Phony.format(number) } }.should < 0.00016
      end
    end
  end

  describe 'vanity' do
    describe 'vanity_number?' do
      it {Phony.vanity?('41800 WEGGLI').should be_true}
      it {Phony.vanity?('41800WEGGLI').should be_true}
      it {Phony.vanity?('41848 SUCCESSMATCH').should be_true}
      it {Phony.vanity?('4180 NO NO NO').should be_false}
      it {Phony.vanity?('41900 KURZ').should be_false}
      it {Phony.vanity?('41 44 364 35 32').should be_false}
    end

    describe 'vanity_to_number' do
      it {Phony.vanity_to_number('41800WEGGLI').should eql '41800934454'}
      it {Phony.vanity_to_number('41800weggli').should eql '41800934454'}
      # it {Phony.vanity_to_number('41800SUCCESSMATCH').should eql '41800782237'} # Cut off according to the swiss norms.
      it {Phony.vanity_to_number('41800SUCCESSMATCH').should eql '41800782237762824'} # Allow for call-through numbers (>= 1.6.0)
      it {Phony.vanity_to_number('4180BLA').should eql '4180252'} # Does not check for validity of number.
    end
  end

end
