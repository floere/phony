#encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe E164 do
  
  describe "normalize" do
    describe "some examples" do
      it "should normalize an already normalized number" do
        E164.normalize('41443643533').should == '41443643533'
      end
      it "should normalize a formatted number" do
        E164.normalize('+41 44 364 35 33').should == '41443643533'
      end
      it "should normalize a formatted number" do
        E164.normalize('+41 44 364 35 33').should == '41443643533'
      end
      it "should normalize a special service number" do
        E164.normalize('+41 800 11 22 33').should == '41800112233'
      end
      it "should remove characters from the number" do
        E164.normalize('John: +41 44 364 35 33').should == '41443643533'
      end
      it "should normalize one of these crazy american numbers" do
        E164.normalize('1 (703) 451-5115').should == '17034515115'
      end
      it "should normalize another one of these crazy american numbers" do
        E164.normalize('1-888-407-4747').should == '18884074747'
      end
      it "should normalize a number with colons" do
        E164.normalize('1.906.387.1698').should == '19063871698'
      end
      it "should normalize a number with optional ndc" do
        E164.normalize('+41 (044) 364 35 33').should == '41443643533'
      end
    end
  end
  
  describe "remove_relative_zeros" do
    it "should remove an ndc zero from an almost normalized number and return it" do
      in_the E164 do
        remove_relative_zeros!('410443643533').should == '41443643533'
      end
    end
  end
  
  describe "formatted_cc_ndc" do
    describe "international" do
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', nil).should == '+41 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :international_absolute).should == '+41 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :international).should == '+41 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :+).should == '+41 44 '
        end
      end
      it "should return an relative internationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :international_relative).should == '0041 44 '
        end
      end
      it "should return an internationally formatted cc-ndc combo (for special service number)" do
        in_the E164 do
          formatted_cc_ndc('41', '800', :international_absolute).should == '+41 800 '
        end
      end
      context 'with a different space character' do
        it "should return an internationally formatted cc-ndc combo (for special service number), with special space" do
          in_the E164 do
            formatted_cc_ndc('41', '800', :international_absolute, :-).should == '+41-800-'
          end
        end
      end
      context 'if the ndc is blank' do
        it "should have only one space at the end (not two) / international" do
          in_the E164 do
            formatted_cc_ndc('423', '', :international).should == '+423 '
          end
        end
        it "should have only one space at the end (not two) / international relative" do
          in_the E164 do
            formatted_cc_ndc('423', '', :international_relative).should == '00423 '
          end
        end
        it "should have only one space at the end (not two) / national" do
          in_the E164 do
            formatted_cc_ndc('423', '', :national).should == ''
          end
        end
        
      end
    end
    describe "national" do
      it "should return a nationally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :national).should == '044 '
        end
      end
      it "should return a nationally formatted cc-ndc combo (for special service number)" do
        in_the E164 do
          formatted_cc_ndc('41', '800', :national).should == '0800 '
        end
      end
    end
    describe "local" do
      it "should return a locally formatted cc-ndc combo" do
        in_the E164 do
          formatted_cc_ndc('41', '44', :local).should == ''
        end
      end
    end
  end

  describe "split" do
    it "should handle austrian numbers" do
      E164.split('43198110').should == ['43', '1', '98110']
    end
    it "should handle french numbers" do
      E164.split('33112345678').should == ['33', '1', '12','34','56','78']
    end
    it "should handle german numbers" do
      E164.split('4976112345').should == ['49', '761', '123', '45']
    end
    it "should handle italian numbers opinionatedly" do
      E164.split('3928061371').should == ['39', '280', '613', '71']
    end
    it "should handle swiss numbers" do
      E164.split('41443643532').should == ['41', '44', '364', '35', '32']
    end
    it "should handle US numbers" do
      E164.split('15551115511').should == ['1', '555', '111', '5511']
    end
    it "should handle new zealand numbers" do
      E164.split('6491234567').should == ['64', '9', '123', '4567']
    end
    it "should handle swiss special services numbers" do
      E164.split('41800334455').should == ['41', '800', '33', '44', '55']
    end
  end
  
  describe "split_cc" do
    it "should handle partial numbers" do
      E164.split_cc('4').should == ['', '']
    end
    it "should handle partial numbers" do
      E164.split_cc('43').should == ['43', '']
    end
    it "should handle partial numbers" do
      E164.split_cc('431').should == ['43', '1']
    end
    it "should handle partial numbers" do
      E164.split_cc('4319').should == ['43', '19']
    end
    it "should handle partial numbers" do
      E164.split_cc('43198').should == ['43', '198']
    end
    it "should handle partial numbers" do
      E164.split_cc('431981').should == ['43', '1981']
    end
    it "should handle partial numbers" do
      E164.split_cc('4319811').should == ['43', '19811']
    end
    
    it "should handle austrian numbers" do
      E164.split_cc('43198110').should == ['43', '198110']
    end
    it "should handle french numbers" do
      E164.split_cc('33112345678').should == ['33', '112345678']
    end
    it "should handle german numbers" do
      E164.split_cc('4976112345').should == ['49', '76112345']
    end
    it "should handle italian numbers opinionatedly" do
      E164.split_cc('3928061371').should == ['39', '28061371']
    end
    it "should handle swiss numbers" do
      E164.split_cc('41443643532').should == ['41', '443643532']
    end
    it "should handle swiss special services numbers" do
      E164.split_cc('41800223344').should == ['41', '800223344']
    end
    it "should handle US numbers" do
      E164.split_cc('15551115511').should == ['1', '5551115511']
    end
    it "should handle new zealand numbers" do
      E164.split_cc('6491234567').should == ['64', '91234567']
    end
    it 'should handle Liechtenstein' do
      E164.split_cc('4233841148').should == ['423', '3841148']
    end
  end
  
  describe "split_cc_ndc" do
    it "should handle partial numbers" do
      E164.split_cc_ndc('4').should == ['', '', '']
    end
    it "should handle partial numbers" do
      E164.split_cc_ndc('43').should == ['43', '', '']
    end
    it "should handle partial numbers" do
      E164.split_cc_ndc('431').should == ['43', '1', '']
    end
    it "should handle partial numbers" do
      E164.split_cc_ndc('4319').should == ['43', '1', '9']
    end
    it "should handle partial numbers" do
      E164.split_cc_ndc('43198').should == ['43', '1', '98']
    end
    it "should handle partial numbers" do
      E164.split_cc_ndc('431981').should == ['43', '1', '981']
    end
    it "should handle partial numbers" do
      E164.split_cc_ndc('4319811').should == ['43', '1', '9811']
    end
    
    it "should handle austrian numbers" do
      E164.split_cc_ndc('43198110').should == ['43', '1', '98110']
    end
    it "should handle french numbers" do
      E164.split_cc_ndc('33112345678').should == ['33', '1', '12345678']
    end
    it "should handle german numbers" do
      E164.split_cc_ndc('4976112345').should == ['49', '761', '12345']
    end
    it "should handle italian numbers opinionatedly" do
      E164.split_cc_ndc('3928061371').should == ['39', '280', '61371']
    end
    it "should handle swiss numbers" do
      E164.split_cc_ndc('41443643532').should == ['41', '44', '3643532']
    end
    it "should handle swiss special services numbers" do
      E164.split_cc_ndc('41800112233').should == ['41', '800', '112233']
    end
    it "should handle US numbers" do
      E164.split_cc_ndc('15551115511').should == ['1', '555', '1115511']
    end
    it "should handle new zealand numbers" do
      E164.split_cc_ndc('6491234567').should == ['64', '9', '1234567']
    end
  end
  
  describe "formatted" do
    describe "default" do
      it "should format swiss numbers" do
        E164.formatted('41443643532').should == '+41 44 364 35 32'
      end
      it "should format swiss special services numbers" do
        E164.formatted('41800112233').should == '+41 800 11 22 33'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110').should == '+43 1 98110'
      end
      it "should format american numbers" do
        E164.formatted('18705551122').should == '+1 870 555 1122'
      end
    end
    describe "international" do
      it "should format north american numbers" do
        E164.formatted('18091231234', :format => :international).should == '+1 809 123 1234'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international).should == '+43 1 98110'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international_absolute).should == '+43 1 98110'
      end
      it "should format french numbers" do
        E164.formatted('33142278186', :format => :+).should == '+33 1 42 27 81 86'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :international_relative).should == '0043 1 98110'
      end
      it 'should format liechtensteiner numbers' do
        E164.formatted('4233841148', :format => :international_relative).should == '00423 384 11 48'
      end
      context 'with no spaces' do
        it "should format north american numbers" do
          E164.formatted('18091231234', :format => :international, :spaces => '').should == '+18091231234'
        end
        it "should format austrian numbers" do
          E164.formatted('43198110', :format => :international, :spaces => '').should == '+43198110'
        end
        it "should format austrian numbers" do
          E164.formatted('43198110', :format => :international_absolute, :spaces => '').should == '+43198110'
        end
        it "should format french numbers" do
          E164.formatted('33142278186', :format => :+, :spaces => '').should == '+33142278186'
        end
        it "should format austrian numbers" do
          E164.formatted('43198110', :format => :international_relative, :spaces => '').should == '0043198110'
        end
        it 'should format liechtensteiner numbers' do
          E164.formatted('4233841148', :format => :international_relative, :spaces => '').should == '004233841148'
        end
      end
      context 'with special spaces' do
        it "should format swiss numbers" do
          E164.formatted('41443643532', :format => :international).should == '+41 44 364 35 32'
        end
        it "should format north american numbers" do
          E164.formatted('18091231234', :format => :international, :spaces => :-).should == '+1-809-123-1234'
        end
        it "should format austrian numbers" do
          E164.formatted('43198110', :format => :international, :spaces => :-).should == '+43-1-98110'
        end
        it "should format austrian numbers" do
          E164.formatted('43198110', :format => :international_absolute, :spaces => :-).should == '+43-1-98110'
        end
        it "should format french numbers" do
          E164.formatted('33142278186', :format => :+, :spaces => :-).should == '+33-1-42-27-81-86'
        end
        it "should format austrian numbers" do
          E164.formatted('43198110', :format => :international_relative, :spaces => :-).should == '0043-1-98110'
        end
        it 'should format liechtensteiner numbers' do
          E164.formatted('4233841148', :format => :international_relative, :spaces => :-).should == '00423-384-11-48'
        end
      end
    end
    describe "national" do
      it "should format swiss numbers" do
        E164.formatted('41443643532', :format => :national).should == '044 364 35 32'
      end
      it "should format swiss special services numbers" do
        E164.formatted('41800112233', :format => :national).should == '0800 11 22 33'
      end
      it "should format austrian numbers" do
        E164.formatted('43198110', :format => :national).should == '01 98110'
      end
    end
    describe "local" do
      it "should format swiss numbers" do
        E164.formatted('41443643532', :format => :local).should == '364 35 32'
      end
      it "should format german numbers" do
        E164.formatted('493038625454', :format => :local).should == '386 25454'
      end
    end
  end
  
  describe 'regarding vanity' do
    describe 'vanity_number?' do
      it {E164.vanity_number?('0800 WEGGLI').should be_true}
      it {E164.vanity_number?('0800WEGGLI').should be_true}
      it {E164.vanity_number?('0848 SUCCESSMATCH').should be_true}
      it {E164.vanity_number?('080 NO NO NO').should be_false}
      it {E164.vanity_number?('0900 KURZ').should be_false}
    end
    
    describe 'vanity_to_number' do
      before(:each) do
        @number = stub(:number)
      end
      it "should delegate to E164::Vanity.replace" do
        E164::Vanity.should_receive(:replace).with(@number)
        E164.vanity_to_number @number
      end
    end
    
    describe 'replace_vanity' do
      it {E164::Vanity.replace('0800 WEGGLI').should == '0800 934454'}
      it {E164::Vanity.replace('0800weggli').should == '0800934454'}
      it {E164::Vanity.replace('0800SUCCESSMATCH').should == '0800782237762824'}
      it {E164::Vanity.replace('080BLA').should == '080252'} #replace_vanity does not check for validity of number
    end
    
    describe 'char_to_number' do
      context 'param is a valid vanity character' do
        it {E164::Vanity.char_to_number('A').should == '2'}
        it {E164::Vanity.char_to_number('d').should == '3'}
        it {E164::Vanity.char_to_number(:q).should == '7'}
        it {E164::Vanity.char_to_number(:Z).should == '9'}
      end
      context 'param is not a valid vanity character' do
        it {E164::Vanity.char_to_number('1').should == '1'}
        it {E164::Vanity.char_to_number('ü').should == 'ü'}
      end
    end
  end

end