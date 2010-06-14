require 'rubygems'

gem 'activesupport', '2.3.2'
begin
  require 'active_support'
rescue LoadError
  require 'activesupport'
end

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'ndc/splitter'
require 'ndc/fixed_size'
require 'ndc/prefix'

# Prefix code countries
require 'ndc/austria'
require 'ndc/germany'

require 'e164'

module E164
  
  include NDC

  # Returns a fixed ndc splitter.
  #
  def self.fixed national_code_length = 2, options = {}
    NDC.fixed national_code_length, options
  end

  # prefix length =>
  #   country code => national prefix length
  @@country_codes = {
    1 => {
      '0' => fixed(0), # reserved
      '1' => fixed(3, :local => [3, 10]), # USA, Canada, etc.
      '7' => fixed(3), # Kazakhstan (Republic of) & Russian Federation
    },
    2 => {
      '20' => fixed(2), # Egypt
      '27' => fixed(2), # South Africa

      '30' => fixed(2), # Greece
      '31' => fixed(2), # Netherlands
      '32' => fixed(2), # Belgium
      '33' => fixed(1, :local => [2, 2, 2, 2]), # France
      '34' => fixed(2), # Spain
      '36' => fixed(2), # Hungary
      '39' => fixed(3), # Italy

      '40' => fixed(2), # Romania
      '41' => fixed(2, :local => [3, 2, 2], :special_ndcs => ['800', '840', '842', '844', '848']), # Switzerland (Confederation of)
      '43' => Austria,
      '44' => fixed(2), # United Kingdom of Great Britain and Northern Ireland
      '45' => fixed(2), # Denmark
      '46' => fixed(2), # Sweden
      '47' => fixed(2), # Norway
      '48' => fixed(2), # Poland (Republic of)
      '49' => Germany,

      '51' => fixed(2), # Peru
      '52' => fixed(2), # Mexico
      '53' => fixed(2), # Cuba
      '54' => fixed(2), # Argentine Republic
      '55' => fixed(2), # Brazil (Federative Republic of)
      '56' => fixed(2), # Chile
      '57' => fixed(2), # Colombia (Republic of)
      '58' => fixed(2), # Venezuela (Bolivarian Republic of)

      '60' => fixed(2), # Malaysia
      '61' => fixed(2), # Australia
      '62' => fixed(2), # Indonesia (Republic of)
      '63' => fixed(2), # Philippines (Republic of the)
      '64' => fixed(1, :local => [3, 4]), # New Zealand
      '65' => fixed(2), # Singapore (Republic of)
      '66' => fixed(2), # Thailand

      '81' => fixed(2), # Japan
      '82' => fixed(2), # Korea (Republic of)
      '84' => fixed(2), # Viet Nam (Socialist Republic of)
      '86' => fixed(2), # China (People's Republic of)

      '90' => fixed(2), # Turkey
      '91' => fixed(2), # India (Republic of)
      '92' => fixed(2), # Pakistan (Islamic Republic of)
      '93' => fixed(2), # Afghanistan
      '94' => fixed(2), # Sri Lanka (Democratic Socialist Republic of)
      '95' => fixed(2), # Myanmar (Union of)
      '98' => fixed(2), #Iran (Islamic Republic of)
    },
    3 => {
      '210' => fixed(2), # -
      '211' => fixed(2), # -
      '212' => fixed(2), # Morocco
      '213' => fixed(2), # Algeria
      '214' => fixed(2), # -
      '215' => fixed(2), # -
      '216' => fixed(2), # Tunisia
      '217' => fixed(2), # -
      '218' => fixed(2), # Lybia
      '219' => fixed(2), # -

      '220' => fixed(2), # Gambia
      '221' => fixed(2), # Senegal
      '222' => fixed(2), # Mauritania
      '223' => fixed(2), # Mali
      '224' => fixed(2), # Guinea
      '225' => fixed(2), # Côte d'Ivoire
      '226' => fixed(2), # Burkina Faso
      '227' => fixed(2), # Niger
      '228' => fixed(2), # Togolese Republic
      '229' => fixed(2), # Benin

      '230' => fixed(2), # Mauritius
      '231' => fixed(2), # Liberia
      '232' => fixed(2), # Sierra Leone
      '233' => fixed(2), # Ghana
      '234' => fixed(2), # Nigeria
      '235' => fixed(2), # Chad
      '236' => fixed(2), # Central African Republic
      '237' => fixed(2), # Cameroon
      '238' => fixed(2), # Cape Verde
      '239' => fixed(2), # Sao Tome and Principe

      '240' => fixed(2), # Equatorial Guinea
      '241' => fixed(2), # Gabonese Republic
      '242' => fixed(2), # Congo
      '243' => fixed(2), # Democratic Republic of the Congo
      '244' => fixed(2), # Angola
      '245' => fixed(2), # Guinea-Bissau
      '246' => fixed(2), # Diego Garcia
      '247' => fixed(2), # Ascension
      '248' => fixed(2), # Seychelles
      '249' => fixed(2), # Sudan

      '250' => fixed(2), # Rwanda
      '251' => fixed(2), # Ethiopia
      '252' => fixed(2), # Somali Democratic Republic
      '253' => fixed(2), # Djibouti
      '254' => fixed(2), # Kenya
      '255' => fixed(2), # Tanzania
      '256' => fixed(2), # Uganda
      '257' => fixed(2), # Burundi
      '258' => fixed(2), # Mozambique
      '259' => fixed(2), # -

      '260' => fixed(2), # Zambia
      '261' => fixed(2), # Madagascar
      '262' => fixed(3), # Reunion / Mayotte (new)
      '263' => fixed(2), # Zimbabwe
      '264' => fixed(2), # Namibia
      '265' => fixed(2), # Malawi
      '266' => fixed(2), # Lesotho
      '267' => fixed(2), # Botswana
      '268' => fixed(2), # Swaziland
      '269' => fixed(2), # Comoros

      '280' => fixed(2), # -
      '281' => fixed(2), # -
      '282' => fixed(2), # -
      '283' => fixed(2), # -
      '284' => fixed(2), # -
      '285' => fixed(2), # -
      '286' => fixed(2), # -
      '287' => fixed(2), # -
      '288' => fixed(2), # -
      '289' => fixed(2), # -
      '290' => fixed(2), # Saint Helena

      '291' => fixed(2), # Eritrea
      '292' => fixed(2), # -
      '293' => fixed(2), # -
      '294' => fixed(2), # -
      '295' => fixed(2), # -
      '296' => fixed(2), # -
      '297' => fixed(2), # Aruba
      '298' => fixed(2), # Faroe Islands
      '299' => fixed(2), # Greenland

      '350' => fixed(2), # Gibraltar
      '351' => fixed(2), # Portugal
      '352' => fixed(2), # Luxembourg
      '353' => fixed(2), # Ireland
      '354' => fixed(2), # Iceland
      '355' => fixed(2), # Albania
      '356' => fixed(2), # Malta
      '357' => fixed(2), # Cyprus
      '358' => fixed(2), # Finland
      '359' => fixed(2), # Bulgaria

      '370' => fixed(2), # Lithuania
      '371' => fixed(2), # Latvia
      '372' => fixed(2), # Estonia
      '373' => fixed(2), # Moldova
      '374' => fixed(2), # Armenia
      '375' => fixed(2), # Belarus
      '376' => fixed(2), # Andorra
      '377' => fixed(2), # Monaco
      '378' => fixed(2), # San Marino
      '379' => fixed(2), # Vatican City State

      '380' => fixed(2), # Ukraine
      '381' => fixed(2), # Serbia and Montenegro
      '382' => fixed(2), # -
      '383' => fixed(2), # -
      '384' => fixed(2), # -
      '385' => fixed(2), # Croatia
      '386' => fixed(2), # Slovenia
      '387' => fixed(2), # Bosnia and Herzegovina
      '388' => fixed(2), # Group of countries, shared code
      '389' => fixed(2), # The Former Yugoslav Republic of Macedonia

      '420' => fixed(2), # Czech Republic
      '421' => fixed(2), # Slovak Republic
      '422' => fixed(2), # Spare code
      '423' => fixed(0, :local => [3, 2, 2]), # Liechtenstein (Principality of)
      '424' => fixed(2), # -
      '425' => fixed(2), # -
      '426' => fixed(2), # -
      '427' => fixed(2), # -
      '428' => fixed(2), # -
      '429' => fixed(2), # -

      '500' => fixed(2), # Falkland Islands (Malvinas)
      '501' => fixed(2), # Belize
      '502' => fixed(2), # Guatemala (Republic of)
      '503' => fixed(2), # El Salvador (Republic of)
      '504' => fixed(2), # Honduras (Republic of)
      '505' => fixed(2), # Nicaragua
      '506' => fixed(2), # Costa Rica
      '507' => fixed(2), # Panama (Republic of)
      '508' => fixed(2), # Saint Pierre and Miquelon (Collectivité territoriale de la République française)
      '509' => fixed(2), # Haiti (Republic of)

      '590' => fixed(3), # Guadeloupe (French Department of)
      '591' => fixed(2), # Bolivia (Republic of)
      '592' => fixed(2), # Guyana
      '593' => fixed(2), # Ecuador
      '594' => fixed(3), # French Guiana (French Department of)
      '595' => fixed(2), # Paraguay (Republic of)
      '596' => fixed(3), # Martinique (French Department of)
      '597' => fixed(2), # Suriname (Republic of)
      '598' => fixed(2), # Uruguay (Eastern Republic of)
      '599' => fixed(2), # Netherlands Antilles

      '670' => fixed(2), # Democratic Republic of Timor-Leste
      '671' => fixed(2), # Spare code
      '672' => fixed(2), # Australian External Territories
      '673' => fixed(2), # Brunei Darussalam
      '674' => fixed(2), # Nauru (Republic of)
      '675' => fixed(2), # Papua New Guinea
      '676' => fixed(2), # Tonga (Kingdom of)
      '677' => fixed(2), # Solomon Islands
      '678' => fixed(2), # Vanuatu (Republic of)
      '679' => fixed(2), # Fiji (Republic of)

      '680' => fixed(2), # Palau (Republic of)
      '681' => fixed(2), # Wallis and Futuna (Territoire français d'outre-mer)
      '682' => fixed(2), # Cook Islands
      '683' => fixed(2), # Niue
      '684' => fixed(2), # -
      '685' => fixed(2), # Samoa (Independent State of)
      '686' => fixed(2), # Kiribati (Republic of)
      '687' => fixed(2), # New Caledonia (Territoire français d'outre-mer)
      '688' => fixed(2), # Tuvalu
      '689' => fixed(2), # French Polynesia (Territoire français d'outre-mer)

      '690' => fixed(2), # Tokelau
      '691' => fixed(2), # Micronesia (Federated States of)
      '692' => fixed(2), # Marshall Islands (Republic of the)
      '693' => fixed(2), # -
      '694' => fixed(2), # -
      '695' => fixed(2), # -
      '696' => fixed(2), # -
      '697' => fixed(2), # -
      '698' => fixed(2), # -
      '699' => fixed(2), # -

      '800' => fixed(2), # International Freephone Service
      '801' => fixed(2), # -
      '802' => fixed(2), # -
      '803' => fixed(2), # -
      '804' => fixed(2), # -
      '805' => fixed(2), # -
      '806' => fixed(2), # -
      '807' => fixed(2), # -
      '808' => fixed(2), # International Shared Cost Service (ISCS)
      '809' => fixed(2), # -

      '830' => fixed(2), # -
      '831' => fixed(2), # -
      '832' => fixed(2), # -
      '833' => fixed(2), # -
      '834' => fixed(2), # -
      '835' => fixed(2), # -
      '836' => fixed(2), # -
      '837' => fixed(2), # -
      '838' => fixed(2), # -
      '839' => fixed(2), # -

      '850' => fixed(2), # Democratic People's Republic of Korea
      '851' => fixed(2), # Spare code
      '852' => fixed(2), # Hong Kong, China
      '853' => fixed(2), # Macao, China
      '854' => fixed(2), # Spare code
      '855' => fixed(2), # Cambodia (Kingdom of)
      '856' => fixed(2), # Lao People's Democratic Republic
      '857' => fixed(2), # Spare code
      '858' => fixed(2), # Spare code
      '859' => fixed(2), # Spare code

      '870' => fixed(2), # Inmarsat SNAC
      '871' => fixed(2), # Inmarsat (Atlantic Ocean-East)
      '872' => fixed(2), # Inmarsat (Pacific Ocean)
      '873' => fixed(2), # Inmarsat (Indian Ocean)
      '874' => fixed(2), # Inmarsat (Atlantic Ocean-West)
      '875' => fixed(2), # Reserved - Maritime Mobile Service Applications
      '876' => fixed(2), # Reserved - Maritime Mobile Service Applications
      '877' => fixed(2), # Reserved - Maritime Mobile Service Applications
      '878' => fixed(2), # Universal Personal Telecommunication Service (UPT)
      '879' => fixed(2), # Reserved for national non-commercial purposes

      '880' => fixed(2), # Bangladesh (People's Republic of)
      '881' => fixed(2), # International Mobile, shared code
      '882' => fixed(2), # International Networks, shared code
      '883' => fixed(2), # -
      '884' => fixed(2), # -
      '885' => fixed(2), # -
      '886' => fixed(2), # Reserved
      '887' => fixed(2), # -
      '888' => fixed(2), # Reserved for future global service
      '889' => fixed(2), # -

      '890' => fixed(2), # -
      '891' => fixed(2), # -
      '892' => fixed(2), # -
      '893' => fixed(2), # -
      '894' => fixed(2), # -
      '895' => fixed(2), # -
      '896' => fixed(2), # -
      '897' => fixed(2), # -
      '898' => fixed(2), # -
      '899' => fixed(2), # -

      '960' => fixed(2), # Maldives (Republic of)
      '961' => fixed(2), # Lebanon
      '962' => fixed(2), # Jordan (Hashemite Kingdom of)
      '963' => fixed(2), # Syrian Arab Republic
      '964' => fixed(2), # Iraq (Republic of)
      '965' => fixed(2), # Kuwait (State of)
      '966' => fixed(2), # Saudi Arabia (Kingdom of)
      '967' => fixed(2), # Yemen (Republic of)
      '968' => fixed(2), # Oman (Sultanate of)
      '969' => fixed(2), # Reserved - reservation currently under investigation

      '970' => fixed(2), # Reserved
      '971' => fixed(2), # United Arab Emirates
      '972' => fixed(2), # Israel (State of)
      '973' => fixed(2), # Bahrain (Kingdom of)
      '974' => fixed(2), # Qatar (State of)
      '975' => fixed(2), # Bhutan (Kingdom of)
      '976' => fixed(2), # Mongolia
      '977' => fixed(2), # Nepal
      '978' => fixed(2), # -
      '979' => fixed(2), # International Premium Rate Service (IPRS)

      '990' => fixed(2), # Spare code
      '991' => fixed(2), # Trial of a proposed new international telecommunication public correspondence service, shared code
      '992' => fixed(2), # Tajikistan (Republic of)
      '993' => fixed(2), # Turkmenistan
      '994' => fixed(2), # Azerbaijani Republic
      '995' => fixed(2), # Georgia
      '996' => fixed(2), # Kyrgyz Republic
      '997' => fixed(2), # Spare code
      '998' => fixed(2), # Uzbekistan (Republic of)
      '999' => fixed(2), # Reserved for possible future use within the Telecommunications for Disaster Relief (TDR) concept
    }
  }
  
  # Splits the phone number into pieces according to the country codes above.
  #
  def self.split(phone_number)
    splitter_or_number, country_code, ndc, local = split_internal(phone_number) do |splitter, cc, ndc_local|
      [splitter, cc, splitter.split_ndc(ndc_local)].flatten
    end
    return splitter_or_number if local.nil?
    
    [country_code, ndc, splitter_or_number.split_local(local)].flatten
  end
  
  # Formats a E164 number according to local customs.
  #
  def self.formatted(phone_number, options = {})
    splitter_or_number, cc, ndc, local = split_internal(phone_number) do |splitter, cc, ndc_local|
      [splitter, cc, splitter.split_ndc(ndc_local)].flatten
    end
    return splitter_or_number if local.nil?
    
    space = options[:spaces] || ' '
    formatted_cc_ndc(cc, ndc, options[:format], space) + splitter_or_number.locally_formatted(local, space)
  end
  
  # Normalizes
  #
  def self.normalize(phone_number)
    phone_number = phone_number.dup
    phone_number.gsub!(/\D*/, '').gsub!(/^0+/, '') # Remove zeros at the beginning and non-digit chars
    remove_relative_zeros! phone_number
  end
    
  # Returns true if the number starts with 4 digits and ends with 6-12 characters.
  #
  def self.vanity_number?(number)
    (number.gsub(' ', '') =~ /^\d{4}\w{6,12}$/) ? true : false
  end
  
  # Converts any character in the vanity_number to it's numeric representation.
  # Does not check if the passed number is a valid vanity_number, simply does replacement.
  #
  def self.vanity_to_number(vanity_number)
    Vanity.replace(vanity_number)
  end
  
  module Vanity
    mattr_accessor :mapping
    @@mapping = { :a => 2, :b => 2, :c => 2,
                :d => 3, :e => 3, :f => 3,
                :g => 4, :h => 4, :i => 4,
                :j => 5, :k => 5, :l => 5,
                :m => 6, :n => 6, :o => 6,
                :p => 7, :q => 7, :r => 7, :s => 7,
                :t => 8, :u => 8, :v => 8,
                :w => 9, :x => 9, :y => 9, :z => 9
    }
  
    def self.char_to_number(char)
      key = char.to_s.downcase.to_sym
      mapping.key?(key) ? mapping[key].to_s : char
    end
    
    # Replaces vanity characters of passed number with correct digits.
    # Does not check for validity of vanity_number. Simply replaces all characters in the number
    #
    def self.replace(number)
      number.split('').inject([]) {|result, char| result << char_to_number(char)}.join
    end
        
  end
  
  
  private
    
    # Removes 0s from partially normalized numbers such as:
    # 410443643533
    # 
    # Example:
    #   410443643533 -> 41443643533
    def self.remove_relative_zeros!(phone_number, format = nil)
      '%s%s' % split_cc(phone_number).collect! { |code| code.gsub(/^0+/, '') }
    end
    
    # Formats country code and national destination code.
    #
    def self.formatted_cc_ndc(cc, ndc, format, space = nil)
      space ||= ' ' 
      format, split_phone_number = case format
      when nil, :international_absolute, :international, :+
        [ndc.blank? ? '+%s%s' : '+%s%s%s%s', [cc, space, ndc, space]]
      when :international_relative
        [ndc.blank? ? '00%s%s' : '00%s%s%s%s', [cc, space, ndc, space]]
      when :national
        [ndc.blank? ? '' : '0%s%s', [ndc, space]]
      when :local
        ['', []]
      end
      format % split_phone_number
    end
    
    def self.split_cc(phone_number)
      split_internal(phone_number) do |splitter, cc, ndc_local|
        [cc, ndc_local]
      end
    end
    
    def self.split_cc_ndc(phone_number)
      split_internal(phone_number) do |splitter, cc, ndc_local|
        splitter ? [cc, splitter.split_ndc(ndc_local)].flatten : [cc, ndc_local, '']
      end
    end
    
    def self.split_internal(phone_number)
      number = phone_number.dup
      presumed_code = ''
      1.upto(3) do |i|
        presumed_code << number.slice!(0..0)
        splitter = @@country_codes[i][presumed_code]
        return yield(splitter, presumed_code, number) if splitter
      end
      return yield(nil, '', '')
    end
    
end