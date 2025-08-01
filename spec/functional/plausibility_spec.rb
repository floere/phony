require 'spec_helper'

describe 'plausibility' do
  describe 'plausible?' do
    # Validations test helper.
    # @param country_name [String]
    # @param options [Hash]
    # @option options [String, Array<String>] :samples
    #
    def self.it_is_correct_for(country_name, options = {})
      samples = [*options[:samples]]
      invalid_samples = [*options[:invalid_samples]]

      raise ArgumentError, ':samples option should be specified' if samples.empty?

      it "is correct for #{country_name}" do
        samples.each do |sample|
          correct = [*sample]

          shortest = correct.min_by { |x| x.scan(/\d/).length }
          incorrect = [shortest.sub(/\d\s*\z/, '')] # , longest + '0']

          correct.each do |value|
            expect(Phony).to be_plausible(value),
                             "It should validate #{value}, but does not."
          end
          incorrect.each do |value|
            expect(Phony).not_to be_plausible(value),
                                 "It should not validate #{value}, but does."
          end
        end

        invalid_samples.each do |sample|
          invalid = [*sample]

          invalid.each do |value|
            expect(Phony).not_to be_plausible(value),
                                 "It should not validate #{value}, but does."
          end
        end
      end
    end

    context 'with specific countries' do
      it_is_correct_for 'Austria', samples: ['+43 720 116987', # VoIP
                                             '+43 463 12345'] # Klagenfurt
      it_is_correct_for 'Bosnia and Herzegovina', samples: ['+387 66 666 666',
                                                            '+387 37 123 456',
                                                            '+387 33 222 111',
                                                            '+387 60 3456789',
                                                            '+387 64 4123456',
                                                            '+387 67 1234567']
      it 'is correct for Brasil' do
        expect(Phony).to be_plausible('+55 67 998280912')
        expect(Phony).not_to be_plausible('+55 67 98280912')
        expect(Phony).not_to be_plausible('+55 11 12345678')
        expect(Phony).not_to be_plausible('+55 11 123456789')
        expect(Phony).not_to be_plausible('+55 11 023456789')
        expect(Phony).to be_plausible('+55 11 22345678')
      end

      it 'is correct for Bulgaria' do
        expect(Phony).to be_plausible('+359 2 1234567')
        expect(Phony).to be_plausible('+359 30 12345')
        expect(Phony).to be_plausible('+359 30 123456')
        expect(Phony).to be_plausible('+359 31 12345')
        expect(Phony).to be_plausible('+359 31 123456')
        expect(Phony).to be_plausible('+359 32 123456')
        expect(Phony).to be_plausible('+359 33 12345')
        expect(Phony).to be_plausible('+359 33 123456')
        expect(Phony).to be_plausible('+359 34 123456')
        expect(Phony).to be_plausible('+359 35 123456')
        expect(Phony).to be_plausible('+359 36 12345')
        expect(Phony).to be_plausible('+359 36 123456')
        expect(Phony).to be_plausible('+359 37 12345')
        expect(Phony).to be_plausible('+359 37 123456')
        expect(Phony).to be_plausible('+359 38 123456')
        expect(Phony).to be_plausible('+359 39 12345')
        expect(Phony).to be_plausible('+359 39 123456')
        expect(Phony).to be_plausible('+359 41 12345')
        expect(Phony).to be_plausible('+359 41 123456')
        expect(Phony).to be_plausible('+359 42 123456')
        expect(Phony).to be_plausible('+359 430 12345')
        expect(Phony).to be_plausible('+359 431 12345')
        expect(Phony).to be_plausible('+359 432 12345')
        expect(Phony).to be_plausible('+359 433 12345')
        expect(Phony).to be_plausible('+359 434 12345')
        expect(Phony).to be_plausible('+359 435 12345')
        expect(Phony).to be_plausible('+359 436 12345')
        expect(Phony).to be_plausible('+359 437 12345')
        expect(Phony).to be_plausible('+359 438 12345')
        expect(Phony).to be_plausible('+359 439 12345')
        expect(Phony).to be_plausible('+359 44 123456')
        expect(Phony).to be_plausible('+359 45 12345')
        expect(Phony).to be_plausible('+359 45 123456')
        expect(Phony).to be_plausible('+359 46 123456')
        expect(Phony).to be_plausible('+359 47 12345')
        expect(Phony).to be_plausible('+359 47 123456')
        expect(Phony).to be_plausible('+359 47 12345')
        expect(Phony).to be_plausible('+359 47 123456')
        expect(Phony).to be_plausible('+359 51 12345')
        expect(Phony).to be_plausible('+359 51 123456')
        expect(Phony).to be_plausible('+359 52 123456')
        expect(Phony).to be_plausible('+359 53 12345')
        expect(Phony).to be_plausible('+359 53 123456')
        expect(Phony).to be_plausible('+359 54 123456')
        expect(Phony).to be_plausible('+359 55 12345')
        expect(Phony).to be_plausible('+359 55 123456')
        expect(Phony).to be_plausible('+359 56 123456')
        expect(Phony).to be_plausible('+359 57 12345')
        expect(Phony).to be_plausible('+359 57 123456')
        expect(Phony).to be_plausible('+359 58 123456')
        expect(Phony).to be_plausible('+359 59 12345')
        expect(Phony).to be_plausible('+359 59 123456')
        expect(Phony).to be_plausible('+359 60 12345')
        expect(Phony).to be_plausible('+359 60 123456')
        expect(Phony).to be_plausible('+359 61 12345')
        expect(Phony).to be_plausible('+359 61 123456')
        expect(Phony).to be_plausible('+359 62 123456')
        expect(Phony).to be_plausible('+359 63 12345')
        expect(Phony).to be_plausible('+359 63 123456')
        expect(Phony).to be_plausible('+359 64 123456')
        expect(Phony).to be_plausible('+359 65 12345')
        expect(Phony).to be_plausible('+359 65 123456')
        expect(Phony).to be_plausible('+359 66 12345')
        expect(Phony).to be_plausible('+359 66 123456')
        expect(Phony).to be_plausible('+359 68 123456')
        expect(Phony).to be_plausible('+359 69 12345')
        expect(Phony).to be_plausible('+359 69 123456')
        expect(Phony).to be_plausible('+359 700 12345')
        expect(Phony).to be_plausible('+359 701 1234')
        expect(Phony).to be_plausible('+359 701 12345')
        expect(Phony).to be_plausible('+359 71 12345')
        expect(Phony).to be_plausible('+359 71 123456')
        expect(Phony).to be_plausible('+359 72 12345')
        expect(Phony).to be_plausible('+359 72 123456')
        expect(Phony).to be_plausible('+359 73 123456')
        expect(Phony).to be_plausible('+359 74 12345')
        expect(Phony).to be_plausible('+359 74 123456')
        expect(Phony).to be_plausible('+359 75 12345')
        expect(Phony).to be_plausible('+359 75 123456')
        expect(Phony).to be_plausible('+359 76 123456')
        expect(Phony).to be_plausible('+359 77 12345')
        expect(Phony).to be_plausible('+359 77 123456')
        expect(Phony).to be_plausible('+359 78 123456')
        expect(Phony).to be_plausible('+359 79 123456')
        expect(Phony).to be_plausible('+359 800 12345')
        expect(Phony).to be_plausible('+359 81 12345')
        expect(Phony).to be_plausible('+359 81 123456')
        expect(Phony).to be_plausible('+359 82 123456')
        expect(Phony).to be_plausible('+359 82 123456')
        expect(Phony).to be_plausible('+359 84 123456')
        expect(Phony).to be_plausible('+359 86 123456')
        expect(Phony).to be_plausible('+359 87 1234567')
        expect(Phony).to be_plausible('+359 88 1234567')
        expect(Phony).to be_plausible('+359 89 1234567')
        expect(Phony).to be_plausible('+359 90 123456')
        expect(Phony).to be_plausible('+359 91 12345')
        expect(Phony).to be_plausible('+359 91 123456')
        expect(Phony).to be_plausible('+359 92 123456')
        expect(Phony).to be_plausible('+359 93 12345')
        expect(Phony).to be_plausible('+359 93 123456')
        expect(Phony).to be_plausible('+359 94 123456')
        expect(Phony).to be_plausible('+359 95 12345')
        expect(Phony).to be_plausible('+359 95 123456')
        expect(Phony).to be_plausible('+359 96 123456')
        expect(Phony).to be_plausible('+359 97 12345')
        expect(Phony).to be_plausible('+359 97 123456')
        expect(Phony).to be_plausible('+359 980 123456')
        expect(Phony).to be_plausible('+359 981 123456')
        expect(Phony).to be_plausible('+359 982 123456')
        expect(Phony).to be_plausible('+359 983 123456')
        expect(Phony).to be_plausible('+359 984 123456')
        expect(Phony).to be_plausible('+359 985 123456')
        expect(Phony).to be_plausible('+359 986 123456')
        expect(Phony).to be_plausible('+359 987 123456')
        expect(Phony).to be_plausible('+359 988 123456')
        expect(Phony).to be_plausible('+359 989 123456')
        expect(Phony).to be_plausible('+359 990 123456')
        expect(Phony).to be_plausible('+359 991 123456')
        expect(Phony).to be_plausible('+359 992 123456')
        expect(Phony).to be_plausible('+359 993 123456')
        expect(Phony).to be_plausible('+359 994 123456')
        expect(Phony).to be_plausible('+359 995 123456')
        expect(Phony).to be_plausible('+359 996 123456')
        expect(Phony).to be_plausible('+359 997 123456')
        expect(Phony).to be_plausible('+359 998 123456')
        expect(Phony).to be_plausible('+359 999 123456')
      end

      it_is_correct_for 'Colombia', samples: ['+57 601 411 1899',
                                              '+57 602 111 2222',
                                              '+57 603 111 2222',
                                              '+57 604 111 2222',
                                              '+57 605 111 2222',
                                              '+57 606 111 2222',
                                              '+57 607 111 2222',
                                              '+57 608 111 2222']
      it_is_correct_for 'Congo', samples: '+242 1234 56789'
      it_is_correct_for 'Cook Islands', samples: '+682  71928'
      it_is_correct_for 'Costa Rica', samples: '+506 2 234 5678'
      it 'is correct for Croatia' do
        expect(Phony).to be_plausible('+385 21 695 900')  # Landline
        expect(Phony).to be_plausible('+385 1 4566 666')  # Landline (Zagreb)
        expect(Phony).to be_plausible('+385 99 444 999')  # Mobile
        expect(Phony).to be_plausible('+385 91 896 7509') # Mobile
        expect(Phony).to be_plausible('+385 800 1234')    # Toll free
        expect(Phony).to be_plausible('+385 800 123 456') # Toll free
        expect(Phony).to be_plausible('+385 60 12 345')   # Premium rate
        expect(Phony).to be_plausible('+385 62 123 456')  # Premium, personal and UAN
      end

      it_is_correct_for "Côte d'Ivoire", samples: '+225 01 9358 8764'
      it_is_correct_for 'Democratic Republic of Timor-Leste', samples: ['+670 465 7886', '+670 7465 7886']
      it_is_correct_for 'Democratic Republic of the Congo', samples: '+243 80 864 9794'
      it_is_correct_for 'Diego Garcia', samples: '+246  123 7686'
      it_is_correct_for 'Djibouti', samples: '+253  3671 1431'
      it 'is correct for Ecuador' do
        expect(Phony).to be_plausible('+593 22 000 0000')
        expect(Phony).to be_plausible('+593 23 000 0000')
        expect(Phony).to be_plausible('+593 26 000 0000')
        expect(Phony).to be_plausible('+593 27 000 0000')
        expect(Phony).to be_plausible('+593 44 000 0000')
        expect(Phony).to be_plausible('+593 45 000 0000')
        expect(Phony).to be_plausible('+593 47 000 0000')
        expect(Phony).to be_plausible('+593 2 200 0000')
        expect(Phony).to be_plausible('+593 2 300 0000')
        expect(Phony).to be_plausible('+593 2 400 0000')
        expect(Phony).to be_plausible('+593 2 500 0000')
        expect(Phony).to be_plausible('+593 2 700 0000')
        expect(Phony).to be_plausible('+593 3 000 0000')
        expect(Phony).to be_plausible('+593 4 000 0000')
        expect(Phony).to be_plausible('+593 4 500 0000')
        expect(Phony).to be_plausible('+593 4 600 0000')
        expect(Phony).to be_plausible('+593 5 200 0000')
        expect(Phony).to be_plausible('+593 5 300 0000')
        expect(Phony).to be_plausible('+593 6 200 0000')
        expect(Phony).to be_plausible('+593 7 200 0000')
        expect(Phony).to be_plausible('+593 7 300 0000')
        expect(Phony).to be_plausible('+593 7 400 0000')
        expect(Phony).to be_plausible('+593 7 600 0000')
        expect(Phony).to be_plausible('+593 9 0000 0000') # mobile
      end

      it_is_correct_for 'Equatorial Guinea', samples: ['+240 222 201 123',
                                                       '+240 335 201 123']
      it_is_correct_for 'Eritrea', samples: '+291 6 334 475'
      it_is_correct_for 'Ethiopia', samples: '+251 89 558 3197'
      it_is_correct_for 'Falkland Islands (Malvinas)', samples: '+500  28494'
      it_is_correct_for 'Faroe Islands', samples: '+298  969 597'
      it_is_correct_for 'Fiji (Republic of)', samples: '+679  998 2441'
      it 'is correct for Finland' do
        expect(Phony).to be_plausible('+358 50 123 4')
        expect(Phony).to be_plausible('+358 50 123 45')
        expect(Phony).to be_plausible('+358 50 123 45 6')
        expect(Phony).to be_plausible('+358 50 123 45 67')
        expect(Phony).to be_plausible('+358 50 123 45 678')
        expect(Phony).to be_plausible('+358 49 123 456 789')
        expect(Phony).to be_plausible('+358 18 1234')
        expect(Phony).to be_plausible('+358 9 1234')
        expect(Phony).to be_plausible('+358 9 123 45')
        expect(Phony).to be_plausible('+358 9 123 456')
        expect(Phony).to be_plausible('+358 9 123 4567')
        expect(Phony).to be_plausible('+358 20 1470 740')
        expect(Phony).to be_plausible('+358 29 123 4567')
        expect(Phony).to be_plausible('+358 75323 1234')
        expect(Phony).not_to be_plausible('+358 50 123 456 789')
      end

      it_is_correct_for 'French Guiana (French Department of)', samples: '+594 594 123 456'
      it_is_correct_for "French Polynesia (Territoire français d'outre-mer)", samples: '+689 87 27 84 00'
      it 'is correct for Gabon' do
        expect(Phony).to be_plausible('+241 1 627 739')
        expect(Phony).to be_plausible('+241 12 34 56 78')
      end

      # it_is_correct_for 'Gabonese Republic', :samples => [
      #   '+241 1 627 739',
      #   '+241 12 34 56 78',
      # ]
      it_is_correct_for 'Gambia', samples: '+220  989 5148'
      it_is_correct_for 'Germany', samples: [
        '+49 69 155 1',
        '+49 1577 536 8701'
      ]
      it_is_correct_for 'Georgia', samples: ['+995 220 123 45',
                                             '+995 32 123 4567',
                                             '+995 342 123 456',
                                             '+995 596 123 456']
      it_is_correct_for 'Greenland', samples: '+299  922 954'
      it_is_correct_for 'Guadeloupe (French Department of)', samples: '+590 123 456 789'
      it_is_correct_for 'Guatemala (Republic of)', samples: ['+502 19 123 456 789',
                                                             '+502 2 123 4567']
      it_is_correct_for 'Guinea', samples: [
        '+224 664 12 34 56',
        '+224 30 31 12 34',
        '+224 3041 12 34',
        '+224 700 00 00 00'
      ]

      it_is_correct_for 'Guinea-Bissau', samples: '+245 44 728 6998'
      it_is_correct_for 'Guyana', samples: '+592 263 1234'
      it_is_correct_for 'Honduras (Republic of)', samples: '+504 12 961 637'
      it_is_correct_for 'Iraq', samples: ['+964 1 123 4567',
                                          '+964 21 113 456',
                                          '+964 71 1234 5678']

      it_is_correct_for 'Kiribati (Republic of)', samples: '+686  34814527'
      it_is_correct_for "Democratic People's Republic of Korea", samples: ['+850 2 123 45',
                                                                           '+850 2 123 456 789',
                                                                           '+850 2 381 2356',
                                                                           # '+850 2 8801 1234 5678 1256',
                                                                           '+850 191 123 4567']
      it_is_correct_for 'Kuwait (State of)', samples: ['+965 2345 6789',
                                                       '+965 181 2345',
                                                       '+965 4123 4567']
      it_is_correct_for 'Kenya', samples: [
        '254201234567',
        '254111234567',
        '254723100220',
        '+254-20-4262 140',
        '+254-(0)20-4262 140'
      ]

      it_is_correct_for "Lao People's Democratic Republic", samples: ['+856 96 443 333',
                                                                      '+856 30 443 3334',
                                                                      '+856 20 4433 3334']
      it_is_correct_for 'Latvia', samples: ['+371 801 234 56',
                                            '+371 637 234 56',
                                            '+371 294 123 45']
      it_is_correct_for 'Lebanon', samples: ['+961 1 123 456',
                                             '+961 4 123 456',
                                             '+961 3 123 456',
                                             '+961 70 123 456',
                                             '+961 90 123 456',
                                             '+961 81 123 456']
      it_is_correct_for 'Lesotho', samples: '+266  7612 6866'
      it 'is correct for Liberia' do
        expect(Phony).to be_plausible('+231 2 123 4567')
        expect(Phony).to be_plausible('+231 4 123 456')
        expect(Phony).to be_plausible('+231 77 123 4567')
      end

      it_is_correct_for 'Macao', samples: ['+853 28 12 3456',
                                           '+853 8 123 4567',
                                           '+853 6 123 4567']
      it_is_correct_for 'Macedonia', samples: ['+389 2 123 4567',
                                               '+389 7 124 3456',
                                               '+389 7 234 5678']
      it_is_correct_for 'Madagascar', samples: ['+261 20 23 456 78',
                                                '+261 32 34 546 78',
                                                '+261 33 34 546 78',
                                                '+261 34 34 546 78',
                                                '+261 37 34 546 78',
                                                '+261 38 34 546 78']
      it 'is incorrect for Madagascar' do
        expect(Phony).not_to be_plausible('+261 20 012 345 678')
        expect(Phony).not_to be_plausible('+261 20 12 434 569')
        expect(Phony).not_to be_plausible('+261 51 23 4567 8')
        expect(Phony).not_to be_plausible('+261 34 345 46789')
        expect(Phony).not_to be_plausible('+261 34 345 467')
      end

      it_is_correct_for 'Malawi', samples: ['+265 1725 123',
                                            '+265 213 456 789',
                                            '+265 9123 456',
                                            '+265 991 123 456']
      it_is_correct_for 'Maldives (Republic of)', samples: '+960  928 8399'
      it_is_correct_for 'Mali', samples: '+223  1117 9812'

      it_is_correct_for 'Marshall Islands (Republic of the)', samples: '+692  372 7183'
      it_is_correct_for 'Martinique (French Department of)', samples: '+596 596 123 456'
      it_is_correct_for 'Mauritania', samples: '+222  1234 5678'
      it_is_correct_for 'Mauritius', samples: ['+230  5 695 2277',
                                               '+230  260 0070']
      it_is_correct_for 'Micronesia (Federated States of)', samples: '+691  766 7914'
      it_is_correct_for 'Moldova', samples: ['+373 800 123 45',
                                             '+373 22 123 345',
                                             '+373 241 123 45',
                                             '+373 605 123 45',
                                             '+373 803 123 45']
      it_is_correct_for 'Namibia', samples: ['+264 6751 613 24',
                                             '+264 67 175 890',
                                             '+264 63 088 612 345',
                                             '+264 85 1234 567']
      it_is_correct_for 'Nauru (Republic of)', samples: '+674  239 8387'
      it_is_correct_for 'Norway', samples: ['+47 51 23 45 67',
                                            '+47 41 23 45 67']
      it_is_correct_for 'Nepal', samples: ['+977 1 434 5678',
                                           '+977 10 123 456',
                                           '+977 98 1234 5678']
      it_is_correct_for "New Caledonia (Territoire français d'outre-mer)", samples: '+687  546 835'
      it 'is correct for New Zealand' do
        expect(Phony).to be_plausible('+64800123123') # Free phone
        expect(Phony).to be_plausible('+648001231234') # Free phone
      end

      it_is_correct_for 'Nicaragua', samples: '+505 12 345 678'
      it_is_correct_for 'Niger', samples: '+227  1234 5678'
      it_is_correct_for 'Nigeria', samples: ['+234 807 059 1111',
                                             '+234 811 234 5678',
                                             '+234 64 830 00',
                                             '+234 1 280 444',
                                             '+234 85 123 456']
      it_is_correct_for 'Niue', samples: '+683  3791'
      it_is_correct_for 'Oman', samples: ['+968 24 423 123',
                                          '+968 25 423 123']
      it_is_correct_for 'Palau (Republic of)', samples: '+680  483 7871'

      it_is_correct_for 'Papua New Guinea', samples: ['+675 180 1234',
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

      it_is_correct_for 'Panama (Republic of)', samples: ['+507 800 1234',
                                                          '+507 6 123 4567',
                                                          '+507 2 123 456']
      it_is_correct_for 'Reunion / Mayotte (new)', samples: '+262 295 276 964'
      it_is_correct_for 'Rwanda', samples: ['+250 72 1234567',
                                            '+250 73 1234567',
                                            '+250 78 1234567',
                                            '+250 79 1234567',
                                            '+250 25 1234567',
                                            '+250 06 123456']
      it_is_correct_for 'Saint Helena', samples: '+290  5134'
      it_is_correct_for 'Saint Pierre and Miquelon (Collectivité territoriale de la République française)',
                        samples: '+508  474 714'
      it_is_correct_for 'Salvador (El)', samples: [
        '+503 2112 1234',
        '+503 6112 1234'
      ]
      it_is_correct_for 'Samoa (Independent State of)', samples: ['+685 800 123',
                                                                  '+685 61 123',
                                                                  '+685 721 2345',
                                                                  '+685 830 123',
                                                                  '+685 601 234',
                                                                  '+685 841 2345']
      it_is_correct_for 'San Marino', samples: ['+378 800 123',
                                                '+378 800 123 4567',
                                                '+378 012 345',
                                                '+378 012 345 6789',
                                                '+378 512 345',
                                                '+378 512 345 6789']
      it_is_correct_for 'Sao Tome and Principe', samples: ['+239 2 220 012',
                                                           '+239 9 920 012']
      it_is_correct_for 'Saudi Arabia (Kingdom of)', samples: ['+966 50 296 3727',
                                                               '+966 011 307 4838']
      it_is_correct_for 'Senegal', samples: '+221  1234 56789'
      it_is_correct_for 'Serbia', samples: ['+381 800 123 45',
                                            ['+381 10 123 45', '+381 10 123 456'],
                                            ['+381 11 123 456', '+381 11 123 4567'],
                                            '+381 72 123 456',
                                            '+381 60 123',
                                            ['+381 60 123 4567', '+381 69 123 456'],
                                            '+381 42 123 456',
                                            '+381 677 123 456',
                                            '+381 678 123 456',
                                            '+381 9 123 4567',
                                            '+381 60 123',
                                            '+381 60 123 456 7890',
                                            '+381 70 123 456',
                                            '+381 66 12 1234',
                                            '+381 63 123 456',
                                            ['+381 64 12 34567', '+381 64 12 3456'],
                                            ['+381 62 12 34567', '+381 62 12 3456'],
                                            ['+381 65 12 34567', '+381 65 12 3456']]
      it_is_correct_for 'Sierra Leone', samples: '+232 42 393 972'
      it_is_correct_for 'Singapore', samples: ['+65 6123 1234',
                                               '+65 800 852 1234']
      it_is_correct_for 'Solomon Islands', samples: '+677  97851'
      it_is_correct_for 'Somali Democratic Republic', samples: ['+252 1034 123 45',
                                                                '+252 1313 123',
                                                                '+252 160 12 34',
                                                                '+252 500 123 45',
                                                                '+252 67 1234 567']

      it 'is correct for South Korea' do
        expect(Phony).to be_plausible('+82 2 1234 5678')
        expect(Phony).to be_plausible('+82 2 711 2222')
        expect(Phony).to be_plausible('+82 51 1234 5678')
        expect(Phony).to be_plausible('+82 51 123 5678')
        expect(Phony).to be_plausible('+82 10 2797 5588')
        expect(Phony).to be_plausible('+82 10 8797 1234')
      end

      it_is_correct_for 'South Sudan', samples: ['+211 123 212 345',
                                                 '+211 973 212 345']
      it_is_correct_for 'Suriname (Republic of)', samples: ['+597 212 345', '+597 612 3456']
      it_is_correct_for 'Swaziland', samples: ['+268 2207 1234', '+268 550 1234']

      it_is_correct_for 'Sweden', samples: ['+46 10 1234567',
                                            ['+46 11 12345', '+46 11 1234567'],
                                            ['+46 120 12345', '+46 120 123456'],
                                            ['+46 121 12345', '+46 121 123456'],
                                            ['+46 122 12345', '+46 122 123456'],
                                            ['+46 123 12345', '+46 123 123456'],
                                            ['+46 125 12345', '+46 125 123456'],
                                            ['+46 13 12345', '+46 13 1234567'],
                                            ['+46 140 12345', '+46 140 123456'],
                                            ['+46 141 12345', '+46 141 123456'],
                                            ['+46 142 12345', '+46 142 123456'],
                                            ['+46 143 12345', '+46 143 123456'],
                                            ['+46 144 12345', '+46 144 123456'],
                                            ['+46 150 12345', '+46 150 123456'],
                                            ['+46 151 12345', '+46 151 123456'],
                                            ['+46 152 12345', '+46 152 123456'],
                                            ['+46 155 12345', '+46 155 123456'],
                                            ['+46 156 12345', '+46 156 123456'],
                                            ['+46 157 12345', '+46 157 123456'],
                                            ['+46 158 12345', '+46 158 123456'],
                                            ['+46 159 12345', '+46 159 123456'],
                                            ['+46 16 12345', '+46 16 1234567'],
                                            ['+46 171 12345', '+46 171 123456'],
                                            ['+46 173 12345', '+46 173 123456'],
                                            ['+46 174 12345', '+46 174 123456'],
                                            ['+46 175 12345', '+46 175 123456'],
                                            ['+46 176 12345', '+46 176 123456'],
                                            ['+46 18 123456', '+46 18 1234567'],
                                            ['+46 19 123456', '+46 19 1234567'],
                                            ['+46 20 1234', '+46 20 1234567'],
                                            ['+46 21 12345', '+46 21 1234567'],
                                            ['+46 220 12345', '+46 220 123456'],
                                            ['+46 221 12345', '+46 221 123456'],
                                            ['+46 222 12345', '+46 222 123456'],
                                            ['+46 223 12345', '+46 223 123456'],
                                            ['+46 224 12345', '+46 224 123456'],
                                            ['+46 225 12345', '+46 225 123456'],
                                            ['+46 226 12345', '+46 226 123456'],
                                            ['+46 227 12345', '+46 227 123456'],
                                            ['+46 23 12345', '+46 23 1234567'],
                                            ['+46 240 12345', '+46 240 123456'],
                                            ['+46 241 12345', '+46 241 123456'],
                                            ['+46 243 12345', '+46 243 123456'],
                                            ['+46 246 12345', '+46 246 123456'],
                                            ['+46 247 12345', '+46 247 123456'],
                                            ['+46 248 12345', '+46 248 123456'],
                                            ['+46 250 12345', '+46 250 123456'],
                                            ['+46 251 12345', '+46 251 123456'],
                                            '+46 252 123456789',
                                            ['+46 253 12345', '+46 253 123456'],
                                            '+46 254 123456789',
                                            '+46 255 123456789',
                                            ['+46 258 12345', '+46 258 123456'],
                                            ['+46 26 12345', '+46 26 1234567'],
                                            ['+46 270 12345', '+46 270 123456'],
                                            ['+46 271 12345', '+46 271 123456'],
                                            ['+46 278 12345', '+46 278 123456'],
                                            ['+46 280 12345', '+46 280 123456'],
                                            ['+46 281 12345', '+46 281 123456'],
                                            ['+46 290 12345', '+46 290 123456'],
                                            ['+46 291 12345', '+46 291 123456'],
                                            ['+46 292 12345', '+46 292 123456'],
                                            ['+46 293 12345', '+46 293 123456'],
                                            ['+46 294 12345', '+46 294 123456'],
                                            ['+46 295 12345', '+46 295 123456'],
                                            ['+46 297 12345', '+46 297 123456'],
                                            ['+46 300 12345', '+46 300 123456'],
                                            ['+46 301 12345', '+46 301 123456'],
                                            ['+46 302 12345', '+46 302 123456'],
                                            ['+46 303 12345', '+46 303 123456'],
                                            ['+46 304 12345', '+46 304 123456'],
                                            ['+46 31 123456', '+46 31 1234567'],
                                            ['+46 320 12345', '+46 320 123456'],
                                            ['+46 321 12345', '+46 321 123456'],
                                            ['+46 322 12345', '+46 322 123456'],
                                            ['+46 325 12345', '+46 325 123456'],
                                            ['+46 33 12345', '+46 33 1234567'],
                                            ['+46 340 12345', '+46 340 123456'],
                                            ['+46 345 12345', '+46 345 123456'],
                                            ['+46 346 12345', '+46 346 123456'],
                                            ['+46 35 12345', '+46 35 1234567'],
                                            ['+46 36 12345', '+46 36 1234567'],
                                            ['+46 370 12345', '+46 370 123456'],
                                            ['+46 371 12345', '+46 371 123456'],
                                            ['+46 372 12345', '+46 372 123456'],
                                            '+46 378 1234567',
                                            ['+46 380 12345', '+46 380 123456'],
                                            ['+46 381 12345', '+46 381 123456'],
                                            ['+46 382 12345', '+46 382 123456'],
                                            ['+46 383 12345', '+46 383 123456'],
                                            ['+46 390 12345', '+46 390 123456'],
                                            ['+46 392 12345', '+46 392 123456'],
                                            ['+46 393 12345', '+46 393 123456'],
                                            ['+46 40 12345', '+46 40 1234567'],
                                            ['+46 410 12345', '+46 410 123456'],
                                            ['+46 411 12345', '+46 411 123456'],
                                            ['+46 413 12345', '+46 413 123456'],
                                            ['+46 414 12345', '+46 414 123456'],
                                            ['+46 415 12345', '+46 415 123456'],
                                            ['+46 416 12345', '+46 416 123456'],
                                            ['+46 417 12345', '+46 417 123456'],
                                            ['+46 418 12345', '+46 418 123456'],
                                            ['+46 42 12345', '+46 42 1234567'],
                                            ['+46 430 12345', '+46 430 123456'],
                                            ['+46 431 12345', '+46 431 123456'],
                                            ['+46 433 12345', '+46 433 123456'],
                                            ['+46 435 12345', '+46 435 123456'],
                                            ['+46 44 12345', '+46 44 1234567'],
                                            ['+46 451 12345', '+46 451 123456'],
                                            ['+46 454 12345', '+46 454 123456'],
                                            ['+46 455 12345', '+46 455 123456'],
                                            ['+46 456 12345', '+46 456 123456'],
                                            ['+46 457 12345', '+46 457 123456'],
                                            ['+46 459 12345', '+46 459 123456'],
                                            ['+46 46 12345', '+46 46 1234567'],
                                            ['+46 470 12345', '+46 470 123456'],
                                            ['+46 471 12345', '+46 471 123456'],
                                            ['+46 472 12345', '+46 472 123456'],
                                            ['+46 474 12345', '+46 474 123456'],
                                            ['+46 476 12345', '+46 476 123456'],
                                            ['+46 477 12345', '+46 477 123456'],
                                            ['+46 478 12345', '+46 478 123456'],
                                            ['+46 479 12345', '+46 479 123456'],
                                            ['+46 480 12345', '+46 480 123456'],
                                            ['+46 481 12345', '+46 481 123456'],
                                            ['+46 485 12345', '+46 485 123456'],
                                            ['+46 486 12345', '+46 486 123456'],
                                            ['+46 490 12345', '+46 490 123456'],
                                            ['+46 491 12345', '+46 491 123456'],
                                            ['+46 492 12345', '+46 492 123456'],
                                            ['+46 493 12345', '+46 493 123456'],
                                            ['+46 494 12345', '+46 494 123456'],
                                            ['+46 495 12345', '+46 495 123456'],
                                            ['+46 496 12345', '+46 496 123456'],
                                            ['+46 498 12345', '+46 498 123456'],
                                            ['+46 499 12345', '+46 499 123456'],
                                            ['+46 500 12345', '+46 500 123456'],
                                            ['+46 501 12345', '+46 501 123456'],
                                            ['+46 502 12345', '+46 502 123456'],
                                            ['+46 503 12345', '+46 503 123456'],
                                            ['+46 504 12345', '+46 504 123456'],
                                            ['+46 505 12345', '+46 505 123456'],
                                            ['+46 506 12345', '+46 506 123456'],
                                            ['+46 510 12345', '+46 510 123456'],
                                            ['+46 511 12345', '+46 511 123456'],
                                            ['+46 512 12345', '+46 512 123456'],
                                            ['+46 513 12345', '+46 513 123456'],
                                            ['+46 514 12345', '+46 514 123456'],
                                            ['+46 515 12345', '+46 515 123456'],
                                            ['+46 520 12345', '+46 520 123456'],
                                            ['+46 521 12345', '+46 521 123456'],
                                            ['+46 522 12345', '+46 522 123456'],
                                            ['+46 523 12345', '+46 523 123456'],
                                            ['+46 524 12345', '+46 524 123456'],
                                            ['+46 525 12345', '+46 525 123456'],
                                            ['+46 526 12345', '+46 526 123456'],
                                            ['+46 528 12345', '+46 528 123456'],
                                            ['+46 530 12345', '+46 530 123456'],
                                            ['+46 531 12345', '+46 531 123456'],
                                            ['+46 532 12345', '+46 532 123456'],
                                            ['+46 533 12345', '+46 533 123456'],
                                            ['+46 534 12345', '+46 534 123456'],
                                            ['+46 54 123456', '+46 54 1234567'],
                                            ['+46 550 12345', '+46 550 123456'],
                                            ['+46 551 12345', '+46 551 123456'],
                                            ['+46 552 12345', '+46 552 123456'],
                                            ['+46 553 12345', '+46 553 123456'],
                                            ['+46 554 12345', '+46 554 123456'],
                                            ['+46 555 12345', '+46 555 123456'],
                                            ['+46 560 12345', '+46 560 123456'],
                                            ['+46 563 12345', '+46 563 123456'],
                                            ['+46 564 12345', '+46 564 123456'],
                                            ['+46 565 12345', '+46 565 123456'],
                                            ['+46 570 12345', '+46 570 123456'],
                                            ['+46 571 12345', '+46 571 123456'],
                                            ['+46 573 12345', '+46 573 123456'],
                                            ['+46 580 12345', '+46 580 123456'],
                                            ['+46 581 12345', '+46 581 123456'],
                                            ['+46 582 12345', '+46 582 123456'],
                                            ['+46 583 12345', '+46 583 123456'],
                                            ['+46 584 12345', '+46 584 123456'],
                                            ['+46 585 12345', '+46 585 123456'],
                                            ['+46 586 12345', '+46 586 123456'],
                                            ['+46 587 12345', '+46 587 123456'],
                                            ['+46 589 12345', '+46 589 123456'],
                                            ['+46 590 12345', '+46 590 123456'],
                                            ['+46 591 12345', '+46 591 123456'],
                                            ['+46 60 12345', '+46 60 1234567'],
                                            ['+46 611 12345', '+46 611 123456'],
                                            ['+46 612 12345', '+46 612 123456'],
                                            ['+46 613 12345', '+46 613 123456'],
                                            ['+46 620 12345', '+46 620 123456'],
                                            ['+46 621 12345', '+46 621 123456'],
                                            ['+46 622 12345', '+46 622 123456'],
                                            ['+46 623 12345', '+46 623 123456'],
                                            ['+46 624 12345', '+46 624 123456'],
                                            ['+46 63 12345', '+46 63 1234567'],
                                            ['+46 640 12345', '+46 640 123456'],
                                            ['+46 642 12345', '+46 642 123456'],
                                            ['+46 643 12345', '+46 643 123456'],
                                            ['+46 644 12345', '+46 644 123456'],
                                            ['+46 645 12345', '+46 645 123456'],
                                            ['+46 647 12345', '+46 647 123456'],
                                            ['+46 649 1', '+46 649 1234567890'],
                                            ['+46 650 12345', '+46 650 123456'],
                                            ['+46 651 12345', '+46 651 123456'],
                                            ['+46 652 12345', '+46 652 123456'],
                                            ['+46 653 12345', '+46 653 123456'],
                                            ['+46 655 1', '+46 655 1234567890'],
                                            ['+46 656 1', '+46 656 1234567890'],
                                            ['+46 657 12345', '+46 657 123456'],
                                            ['+46 660 12345', '+46 660 123456'],
                                            ['+46 661 12345', '+46 661 123456'],
                                            ['+46 662 12345', '+46 662 123456'],
                                            ['+46 663 12345', '+46 663 123456'],
                                            ['+46 670 12345', '+46 670 123456'],
                                            ['+46 671 12345', '+46 671 123456'],
                                            ['+46 672 12345', '+46 672 123456'],
                                            '+46 673 123456789',
                                            '+46 674 123456789',
                                            '+46 675 123456789',
                                            '+46 676 123456789',
                                            '+46 678 123456789',
                                            ['+46 680 12345', '+46 680 123456'],
                                            ['+46 682 12345', '+46 682 123456'],
                                            ['+46 684 12345', '+46 684 123456'],
                                            ['+46 687 12345', '+46 687 123456'],
                                            ['+46 690 12345', '+46 690 123456'],
                                            ['+46 691 12345', '+46 691 123456'],
                                            ['+46 692 12345', '+46 692 123456'],
                                            ['+46 693 12345', '+46 693 123456'],
                                            ['+46 695 12345', '+46 695 123456'],
                                            ['+46 696 12345', '+46 696 123456'],
                                            '+46 70 1234567',
                                            '+46 71 12345678901',
                                            '+46 72 1234567',
                                            '+46 73 1234567',
                                            '+46 74 1234567',
                                            '+46 75 1234567',
                                            '+46 76 1234567',
                                            '+46 77 1234567',
                                            '+46 79 1234567',
                                            ['+46 8 123456', '+46 8 12345678'],
                                            ['+46 90 12345', '+46 90 1234567'],
                                            ['+46 900 1234', '+46 900 1234567'],
                                            ['+46 910 12345', '+46 910 123456'],
                                            ['+46 911 12345', '+46 911 123456'],
                                            ['+46 912 12345', '+46 912 123456'],
                                            ['+46 913 12345', '+46 913 123456'],
                                            ['+46 914 12345', '+46 914 123456'],
                                            ['+46 915 12345', '+46 915 123456'],
                                            ['+46 916 12345', '+46 916 123456'],
                                            ['+46 918 12345', '+46 918 123456'],
                                            ['+46 920 12345', '+46 920 123456'],
                                            ['+46 921 12345', '+46 921 123456'],
                                            ['+46 922 12345', '+46 922 123456'],
                                            ['+46 923 12345', '+46 923 123456'],
                                            ['+46 924 12345', '+46 924 123456'],
                                            ['+46 925 12345', '+46 925 123456'],
                                            ['+46 926 12345', '+46 926 123456'],
                                            ['+46 927 12345', '+46 927 123456'],
                                            ['+46 928 12345', '+46 928 123456'],
                                            ['+46 929 12345', '+46 929 123456'],
                                            ['+46 930 12345', '+46 930 123456'],
                                            ['+46 932 12345', '+46 932 123456'],
                                            ['+46 933 12345', '+46 933 123456'],
                                            ['+46 934 12345', '+46 934 123456'],
                                            ['+46 935 12345', '+46 935 123456'],
                                            ['+46 939 1234', '+46 939 1234567'],
                                            ['+46 940 12345', '+46 940 123456'],
                                            ['+46 941 12345', '+46 941 123456'],
                                            ['+46 942 12345', '+46 942 123456'],
                                            ['+46 943 12345', '+46 943 123456'],
                                            ['+46 944 1234', '+46 944 1234567'],
                                            ['+46 950 12345', '+46 950 123456'],
                                            ['+46 951 12345', '+46 951 123456'],
                                            ['+46 952 12345', '+46 952 123456'],
                                            ['+46 953 12345', '+46 953 123456'],
                                            ['+46 954 12345', '+46 954 123456'],
                                            ['+46 958 1', '+46 958 1234567890'],
                                            ['+46 960 12345', '+46 960 123456'],
                                            ['+46 961 12345', '+46 961 123456'],
                                            ['+46 970 12345', '+46 970 123456'],
                                            ['+46 971 12345', '+46 971 123456'],
                                            ['+46 973 12345', '+46 973 123456'],
                                            ['+46 975 12345', '+46 975 123456'],
                                            ['+46 976 12345', '+46 976 123456'],
                                            ['+46 977 12345', '+46 977 123456'],
                                            ['+46 978 12345', '+46 978 123456'],
                                            ['+46 980 12345', '+46 980 123456'],
                                            ['+46 981 12345', '+46 981 123456'],
                                            '+46 99 12345']

      it 'is correct for short fixed Swedish numbers' do
        expect(Phony).to be_plausible('+46 8 110')
        expect(Phony).to be_plausible('+46 8 950')
        expect(Phony).to be_plausible('+46 8 9500')
        expect(Phony).to be_plausible('+46 8 90000')
        expect(Phony).to be_plausible('+46 11 110')
        expect(Phony).to be_plausible('+46 11 9500')
        expect(Phony).to be_plausible('+46 11 90000')
        expect(Phony).to be_plausible('+46 120 110')
        expect(Phony).to be_plausible('+46 120 9500')
        expect(Phony).to be_plausible('+46 120 90000')
      end

      it_is_correct_for 'Syrian Arab Republic', samples: ['+963 11 123 4567',
                                                          '+963 31 123 4567',
                                                          '+963 15 731 234',
                                                          '+963 9 1234 5678']
      it_is_correct_for 'Taiwan', samples: ['+886 6 123 4567',
                                            '+886 3 123 4567',
                                            '+886 33 123 456',
                                            '+886 827 123 45',
                                            '+886 4 123 1234',
                                            '+886 9 1234 5678']
      it_is_correct_for 'Tajikistan', samples: ['+992 3130 123 45',
                                                '+992 331700 123',
                                                '+992 372 123 345',
                                                '+992 505 123 456',
                                                '+992 973 123 456',
                                                '+992 474 456 123']
      it_is_correct_for 'Thailand', samples: ['+6621231234',
                                              '+6636123123',
                                              '+66612345678',
                                              '+66851234567',
                                              '+66921234567']
      it_is_correct_for 'Togolese Republic', samples: '+228 1234 5678'
      it_is_correct_for 'Tokelau', samples: '+690 3 291'
      it_is_correct_for 'Tonga (Kingdom of)', samples: ['+676 20 123',
                                                        '+676 84 123',
                                                        '+676 77 123 45',
                                                        '+676 89 123 45']
      it_is_correct_for 'Turkmenistan', samples: ['+993 12 456 789',
                                                  '+993 131 456 78',
                                                  '+993 1392 4567',
                                                  '+993 6 123 4567']
      it_is_correct_for 'Tuvalu', samples: '+688  93742'
      it_is_correct_for 'Uzbekistan (Republic of)', samples: '+998 78 867 4419'
      it_is_correct_for 'Vanuatu (Republic of)', samples: ['+678  7216 123', '+678  26 123']
      it_is_correct_for 'Lybia', samples: ['+218 205 123 45',
                                           '+218 22 123 456',
                                           '+218 21 1234 456',
                                           '+218 91 1234 456',
                                           '+218 92 1234 456',
                                           '+218 94 1234 456',
                                           '+218 95 1234 456']
      it_is_correct_for 'Mongolia', samples: ['+976 11 123 45',
                                              ['+976 121 12 34', '+976 121 12 345'],
                                              '+976 70 123 456',
                                              '+976 75 123 456',
                                              '+976 88 123 456',
                                              '+976 50 123 456']
      it_is_correct_for 'Mozambique', samples: ['+258 600 123 456',
                                                '+258 251 123 45',
                                                '+258 82 1234 456',
                                                '+258 7 1234 4567']
      it_is_correct_for 'Ukraine', samples: ['+380 800 123 456',
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
                                             '+380 94 123 45 67']
      it_is_correct_for 'United Arab Emirates', samples: ['+971 800 12',
                                                          '+971 800 12 345 6789',
                                                          '+971 800 12 345 67',
                                                          '+971 2 123 4567',
                                                          '+971 50 641 2345',
                                                          '+971 600 641 234',
                                                          '+971 500 641 234',
                                                          '+971 200 641 234',
                                                          '+971 54 999 9999',
                                                          '+971 58 999 9999']

      it_is_correct_for 'United Kingdom', samples: ['+44 1827 50111'], invalid_samples: ['+44 0000 123456']

      it_is_correct_for 'Uruguay (Eastern Republic of)', samples: ['+598 800 123 45',
                                                                   '+598 2 012 3456',
                                                                   '+598 21 123 456',
                                                                   '+598 909 123 45',
                                                                   '+598 93 123 456',
                                                                   '+598 908 123 45',
                                                                   '+598 805 123 45']
      it_is_correct_for 'Vietnam', samples: ['+84 24 41234567',
                                             '+84 28 41234567',
                                             '+84 23 61234567',
                                             '+84 1900 1212',
                                             '+84 1900 541234']

      it 'is correct for 55 Vietnam mobile code' do
        expect(Phony).to be_plausible('+84 55 9905599') # Wintel (Previously Reddi)
      end

      it_is_correct_for 'Yemen', samples: [['+967 1 234 567', '+967 1 234 5678'],
                                           '+967 7 234 567',
                                           '+967 77 123 4567',
                                           '+967 58 1234']
      it 'is correct for Zambia' do
        expect(Phony).to be_plausible('+260 211 123456')  # Fixed
        expect(Phony).to be_plausible('+260 96 512 4567') # MTN Mobile
        expect(Phony).to be_plausible('+260 97 712 3456') # Airtel Mobile
        expect(Phony).to be_plausible('+260 95 512 4567') # Zamtel Mobile
        expect(Phony).not_to be_plausible('+260 96 512 456')   # MTN Mobile (Too short)
        expect(Phony).not_to be_plausible('+260 97 812 345')   # Airtel Mobile (Too short)
        expect(Phony).not_to be_plausible('+260 95 512 345')   # Zamtel Mobile (Too short)
        expect(Phony).to be_plausible('+260 800 123 456') # Toll free
      end

      it_is_correct_for 'Zimbabwe', samples: [['+263 2582 123 456', '+263 2582 123'],
                                              ['+263 147 123 456', '+263 147 123'],
                                              ['+263 270 123 456', '+263 270 123 45'],
                                              '+263 86 1235 4567']

      it 'is correct for Indonesia' do
        expect(Phony).not_to be_plausible('+62 22 000 0')
        expect(Phony).to be_plausible('+62 22 000 00')
        expect(Phony).to be_plausible('+62 22 000 0000')
        expect(Phony).to be_plausible('+62 22 0000 0000')
        expect(Phony).to be_plausible('+62 22 000 000 000')
      end

      it 'is correct for Italy' do
        expect(Phony).not_to be_plausible('+39 0574 123')
        expect(Phony).to be_plausible('+39 0574 1234')
        expect(Phony).not_to be_plausible('+39 0574 12345')

        expect(Phony).not_to be_plausible('+39 085 541')
        expect(Phony).to be_plausible('+39 085 5410')
        expect(Phony).to be_plausible('+39 085 54105')

        expect(Phony).not_to be_plausible('+39 06 4991')
        expect(Phony).to be_plausible('+39 06 49911')
        expect(Phony).to be_plausible('+39 06 499112')

        expect(Phony).to be_plausible('+39 800 081631')
        expect(Phony).not_to be_plausible('+39 800 0816311')

        expect(Phony).not_to be_plausible('+39 803 08163')
        expect(Phony).to be_plausible('+39 803 081')

        expect(Phony).not_to be_plausible('+39 06 8323074181')
        expect(Phony).to be_plausible('+39 06 832307418')
      end

      it 'is correct for Russia' do
        expect(Phony).to be_plausible('+7 3522 000 000')
      end

      it 'is correct for Peru' do
        expect(Phony).to be_plausible('+51 1 123 1234') # Lima
        expect(Phony).to be_plausible('+51 9 1234 1234') # mobile
        expect(Phony).to be_plausible('+51 84 123 123') # Cuzco, best effort
      end

      it 'is correct for Kosovo' do
        expect(Phony).to be_plausible('+383 29 000 000') # Landline
        expect(Phony).to be_plausible('+383 44 000 000') # Mobile
      end

      it 'is correct for Bulgaria' do
        expect(Phony).to be_plausible('+359 2 123 123')     # Landline Sofia
        expect(Phony).to be_plausible('+359 2 123 1234')    # Landline Sofia
        expect(Phony).to be_plausible('+359 30 123 12')     # Landline
        expect(Phony).to be_plausible('+359 30 123 123')    # Landline
        expect(Phony).to be_plausible('+359 89 123 1234')   # Mobile
      end

      it 'is correct for Malaysia' do
        expect(Phony).to be_plausible('+60 5 123 1234')     # Non Selangor Landline
        expect(Phony).to be_plausible('+60 3 1234 1234') # Selangor Landline
        expect(Phony).to be_plausible('+60 88 123 123') #  Landline Sabah – Kota Kinabalu and Kudat
      end

      it 'is correct for Japan' do
        expect(Phony).to be_plausible('+81 90 1234 1234')
        expect(Phony).to be_plausible('+81 120 123 123')
        expect(Phony).to be_plausible('+81 800 123 1234')
      end

      it 'is correct for Philippine' do
        expect(Phony).to be_plausible('+63 2 89889999')
        expect(Phony).to be_plausible('+63 976 1234567') # mobile phone with area code 9
        expect(Phony).to be_plausible('+63 876 1234567') # mobile phone with area code 8
      end
    end
  end
end
