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
            Phony.plausible?(value).should be_truthy,
              "It should validate #{value}, but does not."
          end
          incorrect.each do |value|
            Phony.plausible?(value).should be_falsey,
              "It should not validate #{value}, but does."
          end
        end

        invalid_samples.each do |sample|
          invalid = [*sample]

          invalid.each do |value|
            Phony.plausible?(value).should be_falsey,
              "It should not validate #{value}, but does."
          end
        end
      end
    end

    context 'specific countries' do
      it_is_correct_for 'Austria', :samples => '+43 720 116987' # VoIP
      it_is_correct_for 'Bosnia and Herzegovina', :samples => ['+387 66 666 666',
                                                               '+387 37 123 456',
                                                               '+387 33 222 111']
      it 'is correct for Bulgaria' do
          Phony.plausible?('+359 2 1234567').should be_truthy
          Phony.plausible?('+359 30 12345').should be_truthy
          Phony.plausible?('+359 30 123456').should be_truthy
          Phony.plausible?('+359 31 12345').should be_truthy
          Phony.plausible?('+359 31 123456').should be_truthy
          Phony.plausible?('+359 32 123456').should be_truthy
          Phony.plausible?('+359 33 12345').should be_truthy
          Phony.plausible?('+359 33 123456').should be_truthy
          Phony.plausible?('+359 34 123456').should be_truthy
          Phony.plausible?('+359 35 123456').should be_truthy
          Phony.plausible?('+359 36 12345').should be_truthy
          Phony.plausible?('+359 36 123456').should be_truthy
          Phony.plausible?('+359 37 12345').should be_truthy
          Phony.plausible?('+359 37 123456').should be_truthy
          Phony.plausible?('+359 38 123456').should be_truthy
          Phony.plausible?('+359 39 12345').should be_truthy
          Phony.plausible?('+359 39 123456').should be_truthy
          Phony.plausible?('+359 41 12345').should be_truthy
          Phony.plausible?('+359 41 123456').should be_truthy
          Phony.plausible?('+359 42 123456').should be_truthy
          Phony.plausible?('+359 430 12345').should be_truthy
          Phony.plausible?('+359 431 12345').should be_truthy
          Phony.plausible?('+359 432 12345').should be_truthy
          Phony.plausible?('+359 433 12345').should be_truthy
          Phony.plausible?('+359 434 12345').should be_truthy
          Phony.plausible?('+359 435 12345').should be_truthy
          Phony.plausible?('+359 436 12345').should be_truthy
          Phony.plausible?('+359 437 12345').should be_truthy
          Phony.plausible?('+359 438 12345').should be_truthy
          Phony.plausible?('+359 439 12345').should be_truthy
          Phony.plausible?('+359 44 123456').should be_truthy
          Phony.plausible?('+359 45 12345').should be_truthy
          Phony.plausible?('+359 45 123456').should be_truthy
          Phony.plausible?('+359 46 123456').should be_truthy
          Phony.plausible?('+359 47 12345').should be_truthy
          Phony.plausible?('+359 47 123456').should be_truthy
          Phony.plausible?('+359 47 12345').should be_truthy
          Phony.plausible?('+359 47 123456').should be_truthy
          Phony.plausible?('+359 51 12345').should be_truthy
          Phony.plausible?('+359 51 123456').should be_truthy
          Phony.plausible?('+359 52 123456').should be_truthy
          Phony.plausible?('+359 53 12345').should be_truthy
          Phony.plausible?('+359 53 123456').should be_truthy
          Phony.plausible?('+359 54 123456').should be_truthy
          Phony.plausible?('+359 55 12345').should be_truthy
          Phony.plausible?('+359 55 123456').should be_truthy
          Phony.plausible?('+359 56 123456').should be_truthy
          Phony.plausible?('+359 57 12345').should be_truthy
          Phony.plausible?('+359 57 123456').should be_truthy
          Phony.plausible?('+359 58 123456').should be_truthy
          Phony.plausible?('+359 59 12345').should be_truthy
          Phony.plausible?('+359 59 123456').should be_truthy
          Phony.plausible?('+359 60 12345').should be_truthy
          Phony.plausible?('+359 60 123456').should be_truthy
          Phony.plausible?('+359 61 12345').should be_truthy
          Phony.plausible?('+359 61 123456').should be_truthy
          Phony.plausible?('+359 62 123456').should be_truthy
          Phony.plausible?('+359 63 12345').should be_truthy
          Phony.plausible?('+359 63 123456').should be_truthy
          Phony.plausible?('+359 64 123456').should be_truthy
          Phony.plausible?('+359 65 12345').should be_truthy
          Phony.plausible?('+359 65 123456').should be_truthy
          Phony.plausible?('+359 66 12345').should be_truthy
          Phony.plausible?('+359 66 123456').should be_truthy
          Phony.plausible?('+359 68 123456').should be_truthy
          Phony.plausible?('+359 69 12345').should be_truthy
          Phony.plausible?('+359 69 123456').should be_truthy
          Phony.plausible?('+359 700 12345').should be_truthy
          Phony.plausible?('+359 701 1234').should be_truthy
          Phony.plausible?('+359 701 12345').should be_truthy
          Phony.plausible?('+359 71 12345').should be_truthy
          Phony.plausible?('+359 71 123456').should be_truthy
          Phony.plausible?('+359 72 12345').should be_truthy
          Phony.plausible?('+359 72 123456').should be_truthy
          Phony.plausible?('+359 73 123456').should be_truthy
          Phony.plausible?('+359 74 12345').should be_truthy
          Phony.plausible?('+359 74 123456').should be_truthy
          Phony.plausible?('+359 75 12345').should be_truthy
          Phony.plausible?('+359 75 123456').should be_truthy
          Phony.plausible?('+359 76 123456').should be_truthy
          Phony.plausible?('+359 77 12345').should be_truthy
          Phony.plausible?('+359 77 123456').should be_truthy
          Phony.plausible?('+359 78 123456').should be_truthy
          Phony.plausible?('+359 79 123456').should be_truthy
          Phony.plausible?('+359 800 12345').should be_truthy
          Phony.plausible?('+359 81 12345').should be_truthy
          Phony.plausible?('+359 81 123456').should be_truthy
          Phony.plausible?('+359 82 123456').should be_truthy
          Phony.plausible?('+359 82 123456').should be_truthy
          Phony.plausible?('+359 84 123456').should be_truthy
          Phony.plausible?('+359 86 123456').should be_truthy
          Phony.plausible?('+359 87 1234567').should be_truthy
          Phony.plausible?('+359 88 1234567').should be_truthy
          Phony.plausible?('+359 89 1234567').should be_truthy
          Phony.plausible?('+359 90 123456').should be_truthy
          Phony.plausible?('+359 91 12345').should be_truthy
          Phony.plausible?('+359 91 123456').should be_truthy
          Phony.plausible?('+359 92 123456').should be_truthy
          Phony.plausible?('+359 93 12345').should be_truthy
          Phony.plausible?('+359 93 123456').should be_truthy
          Phony.plausible?('+359 94 123456').should be_truthy
          Phony.plausible?('+359 95 12345').should be_truthy
          Phony.plausible?('+359 95 123456').should be_truthy
          Phony.plausible?('+359 96 123456').should be_truthy
          Phony.plausible?('+359 97 12345').should be_truthy
          Phony.plausible?('+359 97 123456').should be_truthy
          Phony.plausible?('+359 980 123456').should be_truthy
          Phony.plausible?('+359 981 123456').should be_truthy
          Phony.plausible?('+359 982 123456').should be_truthy
          Phony.plausible?('+359 983 123456').should be_truthy
          Phony.plausible?('+359 984 123456').should be_truthy
          Phony.plausible?('+359 985 123456').should be_truthy
          Phony.plausible?('+359 986 123456').should be_truthy
          Phony.plausible?('+359 987 123456').should be_truthy
          Phony.plausible?('+359 988 123456').should be_truthy
          Phony.plausible?('+359 989 123456').should be_truthy
          Phony.plausible?('+359 990 123456').should be_truthy
          Phony.plausible?('+359 991 123456').should be_truthy
          Phony.plausible?('+359 992 123456').should be_truthy
          Phony.plausible?('+359 993 123456').should be_truthy
          Phony.plausible?('+359 994 123456').should be_truthy
          Phony.plausible?('+359 995 123456').should be_truthy
          Phony.plausible?('+359 996 123456').should be_truthy
          Phony.plausible?('+359 997 123456').should be_truthy
          Phony.plausible?('+359 998 123456').should be_truthy
          Phony.plausible?('+359 999 123456').should be_truthy
      end
      it_is_correct_for 'Congo', :samples => '+242 1234 56789'
      it_is_correct_for 'Cook Islands', :samples => '+682  71928'
      it_is_correct_for 'Costa Rica', :samples => '+506 2 234 5678'
      it 'is correct for Croatia' do
          Phony.plausible?('+385 21 695 900').should be_truthy  # Landline
          Phony.plausible?('+385 1 4566 666').should be_truthy  # Landline (Zagreb)
          Phony.plausible?('+385 99 444 999').should be_truthy  # Mobile
          Phony.plausible?('+385 91 896 7509').should be_truthy # Mobile
          Phony.plausible?('+385 800 1234').should be_truthy    # Toll free
          Phony.plausible?('+385 800 123 456').should be_truthy # Toll free
          Phony.plausible?('+385 60 12 345').should be_truthy   # Premium rate
          Phony.plausible?('+385 62 123 456').should be_truthy  # Premium, personal and UAN
      end
      it_is_correct_for "Côte d'Ivoire", :samples => '+225  9358 8764'
      it_is_correct_for 'Democratic Republic of Timor-Leste', :samples => ['+670 465 7886', '+670 7465 7886']
      it_is_correct_for 'Democratic Republic of the Congo', :samples => '+243 80 864 9794'
      it_is_correct_for 'Diego Garcia', :samples => '+246  123 7686'
      it_is_correct_for 'Djibouti', :samples => '+253  3671 1431'
      it 'is correct for Ecuador' do
        Phony.plausible?('+593 22 000 0000').should be_truthy
        Phony.plausible?('+593 23 000 0000').should be_truthy
        Phony.plausible?('+593 26 000 0000').should be_truthy
        Phony.plausible?('+593 27 000 0000').should be_truthy
        Phony.plausible?('+593 44 000 0000').should be_truthy
        Phony.plausible?('+593 45 000 0000').should be_truthy
        Phony.plausible?('+593 47 000 0000').should be_truthy
        Phony.plausible?('+593 2 200 0000').should be_truthy
        Phony.plausible?('+593 2 300 0000').should be_truthy
        Phony.plausible?('+593 2 400 0000').should be_truthy
        Phony.plausible?('+593 2 500 0000').should be_truthy
        Phony.plausible?('+593 2 700 0000').should be_truthy
        Phony.plausible?('+593 3 000 0000').should be_truthy
        Phony.plausible?('+593 4 000 0000').should be_truthy
        Phony.plausible?('+593 4 500 0000').should be_truthy
        Phony.plausible?('+593 4 600 0000').should be_truthy
        Phony.plausible?('+593 5 200 0000').should be_truthy
        Phony.plausible?('+593 5 300 0000').should be_truthy
        Phony.plausible?('+593 6 200 0000').should be_truthy
        Phony.plausible?('+593 7 200 0000').should be_truthy
        Phony.plausible?('+593 7 300 0000').should be_truthy
        Phony.plausible?('+593 7 400 0000').should be_truthy
        Phony.plausible?('+593 7 600 0000').should be_truthy
        Phony.plausible?('+593 9 0000 0000').should be_truthy # mobile
      end
      it_is_correct_for 'Equatorial Guinea', :samples => ['+240 222 201 123',
                                                          '+240 335 201 123']
      it_is_correct_for 'Eritrea', :samples => '+291 6 334 475'
      it_is_correct_for 'Ethiopia', :samples => '+251 89 558 3197'
      it_is_correct_for 'Falkland Islands (Malvinas)', :samples => '+500  28494'
      it_is_correct_for 'Faroe Islands', :samples => '+298  969 597'
      it_is_correct_for 'Fiji (Republic of)', :samples => '+679  998 2441'
      it 'is correct for Finland' do
        Phony.plausible?('+358 50 123 4').should be_truthy
        Phony.plausible?('+358 50 123 45').should be_truthy
        Phony.plausible?('+358 50 123 45 6').should be_truthy
        Phony.plausible?('+358 50 123 45 67').should be_truthy
        Phony.plausible?('+358 50 123 45 678').should be_truthy
        Phony.plausible?('+358 49 123 456 789').should be_truthy
        Phony.plausible?('+358 18 1234').should be_truthy
        Phony.plausible?('+358 9 1234').should be_truthy
        Phony.plausible?('+358 9 123 45').should be_truthy
        Phony.plausible?('+358 9 123 456').should be_truthy
        Phony.plausible?('+358 9 123 4567').should be_truthy
        Phony.plausible?('+358 20 1470 740').should be_truthy
        Phony.plausible?('+358 29 123 4567').should be_truthy
        Phony.plausible?('+358 75323 1234').should be_truthy
        Phony.plausible?('+358 50 123 456 789').should be_falsey
      end
      it_is_correct_for 'French Guiana (French Department of)', :samples => '+594 594 123 456'
      it_is_correct_for "French Polynesia (Territoire français d'outre-mer)", :samples => '+689 87 27 84 00'
      it_is_correct_for 'Gabonese Republic', :samples => '+241 1 627 739'
      it_is_correct_for 'Gambia', :samples => '+220  989 5148'
      it_is_correct_for 'Germany', :samples => [
        '+49 1577 536 8701'
      ]
      it_is_correct_for 'Georgia', :samples => ['+995 220 123 45',
                                                '+995 32 123 4567',
                                                '+995 342 123 456',
                                                '+995 596 123 456']
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

      it_is_correct_for 'Guinea-Bissau', :samples => '+245 44 728 6998'
      it_is_correct_for 'Guyana', :samples => '+592 263 1234'
      it_is_correct_for 'Honduras (Republic of)', :samples => '+504 12 961 637'
      it_is_correct_for 'Iraq', :samples => ['+964 1 123 4567',
                                             '+964 21 113 456',
                                             '+964 71 1234 5678']


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
      it 'is correct for Liberia' do
        Phony.plausible?('+231 2 123 4567').should be_truthy
        Phony.plausible?('+231 4 123 456').should be_truthy
        Phony.plausible?('+231 77 123 4567').should be_truthy
      end
      it_is_correct_for 'Macao', :samples => ['+853 28 12 3456',
                                              '+853 8 123 4567',
                                              '+853 6 123 4567',]
      it_is_correct_for 'Macedonia', :samples => ['+389 2 123 4567',
                                                   '+389 7 124 3456',
                                                   '+389 7 234 5678']
      it_is_correct_for 'Madagascar', :samples => ['+261 20 012 345 678',
                                                   '+261 20 124 3456',
                                                   '+261 512 345 678',
                                                   '+261 33 345 6789']
      it_is_correct_for 'Malawi', :samples => ['+265 1725 123',
                                               '+265 213 456 789',
                                               '+265 9123 456',
                                               '+265 991 123 456']
      it_is_correct_for 'Maldives (Republic of)', :samples => '+960  928 8399'
      it_is_correct_for 'Mali', :samples => '+223  1117 9812'

      it_is_correct_for 'Marshall Islands (Republic of the)', :samples => '+692  372 7183'
      it_is_correct_for 'Martinique (French Department of)', :samples => '+596 596 123 456'
      it_is_correct_for 'Mauritania', :samples => '+222  1234 5678'
      it_is_correct_for 'Mauritius', :samples => '+230  5695 2277'
      it_is_correct_for 'Micronesia (Federated States of)', :samples => '+691  766 7914'
      it_is_correct_for 'Moldova', :samples => ['+373 800 123 45',
                                                '+373 22 123 345',
                                                '+373 241 123 45',
                                                '+373 605 123 45',
                                                '+373 803 123 45']
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
      it 'is correct for New Zealand' do
        Phony.plausible?('+64800123123').should be_truthy # Free phone
        Phony.plausible?('+648001231234').should be_truthy # Free phone
      end
      it_is_correct_for 'Nicaragua', :samples => '+505 12 345 678'
      it_is_correct_for 'Niger', :samples => '+227  1234 5678'
      it_is_correct_for 'Niue', :samples => '+683  3791'
      it_is_correct_for 'Oman', :samples => ['+968 24 423 123',
                                             '+968 25 423 123']
      it_is_correct_for 'Palau (Republic of)', :samples => '+680  483 7871'

      it_is_correct_for 'Papua New Guinea', :samples => ['+675 180 1234',
                                                         '+675 170 12',
                                                         '+675 189 1',
                                                         '+675 184 1234 5678',
                                                         '+675 185 1234',
                                                         '+675 275 1234',
                                                         '+675 278 12',
                                                         '+675 115 1234 5678',
                                                         '+675 28 123 45',
                                                         '+675 16 123 12',
                                                         '+675 711 23 456',
                                                         '+675 731 23 456',
                                                         '+675 741 23 456',
                                                         '+675 770 12 345',
                                                         '+675 771 12 345',
                                                         '+675 772 12 345',
                                                         '+675 773 01 234',
                                                         '+675 774 12 345',
                                                         '+675 775 12 345',
                                                         '+675 80 123 456',
                                                         '+675 90 123 456',
                                                         '+675 3 123 456']

      it_is_correct_for 'Panama (Republic of)', :samples => ['+507 800 1234',
                                                             '+507 6 123 4567',
                                                             '+507 2 123 456']
      it_is_correct_for 'Reunion / Mayotte (new)', :samples => '+262 295 276 964'
      it_is_correct_for 'Saint Helena', :samples => '+290  5134'
      it_is_correct_for 'Saint Pierre and Miquelon (Collectivité territoriale de la République française)', :samples => '+508  474 714'
      it_is_correct_for 'Salvador (El)', :samples => [
                                                       '+503 2112 1234',
                                                       '+503 6112 1234'
                                                     ]
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
                                               '+381 63 123 456',
                                               ['+381 64 12 34567', '+381 64 12 3456'],
                                               ['+381 62 12 34567', '+381 62 12 3456'],
                                               ['+381 65 12 34567', '+381 65 12 3456']]
      it_is_correct_for 'Sierra Leone', :samples => '+232 42 393 972'
      it_is_correct_for 'Singapore', :samples => ['+65 6123 1234',
                                                  '+65 800 852 1234']
      it_is_correct_for 'Solomon Islands', :samples => '+677  97851'
      it_is_correct_for 'Somali Democratic Republic', :samples => ['+252 1034 123 45',
                                                                   '+252 1313 123',
                                                                   '+252 160 12 34',
                                                                   '+252 500 123 45',
                                                                   '+252 67 1234 567']

      it 'is correct for South Korea' do
        Phony.plausible?('+82 2 1234 5678').should be_truthy
        Phony.plausible?('+82 2 711 2222').should be_truthy
        Phony.plausible?('+82 51 1234 5678').should be_truthy
        Phony.plausible?('+82 51 123 5678').should be_truthy
        Phony.plausible?('+82 10 2797 5588').should be_truthy
        Phony.plausible?('+82 10 8797 1234').should be_truthy
      end

      it_is_correct_for 'South Sudan', :samples => ['+211 123 212 345',
                                                    '+211 973 212 345']
      it_is_correct_for 'Suriname (Republic of)', :samples => ['+597 212 345', '+597 612 3456']
      it_is_correct_for 'Swaziland', :samples => ['+268 2207 1234', '+268 550 1234']
      it_is_correct_for 'Sweden', :samples => ['+46 42 123 45', ['+46 417 123 45', '+46 522 636 365', '+46 513 12 34 56']]
      it_is_correct_for 'Syrian Arab Republic', :samples => ['+963 11 123 4567',
                                                             '+963 31 123 4567',
                                                             '+963 15 731 234',
                                                             '+963 9 1234 5678']
      it_is_correct_for 'Taiwan', :samples => ['+886 6 123 4567',
                                               '+886 3 123 4567',
                                               '+886 33 123 456',
                                               '+886 827 123 45',
                                               '+886 4 123 1234',
                                               '+886 9 1234 5678']
      it_is_correct_for 'Tajikistan', :samples => ['+992 3130 123 45',
                                                   '+992 331700 123',
                                                   '+992 372 123 345',
                                                   '+992 505 123 456',
                                                   '+992 973 123 456',
                                                   '+992 474 456 123']
      it_is_correct_for 'Thailand', :samples => ['+6621231234',
                                                 '+6636123123',
                                                 '+66612345678',
                                                 '+66851234567',
                                                 '+66921234567']
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
                                                             '+971 800 12 345 67',
                                                             '+971 2 123 4567',
                                                             '+971 50 641 2345',
                                                             '+971 600 641 234',
                                                             '+971 500 641 234',
                                                             '+971 200 641 234',
                                                             '+971 54 999 9999',
                                                             '+971 58 999 9999']

      it_is_correct_for 'United Kingdom', :samples => ['+44 1827 50111'], :invalid_samples => ['+44 0000 123456']

      it_is_correct_for 'Uruguay (Eastern Republic of)', :samples => ['+598 800 123 45',
                                                                      '+598 2 012 3456',
                                                                      '+598 21 123 456',
                                                                      '+598 909 123 45',
                                                                      '+598 93 123 456',
                                                                      '+598 908 123 45',
                                                                      '+598 805 123 45']
      it_is_correct_for 'Vietnam', :samples => ['+84 24 41234567',
                                                '+84 28 41234567',
                                                '+84 23 61234567']
      it_is_correct_for 'Yemen', :samples => [['+967 1 234 567', '+967 1 234 5678'],
                                              '+967 7 234 567',
                                              '+967 77 123 4567',
                                              '+967 58 1234']
      it 'is correct for Zambia' do
        Phony.plausible?('+260 211 123456').should be_truthy  # Fixed
        Phony.plausible?('+260 955 123456').should be_truthy  # Mobile
        Phony.plausible?('+260 967 123456').should be_truthy  # Mobile
        Phony.plausible?('+260 978 123456').should be_truthy  # Mobile
        Phony.plausible?('+260 800 123 456').should be_truthy # Toll free
      end
      it_is_correct_for 'Zimbabwe', :samples => [['+263 2582 123 456', '+263 2582 123'],
                                                 ['+263 147 123 456', '+263 147 123'],
                                                 ['+263 270 123 456', '+263 270 123 45'],
                                                 '+263 86 1235 4567']

      it 'is correct for Indonesia' do
        Phony.plausible?('+62 22 000 0').should be_falsey
        Phony.plausible?('+62 22 000 00').should be_truthy
        Phony.plausible?('+62 22 000 0000').should be_truthy
        Phony.plausible?('+62 22 0000 0000').should be_truthy
        Phony.plausible?('+62 22 000 000 000').should be_truthy
      end

      it 'is correct for Russia' do
        Phony.plausible?('+7 3522 000 000').should be_truthy
      end

      it 'is correct for Peru' do
        Phony.plausible?('+51 1 123 1234').should be_truthy # Lima
        Phony.plausible?('+51 9 1234 1234').should be_truthy # mobile
        Phony.plausible?('+51 84 123 123').should be_truthy # Cuzco, best effort
      end

      it 'is correct for Kosovo' do
        Phony.plausible?('+383 29 000 000').should be_truthy # Landline
        Phony.plausible?('+383 44 000 000').should be_truthy # Mobile
      end

      it 'is correct for Bulgaria' do
        Phony.plausible?('+359 2 123 123').should be_truthy     # Landline Sofia
        Phony.plausible?('+359 2 123 1234').should be_truthy    # Landline Sofia
        Phony.plausible?('+359 30 123 12').should be_truthy     # Landline
        Phony.plausible?('+359 30 123 123').should be_truthy    # Landline
        Phony.plausible?('+359 89 123 1234').should be_truthy   # Mobile
      end

      it 'is correct for Malaysia' do
        Phony.plausible?('+60 5 123 1234').should be_truthy     # Non Selangor Landline
        Phony.plausible?('+60 3 1234 1234').should be_truthy     # Selangor Landline
        Phony.plausible?('+60 88 123 123').should be_truthy     #  Landline Sabah – Kota Kinabalu and Kudat
      end

      it 'is correct for Japan' do
        Phony.plausible?('+81 90 1234 1234').should be_truthy
        Phony.plausible?('+81 120 123 123').should be_truthy
        Phony.plausible?('+81 800 123 1234').should be_truthy
      end

      it 'is correct for Philippine' do
        Phony.plausible?('+63 976 1234567').should be_truthy # mobile phone with area code 9
        Phony.plausible?('+63 876 1234567').should be_truthy # mobile phone with area code 8
      end
    end
  end
end
