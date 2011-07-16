# All countries, ordered by country code.
#
# Definitions are in the format:
#   NDC >> National | NDC >> National | # ...
#
# As soon as a NDC matches, it goes on to the National part. Then breaks off.
# If the NDC does not match, it go on to the next (|, or "or") NDC.
#
# Available matching/splitting methods:
# * none:   Does not have a national destination code, e.g. Denmark, Iceland.
# * one_of: Matches one of the following numbers. Splits if it does.
# * match: Try to match the regex, and if it matches, splits it off.
# * fixed:  Always splits off a fixed length ndc. (Always use last in a | chain)
#
# For the national number part, there are two:
# * split:         Use this number group splitting.
# * matched_split: Give a hash of regex => format array, with a :fallback => format option.
#                   (See Norway how it looks.)
#
# Note: The ones that are commented are defined in their special files.
#
Phony.define do

  # Reserved.
  #
  country '0', fixed(1) >> split(10) # Reserved.

  # USA, Canada, etc.
  #
  country '1', fixed(3) >> split(3,4)

  # Kazakhstan (Republic of) & Russian Federation.
  #
  country '7', fixed(3) >> split(3,2,2)

  # Egypt.
  #
  country '20', one_of('800')    >> split(7) | # Egypt
                one_of('2', '3') >> split(8) | # Cairo/Giza, Alexandria
                fixed(2)         >> split(8)
                # :mobile? => /^10|11|12|14|16|17|18|19*$/, :service? => /^800.*$/

  # South Africa.
  #
  country '27', fixed(2) >> split(3,4)

  # Greece.
  #
  country '30', match(/^(2[3-8]?1|69[0345789]|800)\d+$/) >> split(6) | # Geo/Mobile
                fixed(4)                                 >> split(6)   # 3-digit NDCs

  # country '31' # Netherlands, see special file.

  # Belgium.
  #
  country '32', match(/^(70|800|90\d)\d+$/) >> split(3,3) | # Service
                match(/^(4[789]\d)\d{6}$/)  >> split(6)   | # Mobile
                one_of('2','3','4','9')     >> split(3,5) | # Short NDCs
                fixed(2)                    >> split(3,5)   # 2-digit NDCs

  # France.
  #
  country '33', fixed(1) >> split(2,2,2,2)    # :service? => /^8.*$/, :mobile? => /^[67].*$/

  # Spain.
  #
  country '34', fixed(2) >> split(3,4)

  # Hungary.
  #
  # TODO Mobile.
  #
  country '36', one_of('104','105','107','112') >> split(3,3) | # Service
                one_of('1')                     >> split(3,4) | # Budapest
                fixed(2)                        >> split(3,4)   # 2-digit NDCs

  # country '39' # Italy, see special file.

  # Romania.
  #
  country '40', match(/^(112|800|90[036])\d+$/) >> split(3,3) | # Service
                match(/^(7[1-8])\d+$/)          >> split(3,4) | # Mobile
                one_of('21', '31')              >> split(3,4) | # Bucureşti
                fixed(3)                        >> split(3,4)   # 3-digit NDCs

  # Switzerland.
  #
  # :service => %w{800 840 842 844 848}, :mobile  => %w{74 76 77 78 79}
  swiss_service_regex = /^(800|840|842|844|848)\d+$/
  country '41', match(swiss_service_regex) >> split(3,3) |
                fixed(2)                   >> split(3,2,2)


  # country '43' # Austria, see special file.
  # country '44' # UnitedKingdom, see special file.

  # Denmark.
  #
  country '45', none >> split(2,2,2,2)

  # country '46' # Sweden, see special file.

  # Norway.
  #
  country '47', none >> matched_split(/^[1].*$/ => [3], /^[489].*$/ => [3,2,3], :fallback => [2,2,2,2])

  # Poland (Republic of)
  # Although the NDCs are 2 digits, the representation is 3 digits.
  # Note: http://wapedia.mobi/en/Telephone_numbers_in_Poland, mobile not yet correct
  #
  country '48', fixed(3) >> split(3,3) # Poland

  # country '49' # Germany, see special file.

  # Peru.
  #
  country '51', one_of('103', '105') >> split(3,3) | # Service.
                one_of('1', '9')     >> split(4,4) | # Lima and mobile.
                fixed(2)             >> split(4,4)   # 2-digit NDCs.

  # Mexico.
  #
  country '52', match(/^(0\d{2})\d+$/)   >> split(2,2,2,2) |
                match(/^(33|55|81)\d+$/) >> split(2,2,2,2) |
                match(/^(\d{3})\d+$/)    >> split(3,2,2)

  # Cuba.
  #
  country '53', match(/^(5\d{3})\d+$/)               >> split(4) | # Mobile
                match(/^(7|21|22|23|4[1-8]|3[1-3])/) >> split(7) | # Short NDCs
                fixed(3)                             >> split(7)   # 3-digit NDCs

  # TODO Argentine Republic.
  #
  country '54', fixed(2) >> split(3,2,2)

  # Brazil (Federative Republic of).
  #
  brazilian_service = /^(100|128|190|191|192|193|194|197|198|199)\d+$/
  country '55', match(brazilian_service) >> split(3,3) | # Service.
                fixed(2) >> split(4,4)                   # NDCs
                # :service? => brazilian_service, :mobile? => ?
                # http://en.wikipedia.org/wiki/Telephone_numbers_in_Brazil

  # Chile.
  #
  country '56', match(/^(13[0-79]|14[79])\d+$/) >> split(3,3) | # Service
                one_of('2', '9')                >> split(8)   | # Santiago, Mobile
                fixed(2)                        >> split(8)     # 2-digit NDCs

  # TODO Colombia.
  #
  country '57', default

  # Venezuela (Bolivarian Republic of)
  #
  country '58', fixed(3) >> split(7)

  # country '60' # Malaysia, see special file.

  # Australia.
  #
  country '61', match(/^(4\d\d)\d+$/) >> split(3,3) | # Mobile
                fixed(1)              >> split(4,4)   # Rest
  country '62', default # TODO Indonesia (Republic of)
  country '63', default # TODO Philippines (Republic of the)

  # New Zealand.
  #
  # TODO Mobile?
  #
  country '64', fixed(1) >> split(3,4)

  country '65', default # TODO Singapore (Republic of)
  country '66', default # TODO Thailand

  country '81', default # TODO Japan

  # country '82' # SouthKorea, see special file.

  country '84', default # TODO Viet Nam (Socialist Republic of)

  # country '86' # China, see special file.

  # Turkey.
  #
  country '90', fixed(3) >> split(3,4)   # Wiki says 7, but the examples say 3, 4.

  country '91', default # TODO India (Republic of)
  country '92', default # TODO Pakistan (Islamic Republic of), http://en.wikipedia.org/wiki/Telephone_numbers_in_Pakistan, NDC 2-5

  # Afghanistan.
  #
  # From http://www.wtng.info/wtng-93-af.html
  #
  country '93', fixed(2) >> split(7)     # Note: the document says 6, but the examples use 7.

  country '94', fixed(2) >> split(3,2,2) # TODO Sri Lanka (Democratic Socialist Republic of)
  country '95', fixed(2) >> split(3,2,2) # TODO Myanmar (Union of)
  country '98', fixed(2) >> split(3,2,2) # TODO Iran (Islamic Republic of)

  country '210', default # -
  country '211', default # -
  country '212', default # Morocco
  country '213', fixed(2) >> split(3,4)   # Algeria
  country '214', default # -
  country '215', default # -
  country '216', fixed(1) >> split(3,4)   # Tunisia
  country '217', default # -
  country '218', default # Lybia
  country '219', default # -

  country '220', default # Gambia
  country '221', default # Senegal
  country '222', default # Mauritania
  country '223', default # Mali
  country '224', default # Guinea
  country '225', default # Côte d'Ivoire
  country '226', default # Burkina Faso
  country '227', default # Niger
  country '228', default # Togolese Republic
  country '229', default # Benin

  country '230', default # Mauritius
  country '231', default # Liberia
  country '232', default # Sierra Leone
  country '233', default # Ghana
  country '234', default # Nigeria
  country '235', default # Chad
  country '236', default # Central African Republic
  country '237', default # Cameroon
  country '238', default # Cape Verde
  country '239', default # Sao Tome and Principe

  country '240', default # Equatorial Guinea
  country '241', default # Gabonese Republic
  country '242', default # Congo
  country '243', default # Democratic Republic of the Congo
  country '244', default # Angola
  country '245', default # Guinea-Bissau
  country '246', default # Diego Garcia
  country '247', default # Ascension
  country '248', default # Seychelles
  country '249', default # Sudan

  country '250', default # Rwanda
  country '251', default # Ethiopia
  country '252', default # Somali Democratic Republic
  country '253', default # Djibouti
  country '254', default # Kenya
  country '255', default # Tanzania
  country '256', default # Uganda
  country '257', default # Burundi
  country '258', default # Mozambique
  country '259', default # -

  country '260', default # Zambia
  country '261', default # Madagascar
  country '262', default # Reunion / Mayotte (new)
  country '263', default # Zimbabwe
  country '264', default # Namibia
  country '265', default # Malawi
  country '266', default # Lesotho
  country '267', default # Botswana
  country '268', default # Swaziland
  country '269', default # Comoros

  country '280', default # -
  country '281', default # -
  country '282', default # -
  country '283', default # -
  country '284', default # -
  country '285', default # -
  country '286', default # -
  country '287', default # -
  country '288', default # -
  country '289', default # -
  country '290', default # Saint Helena

  country '291', default # Eritrea
  country '292', default # -
  country '293', default # -
  country '294', default # -
  country '295', default # -
  country '296', default # -
  country '297', default # Aruba
  country '298', default # Faroe Islands
  country '299', default # Greenland

  country '350', default # Gibraltar

  # Portugal.
  #
  country '351', one_of('700', '800') >> split(3,3) | # Service.
                 match(/^(9\d)\d+$/)  >> split(3,4) | # Mobile.
                 one_of('21', '22')   >> split(3,4) | # Lisboa & Porto
                 fixed(3)             >> split(3,4)   # 3-digit NDCs

  country '352', default # Luxembourg
  country '353', default # Ireland (0-3-4)
  country '354', none >> split(3,4) # Iceland
  country '355', default # Albania
  country '356', default # Malta
  country '357', default # Cyprus

  # Finland.
  #
  country '358', match(/^([6-8]00)\d+$/)         >> split(3,3)   | # Service
                 match(/^(4\d|50)\d+$/)          >> split(3,2,2) | # Mobile
                 one_of('2','3','5','6','8','9') >> split(3,3)   | # Short NDCs
                 fixed(2)                        >> split(3,3)     # 2-digit NDCs
  country '359', fixed(2) >> split(3,2,2) # Bulgaria

  # Lithuania.
  #
  country '370', one_of('700', '800')  >> split(2,3)   | # Service
                 match(/^(6\d\d)\d+$/) >> split(2,3)   | # Mobile
                 one_of('5')           >> split(3,2,2) | # Vilnius
                 one_of('37','41')     >> split(2,2,2) | # Kaunas, Šiauliai
                 fixed(3)              >> split(1,2,2)   # 3-digit NDCs.

  country '371', default # Latvia
  country '372', default # Estonia
  country '373', default # Moldova
  country '374', default # Armenia
  country '375', default # Belarus
  country '376', default # Andorra
  country '377', default # Monaco
  country '378', default # San Marino
  country '379', default # Vatican City State

  country '380', default # Ukraine
  country '381', default # Serbia and Montenegro
  country '382', default # -
  country '383', default # -
  country '384', default # -

  # Croatia.
  #
  country '385', one_of('1') >> split(3,5) | # Zagreb
                 fixed(2)    >> split(3,5)   # 2-digit NDCs

  country '386', fixed(2) >> split(3,2,2) # Slovenia
  country '387', fixed(2) >> split(3,2,2) # Bosnia and Herzegovina
  country '388', fixed(2) >> split(3,2,2) # Group of countries, shared code
  country '389', fixed(2) >> split(3,2,2) # The Former Yugoslav Republic of Macedonia

  country '420', fixed(3) >> split(3,3)   # Czech Republic

  # Slovak Republic.
  #
  country '421', match(/^(9\d\d).+$/) >> split(6) | # Mobile
                 one_of('2')          >> split(8) | # Bratislava
                 fixed(2)             >> split(7)   # 2-digit NDCs

  country '422', default # Spare code
  country '423', none >> split(3,2,2) # Liechtenstein (Principality of)
  country '424', default # -
  country '425', default # -
  country '426', default # -
  country '427', default # -
  country '428', default # -
  country '429', default # -

  country '500', default # Falkland Islands (Malvinas)
  country '501', default # Belize
  country '502', default # Guatemala (Republic of)
  country '503', default # El Salvador (Republic of)
  country '504', default # Honduras (Republic of)
  country '505', default # Nicaragua
  country '506', default # Costa Rica
  country '507', default # Panama (Republic of)
  country '508', default # Saint Pierre and Miquelon (Collectivité territoriale de la République française)
  country '509', default # Haiti (Republic of)

  country '590', default # Guadeloupe (French Department of)
  country '591', default # Bolivia (Republic of)
  country '592', default # Guyana
  country '593', default # Ecuador
  country '594', default # French Guiana (French Department of)
  country '595', default # Paraguay (Republic of)
  country '596', default # Martinique (French Department of)
  country '597', default # Suriname (Republic of)
  country '598', default # Uruguay (Eastern Republic of)
  country '599', default # Netherlands Antilles

  country '670', default # Democratic Republic of Timor-Leste
  country '671', default # Spare code
  country '672', default # Australian External Territories
  country '673', default # Brunei Darussalam
  country '674', default # Nauru (Republic of)
  country '675', default # Papua New Guinea
  country '676', default # Tonga (Kingdom of)
  country '677', default # Solomon Islands
  country '678', default # Vanuatu (Republic of)
  country '679', default # Fiji (Republic of)

  country '680', default # Palau (Republic of)
  country '681', default # Wallis and Futuna (Territoire français d'outre-mer)
  country '682', default # Cook Islands
  country '683', default # Niue
  country '684', default # -
  country '685', default # Samoa (Independent State of)
  country '686', default # Kiribati (Republic of)
  country '687', default # New Caledonia (Territoire français d'outre-mer)
  country '688', default # Tuvalu
  country '689', default # French Polynesia (Territoire français d'outre-mer)

  country '690', default # Tokelau
  country '691', default # Micronesia (Federated States of)
  country '692', default # Marshall Islands (Republic of the)
  country '693', default # -
  country '694', default # -
  country '695', default # -
  country '696', default # -
  country '697', default # -
  country '698', default # -
  country '699', default # -

  country '800', default # International Freephone Service
  country '801', default # -
  country '802', default # -
  country '803', default # -
  country '804', default # -
  country '805', default # -
  country '806', default # -
  country '807', default # -
  country '808', default # International Shared Cost Service (ISCS)
  country '809', default # -

  country '830', default # -
  country '831', default # -
  country '832', default # -
  country '833', default # -
  country '834', default # -
  country '835', default # -
  country '836', default # -
  country '837', default # -
  country '838', default # -
  country '839', default # -

  country '850', default # Democratic People's Republic of Korea
  country '851', default # Spare code
  country '852', default # Hong Kong, China
  country '853', default # Macao, China
  country '854', default # Spare code
  country '855', default # Cambodia (Kingdom of)
  country '856', default # Lao People's Democratic Republic
  country '857', default # Spare code
  country '858', default # Spare code
  country '859', default # Spare code

  country '870', default # Inmarsat SNAC
  country '871', default # Inmarsat (Atlantic Ocean-East)
  country '872', default # Inmarsat (Pacific Ocean)
  country '873', default # Inmarsat (Indian Ocean)
  country '874', default # Inmarsat (Atlantic Ocean-West)
  country '875', default # Reserved - Maritime Mobile Service Applications
  country '876', default # Reserved - Maritime Mobile Service Applications
  country '877', default # Reserved - Maritime Mobile Service Applications
  country '878', default # Universal Personal Telecommunication Service (UPT)
  country '879', default # Reserved for national non-commercial purposes

  country '880', default                  # Bangladesh (People's Republic of)
  country '881', default # International Mobile, shared code
  country '882', default # International Networks, shared code
  country '883', default # -
  country '884', default # -
  country '885', default # -
  country '886', default # Reserved
  country '887', default # -
  country '888', default # Reserved for future global service
  country '889', default # -

  country '890', default # -
  country '891', default # -
  country '892', default # -
  country '893', default # -
  country '894', default # -
  country '895', default # -
  country '896', default # -
  country '897', default # -
  country '898', default # -
  country '899', default # -

  country '960', default # Maldives (Republic of)
  country '961', default # Lebanon
  country '962', default # Jordan (Hashemite Kingdom of)
  country '963', default # Syrian Arab Republic
  country '964', default # Iraq (Republic of)
  country '965', default # Kuwait (State of)
  country '966', default # Saudi Arabia (Kingdom of)
  country '967', default # Yemen (Republic of)
  country '968', default # Oman (Sultanate of)
  country '969', default # Reserved - reservation currently under investigation

  country '970', default # Reserved
  country '971', default # United Arab Emirates
  country '972', default # Israel (State of)
  country '973', default # Bahrain (Kingdom of)
  country '974', default # Qatar (State of)
  country '975', default # Bhutan (Kingdom of)
  country '976', default # Mongolia
  country '977', default # Nepal
  country '978', default # -
  country '979', default # International Premium Rate Service (IPRS)

  country '990', default # Spare code
  country '991', default # Trial of a proposed new international telecommunication public correspondence service, shared code
  country '992', default # Tajikistan (Republic of)
  country '993', default # Turkmenistan
  country '994', default # Azerbaijani Republic
  country '995', default # Georgia
  country '996', default # Kyrgyz Republic
  country '997', default # Spare code
  country '998', default # Uzbekistan (Republic of)
  country '999', default # Reserved for possible future use within the Telecommunications for Disaster Relief (TDR) concept
end
