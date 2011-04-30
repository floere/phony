# All countries, ordered by country code.
#
# Available matching/splitting methods:
# * fixed:  Always splits off a fixed length ndc. (Always use last in a | chain)
# * none:   Does not have a national destination code, e.g. Denmark, Iceland.
# * one_of: Matches one of the following numbers. Splits if it does.
#           Options:
#           * max_length: Will try to match up to length max_length, then stop.
#                         (Only use one_of with this option when last in a | chain)
# * match: Try to match the regex, and if it matches, splits it off.
#           Options:
#           * on_fail_take: If it does not match, take n digits, then stop.
#                           (When you use this option, match must be last in a | chain)
#
# For the national number part, there are two:
# * split:         Use this number group splitting.
# * matched_split: Give a hash of regex => format array, with a :fallback => format option.
#                   (See Norway how it looks.)
#
# Note: The ones that are commented are defined in their special files.
#
Phony.define do
  country '0', fixed(1) >> split(10) # Reserved.
  country '1', fixed(3) >> split(3,4) # USA, Canada, etc.
  country '7', fixed(3) >> split(3,2,2) # Kazakhstan (Republic of) & Russian Federation

  country '20', one_of('800') >> split(7) | # Egypt
                one_of('2', '3', :max_length => 2) >> split(8) # Cairo/Giza, Alexandria
                # :mobile? => /^10|11|12|14|16|17|18|19*$/, :service? => /^800.*$/
  country '27', fixed(2) >> split(3,4) # South Africa

  # country '30', Phony::Countries::Greece
  # country '31', Phony::Countries::Netherlands
  # country '32', Phony::Countries::Belgium
  country '33', fixed(1) >> split(2,2,2,2)    # :service? => /^8.*$/, :mobile? => /^[67].*$/ # France
  country '34', fixed(2) >> split(3,4)        # Spain
  # country '36', Phony::Countries::Hungary
  # country '39', Phony::Countries::Italy

  # country '40', Phony::Countries::Romania
  # :service => %w{800 840 842 844 848}, :mobile  => %w{74 76 77 78 79}
  swiss_service_regex = /^(800|840|842|844|848)\d+$/
  country '41', match(swiss_service_regex) >> split(3,3) | # Switzerland
                fixed(2)                   >> split(3,2,2)
  # country '43', Phony::Countries::Austria
  # country '44', Phony::Countries::UnitedKingdom
  country '45', none >> split(2,2,2,2) # Denmark
  # country '46', Phony::Countries::Sweden
  country '47', # Norway
          none >> matched_split(/^[1].*$/ => [3], /^[489].*$/ => [3,2,3], :fallback => [2,2,2,2])
  # Poland (Republic of)
  # Although the NDCs are 2 digits, the representation is 3 digits.
  # Note: http://wapedia.mobi/en/Telephone_numbers_in_Poland, mobile not yet correct
  #
  country '48', fixed(3) >> split(3,3) # Poland
  # country '49', Phony::Countries::Germany

  country '51', one_of('103', '105')               >> split(3,3) | # Peru
                one_of('1', '9', :max_length => 2) >> split(4,4)   # Lima and mobile.
  country '52', match(/^(0\d{2})\d+$/)   >> split(2,2,2,2) | # Mexico
                match(/^(33|55|81)\d+$/) >> split(2,2,2,2) |
                match(/^(\d{3})\d+$/)    >> split(3,2,2)
  country '53', match(/^(5\d{3})\d+$/)                                   >> split(4) | # Cuba. Mobile.
                match(/^(7|21|22|23|4[1-8]|3[1-3])/, :on_fail_take => 3) >> split(7)
  country '54', fixed(2) >> split(3,2,2) # TODO Argentine Republic
  brazilian_service = /^(100|128|190|191|192|193|194|197|198|199)\d+$/
  country '55', match(brazilian_service) >> split(3,3) | # Brazil (Federative Republic of)
                fixed(2) >> split(4,4)
                # :service? => brazilian_service, :mobile? => ?
                # http://en.wikipedia.org/wiki/Telephone_numbers_in_Brazil
  # country '56', Phony::Countries::Chile
  country '57', fixed(2) >> split(3,2,2) # TODO Colombia
  country '58', fixed(3) >> split(7) # Venezuela (Bolivarian Republic of)

  # country '60', Phony::Countries::Malaysia
  country '61', match(/^(4\d\d)\d+$/) >> split(3,3) | # Australia
                fixed(1)              >> split(4,4)
  country '62', fixed(2) >> split(3,2,2) # TODO Indonesia (Republic of)
  country '63', fixed(2) >> split(3,2,2) # TODO Philippines (Republic of the)
  country '64', fixed(1) >> split(3,4)   # New Zealand
  country '65', fixed(2) >> split(3,2,2) # TODO Singapore (Republic of)
  country '66', fixed(2) >> split(3,2,2) # TODO Thailand

  country '81', fixed(2) >> split(3,2,2) # TODO Japan
  # country '82', Phony::Countries::SouthKorea
  country '84', fixed(2) >> split(3,2,2) # TODO Viet Nam (Socialist Republic of)
  # country '86', Phony::Countries::China

  country '90', fixed(3) >> split(3,4)   # Turkey. Wiki says 7, but the examples say 3, 4.
  country '91', fixed(2) >> split(3,2,2) # TODO India (Republic of)
  country '92', fixed(2) >> split(3,2,2) # TODO Pakistan (Islamic Republic of), http://en.wikipedia.org/wiki/Telephone_numbers_in_Pakistan, NDC 2-5
  country '93', fixed(2) >> split(7)     # Afghanistan. Note: the document says 6, but the examples use 7. http://www.wtng.info/wtng-93-af.html

  country '94', fixed(2) >> split(3,2,2) # TODO Sri Lanka (Democratic Socialist Republic of)
  country '95', fixed(2) >> split(3,2,2) # TODO Myanmar (Union of)
  country '98', fixed(2) >> split(3,2,2) # TODO Iran (Islamic Republic of)

  country '210', fixed(2) >> split(3,2,2) # -
  country '211', fixed(2) >> split(3,2,2) # -
  country '212', fixed(2) >> split(3,2,2) # Morocco
  country '213', fixed(2) >> split(3,4)   # Algeria
  country '214', fixed(2) >> split(3,2,2) # -
  country '215', fixed(2) >> split(3,2,2) # -
  country '216', fixed(1) >> split(3,4)   # Tunisia
  country '217', fixed(2) >> split(3,2,2) # -
  country '218', fixed(2) >> split(3,2,2) # Lybia
  country '219', fixed(2) >> split(3,2,2) # -

  # TODO From here on.

  country '220', fixed(2) >> split(3,2,2) # Gambia
  country '221', fixed(2) >> split(3,2,2) # Senegal
  country '222', fixed(2) >> split(3,2,2) # Mauritania
  country '223', fixed(2) >> split(3,2,2) # Mali
  country '224', fixed(2) >> split(3,2,2) # Guinea
  country '225', fixed(2) >> split(3,2,2) # Côte d'Ivoire
  country '226', fixed(2) >> split(3,2,2) # Burkina Faso
  country '227', fixed(2) >> split(3,2,2) # Niger
  country '228', fixed(2) >> split(3,2,2) # Togolese Republic
  country '229', fixed(2) >> split(3,2,2) # Benin

  country '230', fixed(2) >> split(3,2,2) # Mauritius
  country '231', fixed(2) >> split(3,2,2) # Liberia
  country '232', fixed(2) >> split(3,2,2) # Sierra Leone
  country '233', fixed(2) >> split(3,2,2) # Ghana
  country '234', fixed(2) >> split(3,2,2) # Nigeria
  country '235', fixed(2) >> split(3,2,2) # Chad
  country '236', fixed(2) >> split(3,2,2) # Central African Republic
  country '237', fixed(2) >> split(3,2,2) # Cameroon
  country '238', fixed(2) >> split(3,2,2) # Cape Verde
  country '239', fixed(2) >> split(3,2,2) # Sao Tome and Principe

  country '240', fixed(2) >> split(3,2,2) # Equatorial Guinea
  country '241', fixed(2) >> split(3,2,2) # Gabonese Republic
  country '242', fixed(2) >> split(3,2,2) # Congo
  country '243', fixed(2) >> split(3,2,2) # Democratic Republic of the Congo
  country '244', fixed(2) >> split(3,2,2) # Angola
  country '245', fixed(2) >> split(3,2,2) # Guinea-Bissau
  country '246', fixed(2) >> split(3,2,2) # Diego Garcia
  country '247', fixed(2) >> split(3,2,2) # Ascension
  country '248', fixed(2) >> split(3,2,2) # Seychelles
  country '249', fixed(2) >> split(3,2,2) # Sudan

  country '250', fixed(2) >> split(3,2,2) # Rwanda
  country '251', fixed(2) >> split(3,2,2) # Ethiopia
  country '252', fixed(2) >> split(3,2,2) # Somali Democratic Republic
  country '253', fixed(2) >> split(3,2,2) # Djibouti
  country '254', fixed(2) >> split(3,2,2) # Kenya
  country '255', fixed(2) >> split(3,2,2) # Tanzania
  country '256', fixed(2) >> split(3,2,2) # Uganda
  country '257', fixed(2) >> split(3,2,2) # Burundi
  country '258', fixed(2) >> split(3,2,2) # Mozambique
  country '259', fixed(2) >> split(3,2,2) # -

  country '260', fixed(2) >> split(3,2,2) # Zambia
  country '261', fixed(2) >> split(3,2,2) # Madagascar
  country '262', fixed(3) >> split(3,2,2) # Reunion / Mayotte (new)
  country '263', fixed(2) >> split(3,2,2) # Zimbabwe
  country '264', fixed(2) >> split(3,2,2) # Namibia
  country '265', fixed(2) >> split(3,2,2) # Malawi
  country '266', fixed(2) >> split(3,2,2) # Lesotho
  country '267', fixed(2) >> split(3,2,2) # Botswana
  country '268', fixed(2) >> split(3,2,2) # Swaziland
  country '269', fixed(2) >> split(3,2,2) # Comoros

  country '280', fixed(2) >> split(3,2,2) # -
  country '281', fixed(2) >> split(3,2,2) # -
  country '282', fixed(2) >> split(3,2,2) # -
  country '283', fixed(2) >> split(3,2,2) # -
  country '284', fixed(2) >> split(3,2,2) # -
  country '285', fixed(2) >> split(3,2,2) # -
  country '286', fixed(2) >> split(3,2,2) # -
  country '287', fixed(2) >> split(3,2,2) # -
  country '288', fixed(2) >> split(3,2,2) # -
  country '289', fixed(2) >> split(3,2,2) # -
  country '290', fixed(2) >> split(3,2,2) # Saint Helena

  country '291', fixed(2) >> split(3,2,2) # Eritrea
  country '292', fixed(2) >> split(3,2,2) # -
  country '293', fixed(2) >> split(3,2,2) # -
  country '294', fixed(2) >> split(3,2,2) # -
  country '295', fixed(2) >> split(3,2,2) # -
  country '296', fixed(2) >> split(3,2,2) # -
  country '297', fixed(2) >> split(3,2,2) # Aruba
  country '298', fixed(2) >> split(3,2,2) # Faroe Islands
  country '299', fixed(2) >> split(3,2,2) # Greenland

  country '350', fixed(2) >> split(3,2,2) # Gibraltar
  country '351', one_of('700', '800')                 >> split(3,3) | # Portugal
                 match(/^(9\d)\d+$/)                  >> split(3,4) | # mobile
                 one_of('21', '22', :max_length => 3) >> split(3,4)   # Lisboa & Porto
  country '352', fixed(2) >> split(3,2,2) # Luxembourg
  country '353', fixed(2) >> split(3,2,2) # Ireland (0-3-4)
  country '354', none     >> split(3,4)   # Iceland
  country '355', fixed(2) >> split(3,2,2) # Albania
  country '356', fixed(2) >> split(3,2,2) # Malta
  country '357', fixed(2) >> split(3,2,2) # Cyprus
  country '358', match(/^([6-8]00)\d+$/)                           >> split(3,3)   | # Finland
                 match(/^(4\d|50)\d+$/)                            >> split(3,2,2) |
                 one_of('2','3','5','6','8','9', :max_length => 2) >> split(3,3)
  country '359', fixed(2) >> split(3,2,2) # Bulgaria

  country '370', one_of('700', '800')  >> split(2,3)   | # Lithuania
                 match(/^(6\d\d)\d+$/) >> split(2,3)   | # Mobile
                 one_of('5')           >> split(3,2,2) | # Vilnius
                 one_of('37','41')     >> split(2,2,2) | #
                 fixed(3)              >> split(1,2,2)
  country '371', fixed(2) >> split(3,2,2) # Latvia
  country '372', fixed(2) >> split(3,2,2) # Estonia
  country '373', fixed(2) >> split(3,2,2) # Moldova
  country '374', fixed(2) >> split(3,2,2) # Armenia
  country '375', fixed(2) >> split(3,2,2) # Belarus
  country '376', fixed(2) >> split(3,2,2) # Andorra
  country '377', fixed(2) >> split(3,2,2) # Monaco
  country '378', fixed(2) >> split(3,2,2) # San Marino
  country '379', fixed(2) >> split(3,2,2) # Vatican City State

  country '380', fixed(2) >> split(3,2,2) # Ukraine
  country '381', fixed(2) >> split(3,2,2) # Serbia and Montenegro
  country '382', fixed(2) >> split(3,2,2) # -
  country '383', fixed(2) >> split(3,2,2) # -
  country '384', fixed(2) >> split(3,2,2) # -
  country '385', one_of('1', :max_length => 2) >> split(3,5) # Croatia
  country '386', fixed(2) >> split(3,2,2) # Slovenia
  country '387', fixed(2) >> split(3,2,2) # Bosnia and Herzegovina
  country '388', fixed(2) >> split(3,2,2) # Group of countries, shared code
  country '389', fixed(2) >> split(3,2,2) # The Former Yugoslav Republic of Macedonia

  country '420', fixed(3) >> split(3,3)   # Czech Republic
  country '421', match(/^(9\d\d).+$/) >> split(7) | # Slovak Republic
                 one_of('2')          >> split(8) | # Bratislava
                 fixed(2)             >> split(8)
  country '422', fixed(2) >> split(3,2,2) # Spare code
  country '423', none     >> split(3,2,2) # Liechtenstein (Principality of)
  country '424', fixed(2) >> split(3,2,2) # -
  country '425', fixed(2) >> split(3,2,2) # -
  country '426', fixed(2) >> split(3,2,2) # -
  country '427', fixed(2) >> split(3,2,2) # -
  country '428', fixed(2) >> split(3,2,2) # -
  country '429', fixed(2) >> split(3,2,2) # -

  country '500', fixed(2) >> split(3,2,2) # Falkland Islands (Malvinas)
  country '501', fixed(2) >> split(3,2,2) # Belize
  country '502', fixed(2) >> split(3,2,2) # Guatemala (Republic of)
  country '503', fixed(2) >> split(3,2,2) # El Salvador (Republic of)
  country '504', fixed(2) >> split(3,2,2) # Honduras (Republic of)
  country '505', fixed(2) >> split(3,2,2) # Nicaragua
  country '506', fixed(2) >> split(3,2,2) # Costa Rica
  country '507', fixed(2) >> split(3,2,2) # Panama (Republic of)
  country '508', fixed(2) >> split(3,2,2) # Saint Pierre and Miquelon (Collectivité territoriale de la République française)
  country '509', fixed(2) >> split(3,2,2) # Haiti (Republic of)

  country '590', fixed(3) >> split(3,2,2) # Guadeloupe (French Department of)
  country '591', fixed(2) >> split(3,2,2) # Bolivia (Republic of)
  country '592', fixed(2) >> split(3,2,2) # Guyana
  country '593', fixed(2) >> split(3,2,2) # Ecuador
  country '594', fixed(3) >> split(3,2,2) # French Guiana (French Department of)
  country '595', fixed(2) >> split(3,2,2) # Paraguay (Republic of)
  country '596', fixed(3) >> split(3,2,2) # Martinique (French Department of)
  country '597', fixed(2) >> split(3,2,2) # Suriname (Republic of)
  country '598', fixed(2) >> split(3,2,2) # Uruguay (Eastern Republic of)
  country '599', fixed(2) >> split(3,2,2) # Netherlands Antilles

  country '670', fixed(2) >> split(3,2,2) # Democratic Republic of Timor-Leste
  country '671', fixed(2) >> split(3,2,2) # Spare code
  country '672', fixed(2) >> split(3,2,2) # Australian External Territories
  country '673', fixed(2) >> split(3,2,2) # Brunei Darussalam
  country '674', fixed(2) >> split(3,2,2) # Nauru (Republic of)
  country '675', fixed(2) >> split(3,2,2) # Papua New Guinea
  country '676', fixed(2) >> split(3,2,2) # Tonga (Kingdom of)
  country '677', fixed(2) >> split(3,2,2) # Solomon Islands
  country '678', fixed(2) >> split(3,2,2) # Vanuatu (Republic of)
  country '679', fixed(2) >> split(3,2,2) # Fiji (Republic of)

  country '680', fixed(2) >> split(3,2,2) # Palau (Republic of)
  country '681', fixed(2) >> split(3,2,2) # Wallis and Futuna (Territoire français d'outre-mer)
  country '682', fixed(2) >> split(3,2,2) # Cook Islands
  country '683', fixed(2) >> split(3,2,2) # Niue
  country '684', fixed(2) >> split(3,2,2) # -
  country '685', fixed(2) >> split(3,2,2) # Samoa (Independent State of)
  country '686', fixed(2) >> split(3,2,2) # Kiribati (Republic of)
  country '687', fixed(2) >> split(3,2,2) # New Caledonia (Territoire français d'outre-mer)
  country '688', fixed(2) >> split(3,2,2) # Tuvalu
  country '689', fixed(2) >> split(3,2,2) # French Polynesia (Territoire français d'outre-mer)

  country '690', fixed(2) >> split(3,2,2) # Tokelau
  country '691', fixed(2) >> split(3,2,2) # Micronesia (Federated States of)
  country '692', fixed(2) >> split(3,2,2) # Marshall Islands (Republic of the)
  country '693', fixed(2) >> split(3,2,2) # -
  country '694', fixed(2) >> split(3,2,2) # -
  country '695', fixed(2) >> split(3,2,2) # -
  country '696', fixed(2) >> split(3,2,2) # -
  country '697', fixed(2) >> split(3,2,2) # -
  country '698', fixed(2) >> split(3,2,2) # -
  country '699', fixed(2) >> split(3,2,2) # -

  country '800', fixed(2) >> split(3,2,2) # International Freephone Service
  country '801', fixed(2) >> split(3,2,2) # -
  country '802', fixed(2) >> split(3,2,2) # -
  country '803', fixed(2) >> split(3,2,2) # -
  country '804', fixed(2) >> split(3,2,2) # -
  country '805', fixed(2) >> split(3,2,2) # -
  country '806', fixed(2) >> split(3,2,2) # -
  country '807', fixed(2) >> split(3,2,2) # -
  country '808', fixed(2) >> split(3,2,2) # International Shared Cost Service (ISCS)
  country '809', fixed(2) >> split(3,2,2) # -

  country '830', fixed(2) >> split(3,2,2) # -
  country '831', fixed(2) >> split(3,2,2) # -
  country '832', fixed(2) >> split(3,2,2) # -
  country '833', fixed(2) >> split(3,2,2) # -
  country '834', fixed(2) >> split(3,2,2) # -
  country '835', fixed(2) >> split(3,2,2) # -
  country '836', fixed(2) >> split(3,2,2) # -
  country '837', fixed(2) >> split(3,2,2) # -
  country '838', fixed(2) >> split(3,2,2) # -
  country '839', fixed(2) >> split(3,2,2) # -

  country '850', fixed(2) >> split(3,2,2) # Democratic People's Republic of Korea
  country '851', fixed(2) >> split(3,2,2) # Spare code
  country '852', fixed(2) >> split(3,2,2) # Hong Kong, China
  country '853', fixed(2) >> split(3,2,2) # Macao, China
  country '854', fixed(2) >> split(3,2,2) # Spare code
  country '855', fixed(2) >> split(3,2,2) # Cambodia (Kingdom of)
  country '856', fixed(2) >> split(3,2,2) # Lao People's Democratic Republic
  country '857', fixed(2) >> split(3,2,2) # Spare code
  country '858', fixed(2) >> split(3,2,2) # Spare code
  country '859', fixed(2) >> split(3,2,2) # Spare code

  country '870', fixed(2) >> split(3,2,2) # Inmarsat SNAC
  country '871', fixed(2) >> split(3,2,2) # Inmarsat (Atlantic Ocean-East)
  country '872', fixed(2) >> split(3,2,2) # Inmarsat (Pacific Ocean)
  country '873', fixed(2) >> split(3,2,2) # Inmarsat (Indian Ocean)
  country '874', fixed(2) >> split(3,2,2) # Inmarsat (Atlantic Ocean-West)
  country '875', fixed(2) >> split(3,2,2) # Reserved - Maritime Mobile Service Applications
  country '876', fixed(2) >> split(3,2,2) # Reserved - Maritime Mobile Service Applications
  country '877', fixed(2) >> split(3,2,2) # Reserved - Maritime Mobile Service Applications
  country '878', fixed(2) >> split(3,2,2) # Universal Personal Telecommunication Service (UPT)
  country '879', fixed(2) >> split(3,2,2) # Reserved for national non-commercial purposes

  country '880', fixed(2) >> split(3,2,2) # Bangladesh (People's Republic of)
  country '881', fixed(2) >> split(3,2,2) # International Mobile, shared code
  country '882', fixed(2) >> split(3,2,2) # International Networks, shared code
  country '883', fixed(2) >> split(3,2,2) # -
  country '884', fixed(2) >> split(3,2,2) # -
  country '885', fixed(2) >> split(3,2,2) # -
  country '886', fixed(2) >> split(3,2,2) # Reserved
  country '887', fixed(2) >> split(3,2,2) # -
  country '888', fixed(2) >> split(3,2,2) # Reserved for future global service
  country '889', fixed(2) >> split(3,2,2) # -

  country '890', fixed(2) >> split(3,2,2) # -
  country '891', fixed(2) >> split(3,2,2) # -
  country '892', fixed(2) >> split(3,2,2) # -
  country '893', fixed(2) >> split(3,2,2) # -
  country '894', fixed(2) >> split(3,2,2) # -
  country '895', fixed(2) >> split(3,2,2) # -
  country '896', fixed(2) >> split(3,2,2) # -
  country '897', fixed(2) >> split(3,2,2) # -
  country '898', fixed(2) >> split(3,2,2) # -
  country '899', fixed(2) >> split(3,2,2) # -

  country '960', fixed(2) >> split(3,2,2) # Maldives (Republic of)
  country '961', fixed(2) >> split(3,2,2) # Lebanon
  country '962', fixed(2) >> split(3,2,2) # Jordan (Hashemite Kingdom of)
  country '963', fixed(2) >> split(3,2,2) # Syrian Arab Republic
  country '964', fixed(2) >> split(3,2,2) # Iraq (Republic of)
  country '965', fixed(2) >> split(3,2,2) # Kuwait (State of)
  country '966', fixed(2) >> split(3,2,2) # Saudi Arabia (Kingdom of)
  country '967', fixed(2) >> split(3,2,2) # Yemen (Republic of)
  country '968', fixed(2) >> split(3,2,2) # Oman (Sultanate of)
  country '969', fixed(2) >> split(3,2,2) # Reserved - reservation currently under investigation

  country '970', fixed(2) >> split(3,2,2) # Reserved
  country '971', fixed(2) >> split(3,2,2) # United Arab Emirates
  country '972', fixed(2) >> split(3,2,2) # Israel (State of)
  country '973', fixed(2) >> split(3,2,2) # Bahrain (Kingdom of)
  country '974', fixed(2) >> split(3,2,2) # Qatar (State of)
  country '975', fixed(2) >> split(3,2,2) # Bhutan (Kingdom of)
  country '976', fixed(2) >> split(3,2,2) # Mongolia
  country '977', fixed(2) >> split(3,2,2) # Nepal
  country '978', fixed(2) >> split(3,2,2) # -
  country '979', fixed(2) >> split(3,2,2) # International Premium Rate Service (IPRS)

  country '990', fixed(2) >> split(3,2,2) # Spare code
  country '991', fixed(2) >> split(3,2,2) # Trial of a proposed new international telecommunication public correspondence service, shared code
  country '992', fixed(2) >> split(3,2,2) # Tajikistan (Republic of)
  country '993', fixed(2) >> split(3,2,2) # Turkmenistan
  country '994', fixed(2) >> split(3,2,2) # Azerbaijani Republic
  country '995', fixed(2) >> split(3,2,2) # Georgia
  country '996', fixed(2) >> split(3,2,2) # Kyrgyz Republic
  country '997', fixed(2) >> split(3,2,2) # Spare code
  country '998', fixed(2) >> split(3,2,2) # Uzbekistan (Republic of)
  country '999', fixed(2) >> split(3,2,2) # Reserved for possible future use within the Telecommunications for Disaster Relief (TDR) concept
end