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
# The third parameter to country are validations.
# Currently, there is one method available:
# * invalid_ndcs: Give a regexp or string to describe invalid ndc(s).
#
# Note: The ones that are commented are defined in their special files.
#
Phony.define do

  # Reserved.
  #
  country '0', fixed(1) >> split(10) # Reserved.

  # USA, Canada, etc.
  #
  country '1',
          fixed(3) >> split(3,4),
          invalid_ndcs('911') # /911/ would also work.

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
  country '30', match(/^(2[3-8]?1|69[0345789]|800)\d+$/) >> split(8) | # Geo/Mobile
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
  country '34',
          fixed(2) >> split(3,4)

  # Hungary.
  #
  # TODO Mobile.
  #
  country '36',
          one_of('104','105','107','112') >> split(3,3) | # Service
          one_of('1')                     >> split(3,4) | # Budapest
          fixed(2)                        >> split(3,4)   # 2-digit NDCs

  # country '39' # Italy, see special file.

  # Romania.
  #
  country '40',
          match(/^(112|800|90[036])\d+$/) >> split(3,3) | # Service
          match(/^(7[1-8])\d+$/)          >> split(3,4) | # Mobile
          one_of('21', '31')              >> split(3,4) | # Bucureşti
          fixed(3)                        >> split(3,4)   # 3-digit NDCs

  # Switzerland.
  #
  country '41',
          match(/^(8(00|40|42|44|48))\d+$/) >> split(3,3) |
          fixed(2)                          >> split(3,2,2)


  # country '43' # Austria, see special file.
  # country '44' # UnitedKingdom, see special file.

  # Denmark.
  #
  country '45',
          none >> split(2,2,2,2)

  # country '46' # Sweden, see special file.

  # Norway.
  #
  country '47',
          none >> matched_split(/^[1].*$/   => [3],
                                /^[489].*$/ => [3,2,3],
                                :fallback   => [2,2,2,2])

  # Poland (Republic of)
  # Although the NDCs are 2 digits, the representation is 3 digits.
  # Note: http://wapedia.mobi/en/Telephone_numbers_in_Poland, mobile not yet correct
  #
  country '48',
          fixed(3) >> split(3,3) # Poland

  # country '49' # Germany, see special file.

  # Peru.
  #
  country '51',
          one_of('103', '105') >> split(3,3) | # Service.
          one_of('1', '9')     >> split(4,4) | # Lima and mobile.
          fixed(2)             >> split(4,4)   # 2-digit NDCs.

  # Mexico.
  #
  country '52',
          match(/^(0\d{2})\d+$/)   >> split(2,2,2,2) |
          match(/^(33|55|81)\d+$/) >> split(2,2,2,2) |
          match(/^(\d{3})\d+$/)    >> split(3,2,2)

  # Cuba.
  #
  country '53',
          match(/^(5\d{3})\d+$/)               >> split(4) | # Mobile
          match(/^(7|21|22|23|4[1-8]|3[1-3])/) >> split(7) | # Short NDCs
          fixed(3)                             >> split(7)   # 3-digit NDCs

  # Argentine Republic.
  #
  country '54',
          one_of('11', '911') >> split(4,4) | # Fixed & Mobile
          match(/^(22[0137]|237|26[14]|29[179]|34[1235]|35[138]|38[1578])/) >> split(3,4) |        # Fixed
          match(/^(922[0137]|9237|926[14]|929[179]|934[1235]|935[138]|938[1578])/) >> split(3,4) | # Mobile
          match(/^(9\d{4})/) >> split(2,4) | # Mobile
          fixed(4) >> split(2,4) # Fixed

  # Brazil (Federative Republic of).
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Brazil
  #
  brazilian_service = /^(100|128|190|191|192|193|194|197|198|199)\d+$/
  country '55',
          match(brazilian_service) >> split(3,3) | # Service.
          fixed(2) >> split(4,4)                   # NDCs

  # Chile.
  #
  country '56',
          match(/^(13[0-79]|14[79])\d+$/) >> split(3,3) | # Service
          one_of('2', '9')                >> split(8)   | # Santiago, Mobile
          fixed(2)                        >> split(8)     # 2-digit NDCs

  # TODO Colombia.
  #
  country '57', todo

  # Venezuela (Bolivarian Republic of)
  #
  country '58',
          fixed(3) >> split(7)

  # country '60' # Malaysia, see special file.

  # Australia.
  #
  country '61',
          match(/^(4\d\d)\d+$/) >> split(3,3) | # Mobile
          fixed(1)              >> split(4,4)   # Rest
          
  country '62', todo # TODO Indonesia (Republic of)
  country '63', todo # TODO Philippines (Republic of the)

  # New Zealand.
  #
  # TODO Mobile?
  #
  country '64',
          fixed(1) >> split(3,4)

  # Singapore (Republic of).
  #
  country '65',
          none >> split(4,4) # TODO Short Codes.

  # Thailand.
  #
  country '66',
          one_of('2') >> split(3,4) | # Bangkok
          fixed(2)    >> split(3,3)   # Rest

  country '81', todo # TODO Japan

  # country '82' # SouthKorea, see special file.

  country '84', todo # TODO Viet Nam (Socialist Republic of)

  # country '86' # China, see special file.

  # Turkey.
  #
  country '90',
          fixed(3) >> split(3,4)   # Wiki says 7, but the examples say 3, 4.

  country '91', todo # TODO India (Republic of)
  country '92', todo # TODO Pakistan (Islamic Republic of), http://en.wikipedia.org/wiki/Telephone_numbers_in_Pakistan, NDC 2-5

  # Afghanistan.
  #
  # From http://www.wtng.info/wtng-93-af.html
  #
  country '93', fixed(2) >> split(7)     # Note: the document says 6, but the examples use 7.

  country '94', fixed(2) >> split(3,2,2) # TODO Sri Lanka (Democratic Socialist Republic of)
  country '95', fixed(2) >> split(3,2,2) # TODO Myanmar (Union of)
  country '98', fixed(2) >> split(3,2,2) # TODO Iran (Islamic Republic of)

  country '210', todo # -
  country '211', todo # -
  country '212', todo # Morocco
  country '213', fixed(2) >> split(3,4)   # Algeria
  country '214', todo # -
  country '215', todo # -
  country '216', fixed(1) >> split(3,4)   # Tunisia
  country '217', todo # -
  country '218', todo # Lybia
  country '219', todo # -

  country '220', todo # Gambia
  country '221', todo # Senegal
  country '222', todo # Mauritania
  country '223', todo # Mali
  country '224', todo # Guinea
  country '225', todo # Côte d'Ivoire
  country '226', todo # Burkina Faso
  country '227', todo # Niger
  country '228', todo # Togolese Republic
  country '229', todo # Benin

  country '230', todo # Mauritius
  country '231', todo # Liberia
  country '232', todo # Sierra Leone

  # Ghana
  #
  # From http://www.itu.int/oth/T0202000052/en
  #
  country '233', fixed(2) >> split(3,4)

  country '234', todo # Nigeria
  country '235', todo # Chad
  country '236', todo # Central African Republic
  country '237', todo # Cameroon
  country '238', todo # Cape Verde
  country '239', todo # Sao Tome and Principe

  country '240', todo # Equatorial Guinea
  country '241', todo # Gabonese Republic
  country '242', todo # Congo
  country '243', todo # Democratic Republic of the Congo
  country '244', todo # Angola
  country '245', todo # Guinea-Bissau
  country '246', todo # Diego Garcia
  country '247', todo # Ascension
  country '248', todo # Seychelles
  country '249', todo # Sudan

  country '250', todo # Rwanda
  country '251', todo # Ethiopia
  country '252', todo # Somali Democratic Republic
  country '253', todo # Djibouti
  country '254', fixed(2) >> split(7) # Kenya
  
  # Tanzania.
  #
  country '255',
          match(/^([89]\d\d)/) >> split(3,3) | # Special/Premium.
          one_of('112', '118') >> split(3,3) | # Short Codes.
          fixed(2)             >> split(3,4)   # Geographic.

  # Uganda.
  #
  country '256',
          match(/^(46[45]|4[78]\d)/) >> split(6) | # Geo 1.
          fixed(2)                   >> split(7)   # Geo 2.
          
  country '257', todo # Burundi
  country '258', todo # Mozambique
  country '259', todo # -

  country '260', todo # Zambia
  country '261', todo # Madagascar
  country '262', todo # Reunion / Mayotte (new)
  country '263', todo # Zimbabwe
  country '264', todo # Namibia
  country '265', todo # Malawi
  country '266', todo # Lesotho
  country '267', todo # Botswana
  country '268', todo # Swaziland
  country '269', todo # Comoros

  country '280', todo # -
  country '281', todo # -
  country '282', todo # -
  country '283', todo # -
  country '284', todo # -
  country '285', todo # -
  country '286', todo # -
  country '287', todo # -
  country '288', todo # -
  country '289', todo # -
  country '290', todo # Saint Helena

  country '291', todo # Eritrea
  country '292', todo # -
  country '293', todo # -
  country '294', todo # -
  country '295', todo # -
  country '296', todo # -
  country '297', todo # Aruba
  country '298', todo # Faroe Islands
  country '299', todo # Greenland

  country '350', todo # Gibraltar

  # Portugal.
  #
  country '351',
          one_of('700', '800') >> split(3,3) | # Service.
          match(/^(9\d)\d+$/)  >> split(3,4) | # Mobile.
          one_of('21', '22')   >> split(3,4) | # Lisboa & Porto
          fixed(3)             >> split(3,4)   # 3-digit NDCs

  country '352', todo # Luxembourg

  # country '353' # Republic of Ireland, see special file.

  country '354', none >> split(3,4) # Iceland
  country '355', todo # Albania
  country '356', todo # Malta
  country '357', todo # Cyprus

  # Finland.
  #
  country '358',
          match(/^([6-8]00)\d+$/)         >> split(3,3)   | # Service
          match(/^(4\d|50)\d+$/)          >> split(3,2,2) | # Mobile
          one_of('2','3','5','6','8','9') >> split(3,3)   | # Short NDCs
          fixed(2)                        >> split(3,3)     # 2-digit NDCs
          
  # Bulgaria.
  #
  country '359',
          fixed(2) >> split(3,2,2) # Bulgaria

  # Lithuania.
  #
  country '370',
          one_of('700', '800')  >> split(2,3)   | # Service
          match(/^(6\d\d)\d+$/) >> split(2,3)   | # Mobile
          one_of('5')           >> split(3,2,2) | # Vilnius
          one_of('37','41')     >> split(2,2,2) | # Kaunas, Šiauliai
          fixed(3)              >> split(1,2,2)   # 3-digit NDCs.

  country '371', todo # Latvia
  country '372', todo # Estonia
  country '373', todo # Moldova
  country '374', todo # Armenia
  country '375', todo # Belarus
  country '376', todo # Andorra
  country '377', todo # Monaco
  country '378', todo # San Marino
  country '379', todo # Vatican City State

  country '380', todo # Ukraine
  country '381', todo # Serbia and Montenegro
  country '382', todo # -
  country '383', todo # -
  country '384', todo # -

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

  country '422', todo # Spare code
  country '423', none >> split(3,2,2) # Liechtenstein (Principality of)
  country '424', todo # -
  country '425', todo # -
  country '426', todo # -
  country '427', todo # -
  country '428', todo # -
  country '429', todo # -

  country '500', todo # Falkland Islands (Malvinas)
  country '501', todo # Belize
  country '502', todo # Guatemala (Republic of)
  country '503', todo # El Salvador (Republic of)
  country '504', todo # Honduras (Republic of)
  country '505', todo # Nicaragua
  country '506', todo # Costa Rica
  country '507', todo # Panama (Republic of)
  country '508', todo # Saint Pierre and Miquelon (Collectivité territoriale de la République française)
  country '509', todo # Haiti (Republic of)

  country '590', todo # Guadeloupe (French Department of)
  country '591', todo # Bolivia (Republic of)
  country '592', todo # Guyana
  country '593', todo # Ecuador
  country '594', todo # French Guiana (French Department of)
  country '595', todo # Paraguay (Republic of)
  country '596', todo # Martinique (French Department of)
  country '597', todo # Suriname (Republic of)
  country '598', todo # Uruguay (Eastern Republic of)
  country '599', todo # Netherlands Antilles

  country '670', todo # Democratic Republic of Timor-Leste
  country '671', todo # Spare code
  country '672', todo # Australian External Territories
  country '673', todo # Brunei Darussalam
  country '674', todo # Nauru (Republic of)
  country '675', todo # Papua New Guinea
  country '676', todo # Tonga (Kingdom of)
  country '677', todo # Solomon Islands
  country '678', todo # Vanuatu (Republic of)
  country '679', todo # Fiji (Republic of)

  country '680', todo # Palau (Republic of)
  country '681', todo # Wallis and Futuna (Territoire français d'outre-mer)
  country '682', todo # Cook Islands
  country '683', todo # Niue
  country '684', todo # -
  country '685', todo # Samoa (Independent State of)
  country '686', todo # Kiribati (Republic of)
  country '687', todo # New Caledonia (Territoire français d'outre-mer)
  country '688', todo # Tuvalu
  country '689', todo # French Polynesia (Territoire français d'outre-mer)

  country '690', todo # Tokelau
  country '691', todo # Micronesia (Federated States of)
  country '692', todo # Marshall Islands (Republic of the)
  country '693', todo # -
  country '694', todo # -
  country '695', todo # -
  country '696', todo # -
  country '697', todo # -
  country '698', todo # -
  country '699', todo # -

  country '800', todo # International Freephone Service
  country '801', todo # -
  country '802', todo # -
  country '803', todo # -
  country '804', todo # -
  country '805', todo # -
  country '806', todo # -
  country '807', todo # -
  country '808', todo # International Shared Cost Service (ISCS)
  country '809', todo # -

  country '830', todo # -
  country '831', todo # -
  country '832', todo # -
  country '833', todo # -
  country '834', todo # -
  country '835', todo # -
  country '836', todo # -
  country '837', todo # -
  country '838', todo # -
  country '839', todo # -

  country '850', todo # Democratic People's Republic of Korea
  country '851', todo # Spare code
  country '852', todo # Hong Kong, China
  country '853', todo # Macao, China
  country '854', todo # Spare code
  country '855', todo # Cambodia (Kingdom of)
  country '856', todo # Lao People's Democratic Republic
  country '857', todo # Spare code
  country '858', todo # Spare code
  country '859', todo # Spare code

  country '870', todo # Inmarsat SNAC
  country '871', todo # Inmarsat (Atlantic Ocean-East)
  country '872', todo # Inmarsat (Pacific Ocean)
  country '873', todo # Inmarsat (Indian Ocean)
  country '874', todo # Inmarsat (Atlantic Ocean-West)
  country '875', todo # Reserved - Maritime Mobile Service Applications
  country '876', todo # Reserved - Maritime Mobile Service Applications
  country '877', todo # Reserved - Maritime Mobile Service Applications
  country '878', todo # Universal Personal Telecommunication Service (UPT)
  country '879', todo # Reserved for national non-commercial purposes

  country '880', todo                  # Bangladesh (People's Republic of)
  country '881', todo # International Mobile, shared code
  country '882', todo # International Networks, shared code
  country '883', todo # -
  country '884', todo # -
  country '885', todo # -
  country '886', todo # Reserved
  country '887', todo # -
  country '888', todo # Reserved for future global service
  country '889', todo # -

  country '890', todo # -
  country '891', todo # -
  country '892', todo # -
  country '893', todo # -
  country '894', todo # -
  country '895', todo # -
  country '896', todo # -
  country '897', todo # -
  country '898', todo # -
  country '899', todo # -

  country '960', todo # Maldives (Republic of)
  country '961', todo # Lebanon
  country '962', todo # Jordan (Hashemite Kingdom of)
  country '963', todo # Syrian Arab Republic
  country '964', todo # Iraq (Republic of)
  country '965', todo # Kuwait (State of)
  country '966', todo # Saudi Arabia (Kingdom of)
  country '967', todo # Yemen (Republic of)
  country '968', todo # Oman (Sultanate of)
  country '969', todo # Reserved - reservation currently under investigation

  country '970', todo # Reserved
  country '971', todo # United Arab Emirates
  country '972', todo # Israel (State of)
  country '973', todo # Bahrain (Kingdom of)
  country '974', todo # Qatar (State of)
  country '975', todo # Bhutan (Kingdom of)
  country '976', todo # Mongolia
  country '977', todo # Nepal
  country '978', todo # -
  country '979', todo # International Premium Rate Service (IPRS)

  country '990', todo # Spare code
  country '991', todo # Trial of a proposed new international telecommunication public correspondence service, shared code
  country '992', todo # Tajikistan (Republic of)
  country '993', todo # Turkmenistan
  country '994', todo # Azerbaijani Republic
  country '995', todo # Georgia
  country '996', todo # Kyrgyz Republic
  country '997', todo # Spare code
  country '998', todo # Uzbekistan (Republic of)
  country '999', todo # Reserved for possible future use within the Telecommunications for Disaster Relief (TDR) concept
end
