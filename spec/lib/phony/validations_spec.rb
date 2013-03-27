# encoding: utf-8
#
require 'spec_helper'

describe 'validations' do

  describe 'plausible?' do

    # Validations test helper.
    # @param country_name [String]
    # @param options [Hash]
    # @option options [String, Array<String>] :samples
    #
    def self.it_is_correct_for(country_name, options={})
      samples = [*options[:samples]]
      raise ArgumentError, ':samples option should be specified' if samples.empty?

      it "is correct for #{country_name}" do
        samples.each do |sample|
          correct = [*sample]

          shortest = correct.min{|x| x.scan(/\d/).length}
          longest = correct.max{|x| x.scan(/\d/).length}
          incorrect = [shortest.sub(/\d\s*\z/, ''), longest + '0']

          correct.each do |value|
            Phony.plausible?(value).should be_true
          end
          incorrect.each do |value|
            Phony.plausible?(value).should be_false
          end
        end
      end
    end
    
    it 'does not change the given number' do
      number = "123-123-1234"
      
      Phony.plausible? number
      
      number.should == '123-123-1234'
    end
    
    it 'handles small numbers' do
      Phony.plausible?('353').should be_false
    end

    it 'is correct' do
      Phony.plausible?('+1911').should be_false
    end
    it "correctly plausibilizes to#{}do countries" do
      Phony.plausible?('6327332350').should be_true
    end
    it 'is correct' do
      Phony.plausible?('45 44 11 22 33').should be_true
    end
    it 'is correct' do
      Phony.plausible?('+4231231212').should be_true
    end
    it 'is correct' do
      Phony.plausible?('010').should be_false
    end
    it 'is correct' do
      Phony.plausible?("+460000").should be_false
    end
    it 'is correct' do
      Phony.plausible?('0000000').should be_false
    end
    it 'is correct' do
      Phony.plausible?('hello').should be_false
    end
    
    it "is correct" do
      Phony.plausible?('+41 44 111 22 33').should be_true
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', cc: '41').should be_true
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', ndc: '44').should be_true
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', cc: '1').should be_false
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', ndc: '43').should be_false
    end
    it "is correct for explicit checks" do
      Phony.plausible?('+41 44 111 22 33', cc: '41', ndc: '44').should be_true
    end
    it "works with regexps" do
      Phony.plausible?('+41 44 111 22 33', cc: /4(0|2)/, ndc: /4(4|5)/).should be_false
    end
    it "works with regexps" do
      Phony.plausible?('+41 44 111 22 33', cc: /4(0|1)/, ndc: /4(4|5)/).should be_true
    end
    
    context 'Length validation' do
      it 'works for Swiss cases' do
        Phony.plausible?('+41 44 111 22 3').should be_false   # Not long enough is not ok.
        # Phony.plausible?('+41 44 111 22 33 4').should be_true # TODO Too long is ok – we don't know about extensions.
      end
    end
    
    context 'specific countries' do
      
      # TODO: more needs to be done here
      #
      it "is correct for Swiss numbers" do
        Phony.plausible?('+41 44 111 22 33').should be_true
        Phony.plausible?('+41 44 111 22 334').should be_false
        Phony.plausible?('+41 44 111 22').should be_false
      end

      it "is correct for Danish numbers" do
        Phony.plausible?('+45 44 11 12 23 34').should be_false
        Phony.plausible?('+45 44 11 12 2').should be_false
        Phony.plausible?('+45 44 55 22 33').should be_true
      end

      it 'is correct for egyptian numbers' do
        Phony.plausible?('+20 800 1234567').should be_true
        Phony.plausible?('+20 800 12345678').should be_false
        Phony.plausible?('+20 2 12345678').should be_true
        Phony.plausible?('+20 2 1234567').should be_false
        Phony.plausible?('+20 40 12345678').should be_true
        Phony.plausible?('+20 40 1234567').should be_false
      end

      it 'is correct for Dutch numbers' do
        Phony.plausible?('+31 6 12 34 56 78').should be_true
        Phony.plausible?('+31 6 12 34 56 7').should be_false
        Phony.plausible?('+31 20 123 5678').should be_true
        Phony.plausible?('+31 20 123 567').should be_false
        Phony.plausible?('+31 221 123 567').should be_true
        Phony.plausible?('+31 221 123 56').should be_false
      end
      it 'is correct for Nigerian numbers' do
        Phony.plausible?('+234 807 766 1234').should be_true
        Phony.plausible?('+234 807 766 123').should be_false
      end
      it 'is correct for Italian numbers' do
        Phony.plausible?('+39 06 1234 4567').should be_true
        Phony.plausible?('+39 335 123 4567').should be_true
        Phony.plausible?('+39 335 123').should be_false
      end
      it 'is correct for German numbers' do
        Phony.plausible?('+49 40 123 45678').should be_true
        Phony.plausible?('+49 40 123 456789').should be_false
        Phony.plausible?('+49 171 123 45678').should be_true
        Phony.plausible?('+49 171 123 456789').should be_false
        Phony.plausible?('+49 171 123').should be_false
        # Phony.plausible?('+49 991 1234').should be_true   # stricter 3 digit ndc rules
        # Phony.plausible?('+49 2041 123').should be_true # Grandfathered numbers. TODO
        Phony.plausible?('+49 2041 1234567').should be_true
        Phony.plausible?('+49 2041 12345689').should be_false
        Phony.plausible?('+49 31234 123456').should be_true
        Phony.plausible?('+49 31234 1234567').should be_false
      end

      it 'is correct for Isralian numbers' do
        Phony.plausible?('+972 2 123 1234').should be_true
        Phony.plausible?('+972 59 123 1234').should be_true
      end
      it "is correct for US numbers" do
        # Sorry, still need E164 conform numbers.
        #
        Phony.plausible?('4346667777', cc: '1').should be_false
        
        # Automatic country checking.
        #
        Phony.plausible?('1-4346667777').should be_true
        Phony.plausible?('1-800-692-7753').should be_true
        Phony.plausible?('1-911').should be_false
        Phony.plausible?('1-911-123-1234').should be_false
        Phony.plausible?('143466677777').should be_false # too long
        Phony.plausible?('143466677').should be_false # too short
        
        # With string constraints.
        #
        Phony.plausible?('14346667777', cc: '1').should be_true
        Phony.plausible?('14346667777', ndc: '434').should be_true
        Phony.plausible?('14346667777', cc: '1', ndc: '434').should be_true
        
        # With regexp constraints.
        #
        Phony.plausible?('14346667777', cc: /[123]/).should be_true
        Phony.plausible?('14346667777', ndc: /434|435/).should be_true
        Phony.plausible?('14346667777', cc: /[123]/, ndc: /434|435/).should be_true
      end

      it "is correct for Portugese numbers" do
        Phony.plausible?('+351 800 123456').should be_true
        Phony.plausible?('+351 90 1234567').should be_true
        Phony.plausible?('+351 90 123456').should be_false
        Phony.plausible?('+351 123 1234567').should be_true
      end

      it "is correct for Russia" do
        Phony.plausible?('+7 800 2000 600').should be_true
        Phony.plausible?('+7 960 301 23 45').should be_true
        Phony.plausible?('+7 800 2000 60').should be_false # too short
        Phony.plausible?('796030123451').should be_false # too long
      end

      it "is correct for Austria" do
        Phony.plausible?('+43 501 1234567890').should be_true
        Phony.plausible?('+43 501 123456789').should be_false # too short
        Phony.plausible?('+43 501 12345678901').should be_false # too long
      end

      it "is correct for Azerbaijan" do
        Phony.plausible?('+994 12 1234567').should be_true
        Phony.plausible?('+994 12 12345').should be_false # too short
        Phony.plausible?('+994 12 12345678').should be_false # too long
      end

      it "is correct for Albania" do
        Phony.plausible?('+355 85 123456').should be_true
        Phony.plausible?('+355 85 12345').should be_false # too short
        Phony.plausible?('+355 85 1234567').should be_false # too long
      end

      it "is correct for Angola" do
        Phony.plausible?('+244 852 123 456').should be_true
        Phony.plausible?('+244 852 123').should be_false # too short
        Phony.plausible?('+244 852 123 4567').should be_false # too long
      end

      it "is correct for Andorra" do
        Phony.plausible?('+376 712345').should be_true
        Phony.plausible?('+376 71234').should be_false # too short
        Phony.plausible?('+376 7123456').should be_false # too long
        Phony.plausible?('+376 712345').should be_true
        Phony.plausible?('+376 71234').should be_false # too short
        Phony.plausible?('+376 7123456').should be_false # too long
      end

      it "is correct for Netherlands Antilles" do
        Phony.plausible?('+599 1234567').should be_true
        Phony.plausible?('+599 123456').should be_false # too short
        Phony.plausible?('+599 12345678').should be_false # too long
      end

      it "is correct for Armenia" do
        Phony.plausible?('+374 12345678').should be_true
        Phony.plausible?('+374 1234567').should be_false # too short
        Phony.plausible?('+374 123456789').should be_false # too long
      end

      it "is correct for Aruba" do
        Phony.plausible?('+297 52 1234').should be_true
        Phony.plausible?('+297 52 123').should be_false # too short
        Phony.plausible?('+297 52 12345').should be_false # too long
      end

      it 'is correct for Bangladesh' do
        Phony.plausible?('+880 2 1234567').should be_true
        Phony.plausible?('+880 2 12345678').should be_false # too long
        Phony.plausible?('+880 2 123456').should be_false # too short

        Phony.plausible?('+880 9020 12345').should be_true
        Phony.plausible?('+880 9020 123456').should be_false # too long
        Phony.plausible?('+880 9020 1234').should be_false # too short

        # ndc with several subscriber number length
        Phony.plausible?('+880 3035 1234').should be_true
        Phony.plausible?('+880 3035 123').should be_true
        Phony.plausible?('+880 3035 12').should be_false # too short
        Phony.plausible?('+880 3035 12345').should be_false # too long
      end

      it 'is correct for Bahrain' do
        Phony.plausible?('+973 1234 5678').should be_true
        Phony.plausible?('+973 1234 567').should be_false  # too short
        Phony.plausible?('+973 1234 56789').should be_false # too long
      end

      it 'is correct for Belarus' do
        Phony.plausible?('+375 152 123456').should be_true
        Phony.plausible?('+375 152 12345').should be_false # too short
        Phony.plausible?('+375 152 1234567').should be_false # too long

        Phony.plausible?('+375 800 123').should be_true
        Phony.plausible?('+375 800 1234').should be_true
        Phony.plausible?('+375 800 1234567').should be_true
        Phony.plausible?('+375 800 123456').should be_false
        Phony.plausible?('+375 800 12345678').should be_false
      end

      it_is_correct_for 'Belize', :samples => '+501 205 1234'
      it_is_correct_for 'Benin', :samples => '+229 1234 5678'
      it_is_correct_for 'Bolivia', :samples => '+591 2 277 2266'
      it_is_correct_for 'Colombia', :samples => ['+57 1 123 4567', '+57 310 123 4567']
      it_is_correct_for 'Philippines', :samples => [['+63 2 1234567', '+63 2 1234567890'],
                                                    '+63 88 1234567',
                                                    ['+63 920 123456', '+63 920 1234567']]
      it_is_correct_for 'Japan', :samples => ['+81 3 1234 5678',
                                              '+81 120 123 456',
                                              '+81 11 1234 567',
                                              '+81 123 123 456',
                                              '+81 1267 123 45',
                                              '+81 90 1234 5678']
      it_is_correct_for 'Pakistan', :samples => ['+92 21 1234 5678',
                                                 '+92 22 1234 567',
                                                 '+92 232 123 456',
                                                 '+92 30 1234 5678']

    end
    
  end
  
end