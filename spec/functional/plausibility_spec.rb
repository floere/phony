# encoding: utf-8
#
require 'spec_helper'

describe 'plausibility' do

  describe 'plausible?' do

    # Validations test helper.
    # @param country_name [String]
    # @param options [Hash]
    # @option options [String, Array<String>] :samples
    #
    def self.it_is_correct_for(country_name, options={})
      samples = [*options[:samples]]
      invalid_samples = [*options[:invalid_samples]]

      raise ArgumentError, ':samples option should be specified' if samples.empty?

      it "is correct for #{country_name}" do
        samples.each do |sample|
          correct = [*sample]

          shortest = correct.min_by{|x| x.scan(/\d/).length}
          incorrect = [shortest.sub(/\d\s*\z/, '')] # , longest + '0']

          correct.each do |value|
            Phony.plausible?(value).should be_true,
              "It should validate #{value}, but does not."
          end
          incorrect.each do |value|
            Phony.plausible?(value).should be_false,
              "It should not validate #{value}, but does."
          end
        end

        invalid_samples.each do |sample|
          invalid = [*sample]

          invalid.each do |value|
            Phony.plausible?(value).should be_false,
              "It should not validate #{value}, but does."
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
      Phony.plausible?('+4755121212').should be_true
    end
    it 'is correct' do
      Phony.plausible?('+475512121').should be_false
    end
    it 'is correct' do
      Phony.plausible?('+47551212121').should be_false
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
    it 'is correct for zeros in number' do
      Phony.plausible?('+00 00 000 00 01').should be_false
    end
    it 'is correct for zeros in number' do
      Phony.plausible?('00 00 000 00 01').should be_false
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
      it "" do
        Phony.plausible?('+43 699 00000000').should be_true
      end

      it "is correct for Austria" do
        Phony.plausible?('+43 1 000000').should be_true
        Phony.plausible?('+43 1 0000000').should be_true
        Phony.plausible?('+43 501 12345').should be_true
        Phony.plausible?('+43 501 1234').should be_false # too short
        Phony.plausible?('+43 501 123456').should be_false # too long
        Phony.plausible?('+43 800 123456789').should be_true

        # Mobile
        Phony.plausible?('+43 676 0000000').should be_true
        Phony.plausible?('+43 681 00000000').should be_true
        Phony.plausible?('+43 688 0000000').should be_true
        Phony.plausible?('+43 699 00000000').should be_true
        # 663 mobile numbers have 6 digits
        Phony.plausible?('+43 663 000000').should be_true
        # mobile numbers can have from 7 to 10 digits in the subscriber number
        Phony.plausible?('+43 664 1234 567').should be_true
        Phony.plausible?('+43 664 1234 5678').should be_true
        Phony.plausible?('+43 664 1234 56789').should be_true
        Phony.plausible?('+43 664 1234 567890').should be_true
      end

      it "is correct for Belgian numbers" do
        Phony.plausible?('+32 3 241 11 32').should be_true
        Phony.plausible?('0032 3 241 11 32').should be_true
        Phony.plausible?('0032 (0) 3 241 11 32').should be_true
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

      it "is correct for Armenia" do
        Phony.plausible?('+374 12345678').should be_true
        Phony.plausible?('+374 1234567').should be_false # too short
        Phony.plausible?('+374 123456789').should be_false # too long
      end

      it "is correct for Aruba" do
        # Landline
        Phony.plausible?('+297 525 5200').should be_true
        Phony.plausible?('+297 586 6555').should be_true
        # Mobile
        Phony.plausible?('+297 737 7667').should be_true

        Phony.plausible?('+297 520 000').should be_false    # too short
        Phony.plausible?('+297 520 00000').should be_false  # too long
      end

      it "is correct for Azerbaijan" do
        Phony.plausible?('+994 12 1234567').should be_true
        Phony.plausible?('+994 12 12345').should be_false # too short
        Phony.plausible?('+994 12 12345678').should be_false # too long
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

      it 'is correct for Cambodia' do
        # http://en.wikipedia.org/wiki/Telecommunications_in_Cambodia#Mobile_networks
        # http://en.wikipedia.org/wiki/Telephone_numbers_in_Cambodia
        # http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000230001MSWE.doc

        Phony.plausible?("+855312345678").should be_true     # Beeline (7 digit id)
        Phony.plausible?("+85531234567").should be_false     # Beeline (too short)
        Phony.plausible?("+85560234567").should be_true      # Beeline (6 digit id)
        Phony.plausible?("+855602345678").should be_false    # Beeline (too long)

        Phony.plausible?("+855762345678").should be_true     # Mobitel (7 digit id)
        Phony.plausible?("+85576234567").should be_false     # Mobitel (too short)
        Phony.plausible?("+85517234567").should be_true      # Mobitel (6 digit id)
        Phony.plausible?("+855172345678").should be_false    # Mobitel (too long)
        Phony.plausible?("+85512234567").should be_true      # Mobitel (6 digit id)
        Phony.plausible?("+855121345678").should be_true     # Mobitel (7 digit id)
        Phony.plausible?("+85512123456").should be_false     # Mobitel (6 digit invalid)

        Phony.plausible?("+855383001801").should be_true     # CooTel (7 digit id)
        Phony.plausible?("+85538300180").should be_false     # CooTel (too short)

        Phony.plausible?("+85518234567").should be_true      # Excell (6 digit id)
        Phony.plausible?("+855182345678").should be_false    # Excell (too long)

        Phony.plausible?("+855882345678").should be_true     # Metfone (7 digit id)
        Phony.plausible?("+85588234567").should be_false     # Metfone (too short)
        Phony.plausible?("+855972345678").should be_true     # Metfone (7 digit id)
        Phony.plausible?("+85597234567").should be_false     # Metfone (too short)
        Phony.plausible?("+855714822684").should be_true     # Metfone (7 digit id)
        Phony.plausible?("+85571482268").should be_false     # Metfone (too short)

        Phony.plausible?("+85513234567").should be_true      # qb (6 digit id)
        Phony.plausible?("+855132345678").should be_false    # qb (too long)

        Phony.plausible?("+855962345678").should be_true     # Smart (7 digit id)
        Phony.plausible?("+85596234567").should be_false     # Smart (too short)
        Phony.plausible?("+85510234567").should be_true      # Smart (6 digit id)
        Phony.plausible?("+855102345678").should be_false    # Smart (too long)

        # AXXXXX (A must be between 1 and 9)
        Phony.plausible?("+85512023456").should be_false     # invalid numbering plan
        Phony.plausible?("+855380234567").should be_false    # invalid numbering plan
        Phony.plausible?("+85592123456").should be_true      # valid for 6 digit id

        Phony.plausible?("+85514234567").should be_false     # invalid mobile operator
        Phony.plausible?("+85527234567").should be_false     # invalid ndc

        Phony.plausible?("+85523471234").should be_true      # Fixed line (NDC + '47' + 4 digit id)
        Phony.plausible?("+855234712345").should be_true     # Fixed line (NDC + '47' + 5 digit id)
        Phony.plausible?("+85523123456").should be_false     # Fixed line (NDC + invalid A)
      end

      it 'is correct for Croatia' do
        # Landline
        expect(Phony.plausible?('+385 21 695900')).to be_true
        expect(Phony.plausible?('+385 1 4566 666')).to be_true

        expect(Phony.plausible?('+385 21 12345')).to be_false, "too short"
        expect(Phony.plausible?('+385 21 1234567')).to be_false, "too long"

        # Mobile
        expect(Phony.plausible?('+385 91 896 7509')).to be_true

        expect(Phony.plausible?('+385 91 123456')).to be_false, "too short"
      end

      it "is correct for Denmark" do
        Phony.plausible?('+45 44 11 12 23 34').should be_false
        Phony.plausible?('+45 44 11 12 2').should be_false
        Phony.plausible?('+45 44 55 22 33').should be_true
      end

      it "is correct for Estonia" do
        # the 5xxxx mobile numbers can be 7 or 8 digits (ndc + subscriber) long
        Phony.plausible?('+372 532 12345').should be_true
        Phony.plausible?('+372 532 1234').should be_true
        Phony.plausible?('+372 532 123').should be_false
        Phony.plausible?('+372 532 123456').should be_false

        # the 81x/82x are only 8 digits
        Phony.plausible?('+372 822 12345').should be_true
        Phony.plausible?('+372 812 12345').should be_true
        Phony.plausible?('+372 822 1234').should be_false
        Phony.plausible?('+372 812 1234').should be_false
        Phony.plausible?('+372 822 123').should be_false
        Phony.plausible?('+372 822 123456').should be_false
      end

      it 'is correct for Netherlands' do
        Phony.plausible?('+31 6 12 34 56 78').should be_true
        Phony.plausible?('+31 6 12 34 56 7').should be_false
        Phony.plausible?('+31 20 123 5678').should be_true
        Phony.plausible?('+31 20 123 567').should be_false
        Phony.plausible?('+31 221 123 567').should be_true
        Phony.plausible?('+31 221 123 56').should be_false
        Phony.plausible?('+31 880 450 245').should be_true
        Phony.plausible?('+31 880 450 24').should be_false
        Phony.plausible?('+31 900 123 4567').should be_true
        Phony.plausible?('+31 900 001 00').should be_false
        Phony.plausible?('+31 800 6080').should be_true
      end

      it 'is correct for Egypt' do
        Phony.plausible?('+20 800 1234567').should be_true
        Phony.plausible?('+20 800 12345678').should be_false
        Phony.plausible?('+20 2 12345678').should be_true
        Phony.plausible?('+20 2 1234567').should be_false
        Phony.plausible?('+20 40 12345678').should be_true
        Phony.plausible?('+20 40 1234567').should be_false
      end

      it 'is correct for Germany' do
        Phony.plausible?('+49 209 169 - 0').should be_true # Gelsenkirchen
        Phony.plausible?('+49 209 169 - 3530').should be_true # Gelsenkirchen
        Phony.plausible?('+49 40 123 45678').should be_true
        Phony.plausible?('+49 40 123 456789').should be_true # TODO ?
        Phony.plausible?('+49 160 123 1234').should be_true # Mobile Number 7 digits
        Phony.plausible?('+49 160 123 12345').should be_true # Mobile Number 8 digits
        Phony.plausible?('+49 171 123 4567').should be_true
        Phony.plausible?('+49 171 123 45678').should be_true # is a valid number according German authority "bundesnetzagentur": http://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/ONRufnr/NummernplanOrtsnetzrufnummern.pdf?__blob=publicationFile&v=2 (04.24.2014)
        Phony.plausible?('+49 177 123 1234').should be_true
        Phony.plausible?('+49 176 123 12345').should be_true
        Phony.plausible?('+49 991 1234').should be_true   # stricter 3 digit ndc rules
        Phony.plausible?('+49 2041 123').should be_true # Grandfathered numbers.
        Phony.plausible?('+49 2041 1234567').should be_true
        Phony.plausible?('+49 31234 123456').should be_true
        Phony.plausible?('+49 7141 12345670').should be_true
        Phony.plausible?('+49 1609 1234567').should be_true # Bug: https://github.com/floere/phony/issues/146
        Phony.plausible?('+49 800 1234567').should be_true
        Phony.plausible?('+49 1805 878323').should be_true

        # Extended service numbers
        # http://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/0800/0800_Nummernplan.pdf?__blob=publicationFile&v=1
        Phony.plausible?('+49 800 222 3400 10').should be_true
        Phony.plausible?('+49 800 222 3400 100').should be_true
        Phony.plausible?('+49 800 222 3400 1000').should be_false

        # Following tests implement specifications from
        # http://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/ONRufnr/NummernplanOrtsnetzrufnummern.pdf?__blob=publicationFile&v=2 (04.24.2014)
        # Page 3
        Phony.plausible?('+49 89    12345678').should be_true # NZ-E
        Phony.plausible?('+49 89    123456789').should be_true # NZ-E & NZ-Z
        Phony.plausible?('+49 89    1234567890').should be_true # NZ-Z
        Phony.plausible?('+49 209   1234567').should be_true # NZ-E
        Phony.plausible?('+49 209   12345678').should be_true # NZ-E & NZ-Z
        Phony.plausible?('+49 209   123456789').should be_true # NZ-Z
        Phony.plausible?('+49 6421  123456').should be_true # NZ-E
        Phony.plausible?('+49 6421  1234567').should be_true # NZ-E & NZ-Z
        Phony.plausible?('+49 6421  12345678').should be_true # NZ-Z
        Phony.plausible?('+49 33053 12345').should be_true # NZ-E
        Phony.plausible?('+49 33053 123456').should be_true # NZ-E & NZ-Z
        Phony.plausible?('+49 33053 1234567').should be_true # NZ-Z
        # Point 2.3c) Numbers can be up to 13 Digits long without prefix according to E.164
        Phony.plausible?('+49 33053 12345678').should be_true
        Phony.plausible?('+49 6421 123456789').should be_true
        Phony.plausible?('+49 209 1234567890').should be_true
        Phony.plausible?('+49 40 12345678901').should be_true
      end

      it 'is correct for Israel' do
        Phony.plausible?('+972 2 123 1234').should be_true
        Phony.plausible?('+972 59 123 1234').should be_true
      end

      it 'is correct for Italy' do
        Phony.plausible?('+39 06 1234 4567').should be_true

        Phony.plausible?('+39 035 00000').should be_false
        Phony.plausible?('+39 035 000000').should be_true
        Phony.plausible?('+39 015 8407324').should be_true

        Phony.plausible?('+39 0471 123 456').should be_true

        # Issue #221
        Phony.plausible?('+39 081 1925 2698').should be_true

        # Mobile
        Phony.plausible?('+39 335 123').should be_false
        Phony.plausible?('+39 335 123 45').should be_false
        Phony.plausible?('+39 335 123 456').should be_true
        Phony.plausible?('+39 335 123 4567').should be_true
        Phony.plausible?('+39 335 123 45678').should be_true
        Phony.plausible?('+39 335 123 456789').should be_false
      end

      it 'is correct for Malaysia' do
        Phony.plausible?('+60 14 123 1234').should be_true
        Phony.plausible?('+60 11 123 12345').should be_true
        Phony.plausible?('+60 14 1234 12').should be_false     # too short
        Phony.plausible?('+60 14 1234 12345').should be_false  # too long
      end

      it 'is correct for Mexico' do
        Phony.plausible?('+52 1 55 1212 1212').should be_true
        Phony.plausible?('+52 55 1212 1212').should be_true
        Phony.plausible?('+52 664 123 1212').should be_true
        Phony.plausible?('+52 1 664 123 1212').should be_true
        Phony.plausible?('+52 044 664 123 1212').should be_true
        Phony.plausible?('+52 1 55 1212 1212 3').should be_false  # too long
        Phony.plausible?('+52 55 1212 121').should be_false     # too short
      end

      it "is correct for Netherlands Antilles" do
        Phony.plausible?('+599 1234567').should be_true
        Phony.plausible?('+599 123456').should be_false # too short
        Phony.plausible?('+599 12345678').should be_false # too long
      end

      it 'is correct for New Zeland' do
        Phony.plausible?('+64 21 123 456').should be_true
        Phony.plausible?('+64 21 123 4567').should be_true
        Phony.plausible?('+64 9 379 1234').should be_true
        Phony.plausible?('+64 21 12 345 678').should be_true
        Phony.plausible?('+64 21 1234 56789').should be_false # to long
        Phony.plausible?('+64 21 12345').should be_false # to short
      end

      it 'is correct for Nigerian numbers' do
        Phony.plausible?('+234 807 766 1234').should be_true
        Phony.plausible?('+234 807 766 123').should be_false
      end

      it "is correct for Portugese numbers" do
        Phony.plausible?('+351 800 123456').should be_true
        Phony.plausible?('+351 90 1234567').should be_true
        Phony.plausible?('+351 90 123456').should be_false
        Phony.plausible?('+351 123 123456').should be_true
        Phony.plausible?('+351 123 1234567').should be_false
      end

      it "is correct for Russia" do
        Phony.plausible?('+7 800 2000 600').should be_true
        Phony.plausible?('+7 960 301 23 45').should be_true
        Phony.plausible?('+7 800 2000 60').should be_false # too short
        Phony.plausible?('796030123451').should be_false # too long
      end

      it "is correct for Slovenian numbers" do
        Phony.plausible?('+386 41 123 456').should be_true
        Phony.plausible?('+386 1 320 1234').should be_true
        Phony.plausible?('+386 41 123 4567').should be_false
      end

      # TODO: more needs to be done here
      #
      it "is correct for Swiss numbers" do
        Phony.plausible?('+41 44 111 22 33').should be_true
        Phony.plausible?('+41 44 111 22 334').should be_false
        Phony.plausible?('+41 44 111 22').should be_false
      end

      it "is correct for Swedish numbers" do
        Phony.plausible?('+46 8 506 10 60').should be_true
        Phony.plausible?('+46 8 506 106 00').should be_true
        Phony.plausible?('+46 19 764 22 00').should be_true
        Phony.plausible?('+46 19 20 88 50').should be_true
        Phony.plausible?('+46 19 20 88').should be_false # too short
      end

      it "is correct for Vietnamese numbers" do
        Phony.plausible?('+84 8 3827 9666').should be_true
        Phony.plausible?('+84 4 3926 1720').should be_true
        Phony.plausible?('+84 091 123-4567').should be_true
        Phony.plausible?('+84 0167 123456').should be_true
        Phony.plausible?('+84 1 1234').should be_false # too short
        Phony.plausible?('+84 12 3456 7891 0111213').should be_false # too long
      end

      it "is correct for US numbers" do
        # Still need E164 conform numbers.
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

      it_is_correct_for 'Belize', :samples => '+501 205 1234'
      it_is_correct_for 'Benin', :samples => '+229 1234 5678'
      it_is_correct_for 'Bolivia', :samples => '+591 2 277 2266'
      it_is_correct_for 'Botswana', :samples => ['+267 80 123 456',
                                                 '+267 29 567 89',
                                                 '+267 463 4567',
                                                 '+267 58 123 45',
                                                 '+267 7 6712 345',
                                                 '+267 8 1234 567']
      it_is_correct_for 'Colombia', :samples => ['+57 1 123 4567', '+57 310 123 4567']
      it_is_correct_for 'Philippines', :samples => [['+63 2 1234567', '+63 2 1234567890'],
                                                    '+63 88 1234567',
                                                    ['+63 920 123456', '+63 920 1234567']]

      it_is_correct_for 'Pakistan', :samples => ['+92 21 1234 5678',
                                                 '+92 22 1234 567',
                                                 '+92 232 123 456',
                                                 '+92 30 1234 5678']
      it_is_correct_for 'Bhutan (Kingdom of)', :samples => '+975 2 889 648'
      it_is_correct_for 'Brunei Darussalam', :samples => '+673 5 523 876'
      it_is_correct_for 'Burkina Faso', :samples => '+226  1476 2312'
      it_is_correct_for 'Burundi', :samples => '+257  1234 5678'

      it_is_correct_for 'Cameroon', :samples => '+237  7372 8186'
      it_is_correct_for 'Cape Verde', :samples => '+238  642 3843'
      it_is_correct_for 'Central African Republic', :samples => '+236  1234 5678'
      it_is_correct_for 'Chad', :samples => '+235  1234 5678'
      it_is_correct_for 'Comoros', :samples => ['+269 3901 234', '+269 3401 234']
      it_is_correct_for 'Congo', :samples => '+242 1234 56789'
      it_is_correct_for 'Cook Islands', :samples => '+682  71928'
      it_is_correct_for 'Costa Rica', :samples => '+506 2 234 5678'
      it_is_correct_for "Côte d'Ivoire", :samples => '+225  9358 8764'
      it_is_correct_for 'Democratic Republic of Timor-Leste', :samples => ['+670 465 7886', '+670 7465 7886']
      it_is_correct_for 'Democratic Republic of the Congo', :samples => '+243 8 864 9794'
      it_is_correct_for 'Diego Garcia', :samples => '+246  123 7686'
      it_is_correct_for 'Djibouti', :samples => '+253  3671 1431'
      it_is_correct_for 'Ecuador', :samples => '+593 68 467 4579'
      it_is_correct_for 'Equatorial Guinea', :samples => ['+240 222 201 123',
                                                          '+240 335 201 123']
      it_is_correct_for 'Eritrea', :samples => '+291 6 334 475'
      it_is_correct_for 'Ethiopia', :samples => '+251 89 558 3197'
      it_is_correct_for 'Falkland Islands (Malvinas)', :samples => '+500  28494'
      it_is_correct_for 'Faroe Islands', :samples => '+298  969 597'
      it_is_correct_for 'Fiji (Republic of)', :samples => '+679  998 2441'
      it_is_correct_for 'French Guiana (French Department of)', :samples => '+594 594 123 456'
      it_is_correct_for "French Polynesia (Territoire français d'outre-mer)", :samples => '+689 87 27 84 00'
      it_is_correct_for 'Gabonese Republic', :samples => '+241 1 627 739'
      it_is_correct_for 'Gambia', :samples => '+220  989 5148'
      it_is_correct_for 'Germany', :samples => [
        '+49 157 753 6870'
      ]
      it_is_correct_for 'Georgia', :samples => ['+995 220 123 45',
                                                '+995 32 123 4567',
                                                '+995 342 123 456',
                                                '+995 596 123 456']
      it_is_correct_for 'Greece', :samples => ['+30 21 4234 5678',
                                               '+30 24 4234 5678',
                                               '+30 50 3457 1234',
                                               '+30 69 0123 4567',
                                               '+30 70 0123 4567',
                                               '+30 800 100 1234',
                                               '+30 801 100 1234',
                                               '+30 807 100 1234',
                                               '+30 896 100 1234',
                                               '+30 901 123 4565',
                                               '+30 909 123 4565']
      it_is_correct_for 'Greenland', :samples => '+299  922 954'
      it_is_correct_for 'Guadeloupe (French Department of)', :samples => '+590 123 456 789'
      it_is_correct_for 'Guatemala (Republic of)', :samples => ['+502 19 123 456 789',
                                                                '+502 2 123 4567']
      it_is_correct_for 'Guinea', :samples => [
        '+224 664 12 34 56',
        '+224 30 31 12 34',
        '+224 3041 12 34',
        '+224 700 00 00 00'
      ]

      it_is_correct_for 'Guinea-Bissau', :samples => '+245  728 6998'
      it_is_correct_for 'Guyana', :samples => '+592 263 1234'
      it_is_correct_for 'Honduras (Republic of)', :samples => '+504 12 961 637'
      it_is_correct_for 'Indonesia', :samples => ['+62 13 123',
                                                  '+62 13 123 456',
                                                  '+62 174 12',
                                                  '+62 174 12 345',
                                                  '+62 177 12',
                                                  '+62 177 1212 3456',
                                                  '+62 178 123',
                                                  '+62 178 123 45',
                                                  '+62 21 123 45',
                                                  ['+62 21 123 4567', '+62 21 1234 5567'],
                                                  '+62 22 123 45',
                                                  '+62 22 123 4567',
                                                  '+62 4 311 234',
                                                  '+62 4 3112 3456',
                                                  ['+62 6 221 2345', '+62 6 2212 3456'],
                                                  '+62 70 123 456',
                                                  ['+62 71 123 456', '+62 71 123 4567'],
                                                  ['+62 810 123 456', '+62 810 123 4567', '+62 810 1234 5678'],
                                                  ['+62 815 123 456', '+62 815 123 4567', '+62 815 1234 5678'],
                                                  '+62 820 123 456',
                                                  ['+62 823 123 456', '+62 823 123 4567', '+62 823 1234 5678'],
                                                  '+62 870 123 45',
                                                  ['+62 877 123 456', '+62 877 123 4567', '+62 877 1234 5678'],
                                                  ['+62 878 123 456', '+62 878 123 4567', '+62 878 1234 5678'],
                                                  ['+62 881 123 456', '+62 881 123 4567', '+62 881 1234 5678'],
                                                  '+62 9 1234 567',
                                                  '+62 9 123 456 789']
      it_is_correct_for 'Iraq', :samples => ['+964 1 123 4567',
                                             '+964 21 113 456',
                                             '+964 71 1234 5678']
      it_is_correct_for 'Japan', :samples => ['+81 3 1234 5678',
                                              '+81 120 123 456',
                                              '+81 11 1234 567',
                                              '+81 123 123 456',
                                              '+81 1267 123 45',
                                              '+81 90 1234 5678']
      it_is_correct_for 'Jordan (Hashemite Kingdom of)', :samples => ['+962 800 123 45',
                                                                      '+962 2 620 1234',
                                                                      '+962 7 1234 5678',
                                                                      '+962 7 4661 2345',
                                                                      '+962 900 123 45',
                                                                      '+962 85 123 456',
                                                                      '+962 70 123 456',
                                                                      '+962 6250 1456',
                                                                      '+962 8790 1456']
      it_is_correct_for 'Kiribati (Republic of)', :samples => '+686  31993'
      it_is_correct_for "Democratic People's Republic of Korea", :samples => ['+850 2 123 45',
                                                                              '+850 2 123 456 789',
                                                                              '+850 2 381 2356',
                                                                              #'+850 2 8801 1234 5678 1256',
                                                                              '+850 191 123 4567']
      it_is_correct_for 'Kuwait (State of)', :samples => ['+965 2345 6789', '+965 181 2345' ]
      it_is_correct_for 'Kenya', :samples => [
        '254201234567',
        '254111234567',
        '254723100220',
        '+254-20-4262 140',
        '+254-(0)20-4262 140'
      ]
      it_is_correct_for 'Kyrgyzstan', :samples => ['+996 312 212 345',
                                                   '+996 315 212 345',
                                                   '+996 3131 212 34',
                                                   '+996 3946 212 34',
                                                   '+996 50 123 4567',
                                                   '+996 52 123 4567',
                                                   '+996 58 123 4567',
                                                   '+996 800 123 456']
      it_is_correct_for "Lao People's Democratic Republic", :samples => ['+856 96 443 333',
                                                                         '+856 30 443 3334',
                                                                         '+856 20 4433 3334']
      it_is_correct_for 'Latvia', :samples => ['+371 801 234 56',
                                               '+371 637 234 56',
                                               '+371 294 123 45']
      it_is_correct_for 'Lebanon', :samples => ['+961 1 123 456',
                                                '+961 4 123 456',
                                                '+961 3 123 456',
                                                '+961 70 123 456',
                                                '+961 90 123 456',
                                                '+961 81 123 456']
      it_is_correct_for 'Lesotho', :samples => '+266  7612 6866'
      it_is_correct_for 'Liberia', :samples => [['+231 2 123 4567', '+231 4 123 456']]
      it_is_correct_for 'Madagascar', :samples => ['+261 20 012 345 678',
                                                   '+261 20 124 3456',
                                                   '+261 512 345 678']
      it_is_correct_for 'Malawi', :samples => ['+265 1725 123',
                                               '+265 213 456 789',
                                               '+265 9123 456',
                                               '+265 991 123 456']
      it_is_correct_for 'Maldives (Republic of)', :samples => '+960  928 8399'
      it_is_correct_for 'Mali', :samples => '+223  1117 9812'

      it_is_correct_for 'Marshall Islands (Republic of the)', :samples => '+692  372 7183'
      it_is_correct_for 'Martinique (French Department of)', :samples => '+596 596 123 456'
      it_is_correct_for 'Mauritania', :samples => '+222  1234 5678'
      it_is_correct_for 'Mauritius', :samples => '+230  695 2277'
      it_is_correct_for 'Micronesia (Federated States of)', :samples => '+691  766 7914'
      it_is_correct_for 'Moldova', :samples => ['+373 800 123 45',
                                                '+373 22 123 345',
                                                '+373 241 123 45',
                                                '+373 605 123 45',
                                                '+373 803 123 45']
      it_is_correct_for 'Montenegro', :samples => ['+382 80 123 456',
                                                   ['+382 20 123 45', '+382 20 123 456'],
                                                   '+382 32 123 456',
                                                   '+382 78 103 456',
                                                   '+382 63 123',
                                                   '+382 63 123 456 7890',
                                                   '+382 77 103 456',
                                                   '+382 94 103 456',
                                                   '+382 88 103 456',
                                                   '+382 68 12',
                                                   '+382 68 12 1234 5678',
                                                   '+382 68 432 163',
                                                   '+382 69 705 542',
                                                   '+382 70 123',
                                                   '+382 70 123 456 7890']
      it_is_correct_for 'Namibia', :samples => ['+264 6751 613 24',
                                                '+264 67 175 890',
                                                '+264 63 088 612 345',
                                                '+264 85 1234 567']
      it_is_correct_for 'Nauru (Republic of)', :samples => '+674  239 8387'
      it_is_correct_for 'Norway', :samples => ['+47 51 23 45 67',
                                               '+47 41 23 45 67']
      it_is_correct_for 'Nepal', :samples => ['+977 1 434 5678',
                                              '+977 10 123 456',
                                              '+977 98 1234 5678']
      it_is_correct_for "New Caledonia (Territoire français d'outre-mer)", :samples => '+687  546 835'
      it_is_correct_for 'Nicaragua', :samples => '+505 12 345 678'
      it_is_correct_for 'Niger', :samples => '+227  1234 5678'
      it_is_correct_for 'Niue', :samples => '+683  3791'
      it_is_correct_for 'Oman', :samples => ['+968 24 423 123',
                                             '+968 25 423 123']
      it_is_correct_for 'Palau (Republic of)', :samples => '+680  483 7871'
      it_is_correct_for 'Panama (Republic of)', :samples => ['+507 800 1234',
                                                             '+507 6 123 4567',
                                                             '+507 2 123 456']
      it_is_correct_for 'Papua New Guinea', :samples => ['+675 3 123 567',
                                                         '+675 180 1234',
                                                         '+675 80 123 456',
                                                         '+675 91 123 456',
                                                         '+675 16 123 45',
                                                         '+675 184 1234 5678',
                                                         '+675 170 12',
                                                         '+675 189 1',
                                                         '+675 270 1234',
                                                         '+675 275 1234',
                                                         '+675 279 12',
                                                         '+675 115 1234 5678']
      it_is_correct_for 'Paraguay (Republic of)', :samples => [['+595 21 123 456', '+595 21 123 4567'],
                                                               '+595 345 123 456',
                                                               '+595 96 161 1234']
      it_is_correct_for 'Qatar', :samples => ['+974 1245 123 456',
                                              '+974 26 134 56',
                                              '+974 33 123 456',
                                              '+974 44 412 456',
                                              '+974 800 12 34',
                                              '+974 900 12 34',
                                              '+974 92 123',
                                              '+974 97 123']
      it_is_correct_for 'Reunion / Mayotte (new)', :samples => '+262 295 276 964'
      it_is_correct_for 'Saint Helena', :samples => '+290  5134'
      it_is_correct_for 'Saint Pierre and Miquelon (Collectivité territoriale de la République française)', :samples => '+508  474 714'
      it_is_correct_for 'Samoa (Independent State of)', :samples => ['+685 800 123',
                                                                     '+685 61 123',
                                                                     '+685 721 2345',
                                                                     '+685 830 123',
                                                                     '+685 601 234',
                                                                     '+685 841 2345']
      it_is_correct_for 'San Marino', :samples => ['+378 800 123',
                                                   '+378 800 123 4567',
                                                   '+378 012 345',
                                                   '+378 012 345 6789',
                                                   '+378 512 345',
                                                   '+378 512 345 6789']
      it_is_correct_for 'Sao Tome and Principe', :samples => ['+239 2 220 012',
                                                              '+239 9 920 012']
      it_is_correct_for 'Saudi Arabia (Kingdom of)', :samples => ['+966 50 296 3727',
                                                                  '+966 011 307 4838']
      it_is_correct_for 'Senegal', :samples => '+221  1234 56789'
      it_is_correct_for 'Serbia', :samples => ['+381 800 123 45',
                                               ['+381 10 123 45', '+381 10 123 456'],
                                               ['+381 11 123 456', '+381 11 123 4567'],
                                               '+381 72 123 456',
                                               '+381 60 123',
                                               '+381 60 123 4567',
                                               '+381 42 123 456',
                                               '+381 9 123 4567',
                                               '+381 60 123',
                                               '+381 60 123 456 7890',
                                               '+381 70 123 456',
                                               '+381 66 12 1234',
                                               ['+381 64 12 34567', '+381 64 12 3456'],
                                               ['+381 65 12 34567', '+381 65 12 3456']]
      it_is_correct_for 'Sierra Leone', :samples => '+232 42 393 972'
      it_is_correct_for 'Solomon Islands', :samples => '+677  97851'
      it_is_correct_for 'Somali Democratic Republic', :samples => ['+252 1034 123 45',
                                                                   '+252 1313 123',
                                                                   '+252 160 12 34',
                                                                   '+252 500 123 45',
                                                                   '+252 67 1234 567']
      it_is_correct_for 'South Sudan', :samples => ['+211 123 212 345',
                                                    '+211 973 212 345']
      it_is_correct_for 'Suriname (Republic of)', :samples => ['+597 212 345', '+597 612 3456']
      it_is_correct_for 'Swaziland', :samples => ['+268 2207 1234', '+268 550 1234']
      it_is_correct_for 'Syrian Arab Republic', :samples => ['+963 11 123 4567',
                                                             '+963 31 123 4567',
                                                             '+963 15 731 234',
                                                             '+963 9 1234 5678']
      it_is_correct_for 'Taiwan', :samples => ['+886 18 123 456',
                                               '+886 612 123 4567',
                                               '+886 2 1234 5678',
                                               '+886 3 123 4567',
                                               '+886 33 123 456',
                                               '+886 827 123 45',
                                               '+886 412 1234',
                                               ['+886 90 123 456', '+886 90 123 4567'],
                                               '+886 94 991 345']
      it_is_correct_for 'Tajikistan', :samples => ['+992 3130 123 45',
                                                   '+992 331700 123',
                                                   '+992 372 123 345',
                                                   '+992 505 123 456',
                                                   '+992 973 123 456',
                                                   '+992 474 456 123']
      it_is_correct_for 'Thailand', :samples => ['+6621231234',
                                                 '+6636123123',
                                                 '+66851234567']
      it_is_correct_for 'Togolese Republic', :samples => '+228 1234 5678'
      it_is_correct_for 'Tokelau', :samples => '+690 3 291'
      it_is_correct_for 'Tonga (Kingdom of)', :samples => ['+676 20 123',
                                                           '+676 84 123',
                                                           '+676 77 123 45',
                                                           '+676 89 123 45']
      it_is_correct_for 'Turkmenistan', :samples => ['+993 12 456 789',
                                                     '+993 131 456 78',
                                                     '+993 1392 4567',
                                                     '+993 6 123 4567']
      it_is_correct_for 'Tuvalu', :samples => '+688  93742'
      it_is_correct_for 'Uzbekistan (Republic of)', :samples => '+998 78 867 4419'
      it_is_correct_for 'Vanuatu (Republic of)', :samples => ['+678  7216 123', '+678  26 123']
      it_is_correct_for 'Lybia', :samples => ['+218 205 123 45',
                                              '+218 22 123 456',
                                              '+218 21 1234 456',
                                              '+218 91 1234 456']
      it_is_correct_for 'Mongolia', :samples => ['+976 11 123 45',
                                                 ['+976 121 12 34', '+976 121 12 345'],
                                                 '+976 70 123 456',
                                                 '+976 75 123 456',
                                                 '+976 88 123 456',
                                                 '+976 50 123 456']
      it_is_correct_for 'Mozambique', :samples => ['+258 600 123 456',
                                                   '+258 251 123 45',
                                                   '+258 82 1234 456',
                                                   '+258 7 1234 4567']
      it_is_correct_for 'Ukraine', :samples => ['+380 800 123 456',
                                                '+380 312 123 456',
                                                '+380 32 2123 456',
                                                '+380 3259 123 45',
                                                '+380 32606 1234',
                                                '+380 50 123 45 67',
                                                '+380 66 123 45 67',
                                                '+380 95 123 45 67',
                                                '+380 99 123 45 67',
                                                '+380 67 123 45 67',
                                                '+380 96 123 45 67',
                                                '+380 97 123 45 67',
                                                '+380 98 123 45 67',
                                                '+380 63 123 45 67',
                                                '+380 93 123 45 67',
                                                '+380 39 123 45 67',
                                                '+380 68 123 45 67',
                                                '+380 91 123 45 67',
                                                '+380 92 123 45 67',
                                                '+380 94 123 45 67'
                                              ]
      it_is_correct_for 'United Arab Emirates', :samples => ['+971 800 12',
                                                             '+971 800 12 345 6789',
                                                             '+971 2 123 4567',
                                                             '+971 50 641 2345',
                                                             '+971 600 641 234',
                                                             '+971 500 641 234',
                                                             '+971 200 641 234']

      it_is_correct_for 'United Kingdom', :samples => ['+44 1827 50111'], :invalid_samples => ['+44 0000 123456']

      it_is_correct_for 'Uruguay (Eastern Republic of)', :samples => ['+598 800 123 45',
                                                                      '+598 2 012 3456',
                                                                      '+598 21 123 456',
                                                                      '+598 909 123 45',
                                                                      '+598 93 123 456',
                                                                      '+598 908 123 45',
                                                                      '+598 805 123 45']
      it_is_correct_for 'Yemen', :samples => [['+967 1 234 567', '+967 1 234 5678'],
                                              '+967 7 234 567',
                                              '+967 77 123 4567',
                                              '+967 58 1234']
      it_is_correct_for 'Zimbabwe', :samples => [['+263 2582 123 456', '+263 2582 123'],
                                                 ['+263 147 123 456', '+263 147 123'],
                                                 ['+263 270 123 456', '+263 270 123 45'],
                                                 '+263 86 1235 4567']

    end
  end
end
