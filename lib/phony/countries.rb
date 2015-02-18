# All countries, ordered by country code.
#
# Definitions are in the format:
#   NDC >> National | NDC >> National | # ...
#
# As soon as a NDC matches, it goes on to the National part. Then breaks off.
# If the NDC does not match, it go on to the next (|, or "or") NDC.
#
# For the pre-ndc part, there's:
# * trunk: If the country has a trunk code (options normalize/split – remove trunk on these method, default false).
#
# Available matching/splitting methods:
# * none:   Does not have a national destination code, e.g. Denmark, Iceland.
# * one_of: Matches one of the following numbers. Splits if it does.
# * match: Try to match the regex, and if it matches, splits it off.
# * fixed:  Always splits off a fixed length ndc. (Always use last in a | chain as a catchall)
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
  reserved '0'

  # USA, Canada, etc.
  #
  country '1',
    # The US has a delimiter between NDC and local number.
    trunk('1%s', normalize: true) | # http://en.wikipedia.org/wiki/Trunk_prefix
    fixed(3) >> split(3,4),
    :invalid_ndcs => ['911']

  # Kazakhstan (Republic of) & Russsian Federation.
  # also Abhasia and South Osetia autonomous regions / recognized by some states as independent countries
  #country '7', fixed(3) >> split(3,2,2)
  # see special file

  # Egypt.
  #
  country '20', one_of('800')    >> split(7..7) | # Egypt
                one_of('2', '3') >> split(8..8) | # Cairo/Giza, Alexandria
                fixed(2)         >> split(8..8)
                # :mobile? => /^1[01246-9]\d+$/, :service? => /^800\d+$/

  # South Africa.
  #
  country '27', fixed(2) >> split(3,4)

  # Greece. http://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=GR
  country '30',
    trunk('0') |
    one_of(%w(231 241 251 261 271 281)) >> split(3,4) |
    one_of('800') >> split(3,4) | # freephone
    one_of(%w(801 807)) >> split(3,4) | # shared cost, premium rate
    one_of('896') >> split(3,4) | # ISP
    one_of(%w(901 909)) >> split(3,4) | # premium rate
    one_of(%w(21 22 23 24 25 26 27 28)) >> split(4,4) |
    one_of('50') >> split(4,4) | # VPN
    match(/^(69\d)\d+$/) >> split(3,4) | # mobile, pager
    one_of('70') >> split(4,4) | # universal access
    fixed(4) >> split(6)   # 3-digit NDCs

  # country '31' # Netherlands, see special file.

  # Belgium.
  #
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Belgium
  #
  country '32', trunk('0') |
                match(/^(70|800|90\d)\d+$/) >> split(3,3)   | # Service
                match(/^(468)\d{6}$/)       >> split(6)     | # Mobile (Telenet)
                match(/^(4[789]\d)\d{6}$/)  >> split(6)     | # Mobile
                one_of('2','3','4','9')     >> split(3,2,2) | # Short NDCs
                fixed(2)                    >> split(2,2,2)   # 2-digit NDCs

  # France.
  #
  country '33',
    trunk('0') |
    fixed(1) >> split(2,2,2,2) # :service? => /^8.*$/, :mobile? => /^[67].*$/

  # Spain.
  #
  # http://www.minetur.gob.es/telecomunicaciones/es-es/servicios/numeracion/paginas/plan.aspx
  #
  country '34',
    match(/^([67]\d{2})\d+$/) >> split(3,3)   | # Mobile
    match(/^([89]0\d)\d+$/)   >> split(3,3)   | # Special 80X & 90X numbers
    one_of(%w(91 93))         >> split(3,2,2) | # Landline large regions
    match(/^(9\d{2})\d+$/)    >> split(2,2,2) | # Landline
    fixed(3, :zero => false)  >> split(3,3)

  # Hungary.
  #
  country '36',
    trunk('06', normalize: false) |
    one_of('104','105','107','112') >> split(3,3) | # Service
    one_of('1')                     >> split(3,4) | # Budapest
    fixed(2)                        >> split(3,4)   # 2-digit NDCs

  # country '39' # Italy, see special file.

  # Romania.
  #
  country '40',
          trunk('0') |
          match(/^(112|800|90[036])\d+$/) >> split(3,3) | # Service
          match(/^(7[1-8])\d+$/)          >> split(3,4) | # Mobile
          one_of('21', '31')              >> split(3,4) | # Bucureşti
          fixed(3)                        >> split(3,4)   # 3-digit NDCs

  # Switzerland.
  #
  country '41',
          trunk('0', normalize: true) |
          match(/^(8(00|4[0248]))\d+$/) >> split(3,3)|
          fixed(2)                      >> split(3,2,2)

  # country '43' # Austria, see special file.
  # country '44' # UnitedKingdom, see special file.

  # Denmark.
  #
  country '45',
          none >> split(2,2,2,2..2)

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
          match(/^(5[013]\d|6[069]\d|7[02389]\d|80[01]|88\d)/) >> split(3,3) |
          fixed(2)                                             >> split(3,2,2)

  # country '49' # Germany, see special file.

  # Peru.
  #
  country '51',
          one_of('103', '105') >> split(3,3) | # Service.
          one_of('1', '9')     >> split(4,4) | # Lima and mobile.
          fixed(2)             >> split(4,4)   # 2-digit NDCs.

  # Mexico.
  #
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Mexico
  # http://en.wikipedia.org/wiki/National_conventions_for_writing_telephone_numbers#Mexico
  country '52',
          match(/^(0\d{1,2})\d{10}$/)   >> split(3,3,4)   | # prefixed numbers from within Mexico (e.g. 045 + 10 digits or 02 + 10 digits)
          match(/^(1)(33|55|81)\d{8}$/) >> split(2,4,4)   | # Mexico D.F, Guadalajara, Monterrey cell phone from abroad (e.g. 52 1 55 xxxx xxxx)
          match(/^(33|55|81)\d{8}$/)    >> split(4,4)     | # Mexico D.F, Guadalajara, Monterrey from within Mexico
          match(/^(1)(\d{3})\d{7}$/)    >> split(3,3,4)   | # cell phone from abroad
          match(/^(\d{3})\d{7}$/)       >> split(3,4)       # catchall.

  # Cuba.
  #
  country '53',
          match(/^(5\d{3})\d+$/)             >> split(4) | # Mobile
          match(/^(7|2[123]|4[1-8]|3[1-3])/) >> split(7) | # Short NDCs
          fixed(3)                           >> split(7)   # 3-digit NDCs

  # Argentine Republic.
  #
  country '54',
          one_of('11', '911') >> split(4,4) | # Fixed & Mobile
          match(/^(22[0137]|237|26[14]|29[179]|34[1235]|35[138]|38[1578])/) >> split(3,4) |        # Fixed
          match(/^(922[0137]|9237|926[14]|929[179]|934[1235]|935[138]|938[1578])/) >> split(3,4) | # Mobile
          match(/^(9\d{4})/) >> split(2,4) | # Mobile
          match(/^([68]\d{2})/) >> split(3,4) | # Service
          fixed(4) >> split(2,4) # Fixed

  # Brazil (Federative Republic of).
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Brazil
  # country '55' # Brazil, see special file.

  # Chile.
  #
  country '56',
    match(/^(13[0-79]|14[79])\d+$/) >> split(3,3) | # Service
    one_of('2', '9')                >> split(8)   | # Santiago, Mobile
    fixed(2)                        >> split(8)     # 2-digit NDCs

  # Colombia.
  # http://www.itu.int/oth/T020200002C/en
  country '57',
    match(/\A(3\d\d)\d+\z/) >> split(3,4) | # mobile (300 310 311 312 313 315 316)
    fixed(1) >> split(3,4)

  # Venezuela (Bolivarian Republic of)
  #
  country '58',
    fixed(3) >> split(7)

  # country '60' # Malaysia, see special file.

  # Australia.
  #
  country '61',
    trunk('0') |
    match(/^(4\d\d)\d+$/) >> split(3,3) | # Mobile
    fixed(1)              >> split(4,4)   # Rest

	# country '62' # Indonesia (Republic of), see special file

  # Philippines (Republic of the)
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=PH
  country '63',
    trunk('0') |
    # 7/10 digits for area code '2'.
    match(/\A(2)\d{10}\z/) >> split(10) |
    one_of('2') >> split(7) |
    # mobile
    match(/\A(9\d\d)\d{7}\z/) >> split(7) |
    match(/\A(9\d\d)\d+\z/) >> split(6) |
    #
    fixed(2) >> split(7)

  # New Zealand.
  #
  country '64',
    trunk('0') |
    match(/^(2\d)\d{7}$/) >> split(3,4)   | # Mobile
    match(/^(2\d)\d{6}$/) >> split(3,3)   |
    match(/^(2\d)\d{8}$/) >> split(2,3,3) |
    fixed(1) >> split(3,4)                  # Rest

  # Singapore (Republic of).
  #
  country '65',
    none >> split(4,4) # TODO Short Codes.

  # Thailand.
  #
  country '66',
    trunk('0') |
    match(/\A(8\d\d)\d+\z/) >> split(3,3) | # mobile
    one_of('2') >> split(3,4) | # Bangkok
    fixed(2)    >> split(3,3)   # Rest

  # country '81'  # Japan, see special file.

  # country '82' # SouthKorea, see special file.

  # country '84' # Vietnam, see special file.

  # country '86' # China, see special file.

  # Turkey.
  #
  country '90',
    trunk('0') |
    fixed(3) >> split(3,4) # Wiki says 7, but the examples say 3, 4.

  # country '91' #  India (Republic of) see special file

  # country '92' # Pakistan (Islamic Republic of), see special file.

  # Afghanistan.
  #
  # From http://www.wtng.info/wtng-93-af.html
  #
  country '93', fixed(2) >> split(7) # Note: the document says 6, but the examples use 7.

  country '94', # TODO Sri Lanka (Democratic Socialist Republic of)
    fixed(2) >> split(3,2,2)

  country '95', trunk('0') | fixed(2) >> split(3,2,2) # TODO Myanmar (Union of)

  country '98', #  Iran (Islamic Republic of)
    one_of('21') >> split(4,4) | # Teheran
    fixed(3) >> split(3,4)

  country '210', todo # -
  country '211', fixed(3) >> split(3,3) # South Sudan, http://www.wtng.info/wtng-211-ss.html

  country '212', # Morocco
    trunk('0') |
    one_of('6') >> split(2,2,2,2) | # mobile
    fixed(2) >> split(4,3)

  country '213', fixed(2) >> split(3,4) # Algeria
  country '214', todo # -
  country '215', todo # -
  country '216', fixed(1) >> split(3,4) # Tunisia
  country '217', todo # -

  # country '218' # Lybia, see special file

  country '219', todo # -

  country '220', none >> split(3,4) # Gambia http://www.wtng.info/wtng-220-gm.html
  country '221', none >> split(4,5) # Senegal http://www.wtng.info/wtng-221-sn.html
  country '222', none >> split(4,4) # Mauritania http://www.wtng.info/wtng-222-mr.html
  country '223', none >> split(4,4) # Mali http://www.wtng.info/wtng-223-ml.html

  # country '224' # Guinea, see special file

  country '225', none >> split(4,4) # Côte d'Ivoire http://www.wtng.info/wtng-225-ci.html
  country '226', none >> split(4,4) # Burkina Faso http://www.wtng.info/wtng-226-bf.html
  country '227', none >> split(4,4) # Niger http://www.wtng.info/wtng-227-ne.html
  country '228', none >> split(4,4) # Togolese Republic http://www.wtng.info/wtng-228-tg.html
  country '229', none >> split(4,4) # Benin http://www.itu.int/oth/T0202000017/en

  country '230', none >> split(3,4) # Mauritius http://www.wtng.info/wtng-230-mu.html

  # Liberia
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=LR
  country '231',
    none >> matched_split(
        /\A[23]\d+\z/ => [4,4], # LIBTELCO, TEMAS
        /\A[4568]\d+\z/ => [4,3], # mobile Lonestar, Libercell, Comium Liberia Inc.
        /\A7\d+\z/ => [4,4], # mobile Cellcom
        /\A9\d+\z/ => [4,4], # premium rate Telelinks International SAL, Interactive Media Corporation
    )

  country '232', fixed(2) >> split(3, 3) # Sierra Leone http://www.wtng.info/wtng-232-sl.html

  # Ghana
  #
  # From http://www.itu.int/oth/T0202000052/en
  #
  country '233', fixed(2) >> split(3,4)

  # Nigeria
  # Wikipedia says 3 4 split, many local number with no splitting
  country '234',
    one_of('1', '2', '9')   >> split(3,4) | # Lagos, Ibadan and Abuja
    match(/^(702\d)\d+$/)   >> split(3,4) | # Mobile
    match(/^(70[3-9])\d+$/) >> split(3,4) | # Mobile
    match(/^(8[01]\d)\d+$/) >> split(3,4) | # Mobile
    fixed(2)                >> split(3,4)   # 2-digit NDC

  country '235', none >> split(4,4) # Chad http://www.wtng.info/wtng-235-td.html
  country '236', none >> split(4,4) # Central African Republic http://www.wtng.info/wtng-236-cf.html
  country '237', none >> split(4,4) # Cameroon http://www.wtng.info/wtng-237-cm.html
  country '238', none >> split(3,4) # Cape Verde http://www.wtng.info/wtng-238-cv.html
  country '239', fixed(1) >> split(3,3) # Sao Tome and Principe, http://www.wtng.info/wtng-239-st.html

  country '240', none >> split(3,3,3) # Equatorial Guinea
  country '241', fixed(1) >> split(3,3) # Gabonese Republic http://www.wtng.info/wtng-241-ga.html
  country '242', none >> split(4,5) # Congo http://www.wtng.info/wtng-242-cg.html
  country '243', fixed(1) >> split(3,4) # Democratic Republic of the Congo http://www.wtng.info/wtng-243-cd.html
  country '244', one_of('321', '348', '358', '363', '364', '485', '526', '535', '546', '612', '643', '652', '655', '722', '726', '728', '729', '777') >> split(3,3) | # Angola
                 fixed(2) >> split(3,4)
  country '245', none >> split(3,4) # Guinea-Bissau http://www.wtng.info/wtng-245-gw.html
  country '246', none >> split(3,4) # Diego Garcia http://www.wtng.info/wtng-246-io.html
  country '247', none >> split(4) # Ascension

  country '248',  # Seychelles
    fixed(1) >> split(2,2,2)

  country '249', fixed(2) >> split(3,4) # Sudan

  # Rwanda
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Rwanda
  country '250',
    trunk('0') |
    one_of('25')       >> split(7) | # Geographic, fixed
    match(/^(7[238])/) >> split(7) | # Non-geographic, mobile
    one_of('06')       >> split(6)   # Satellite

  country '251', fixed(2) >> split(3, 4) # Ethiopia http://www.wtng.info/wtng-251-et.html

  # country '252' # Somali Democratic Republic, see special file

  country '253', none >> split(4, 4) # Djibouti http://www.wtng.info/wtng-253-dj.html

  # Kenya
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Kenya
  country '254',
    trunk('0') |
    match(/^(7\d\d)/) >> split(6) | # mobile
    fixed(2)          >> split(7)   # landline

  # Tanzania.
  #
  country '255',
    trunk('0') |
    match(/^([89]\d\d)/) >> split(3,3) | # Special/Premium.
    one_of('112', '118') >> split(3,3) | # Short Codes.
    fixed(2)             >> split(3,4)   # Geographic.

  # Uganda.
  #
  country '256',
    match(/^(46[45]|4[78]\d)/) >> split(6) | # Geo 1.
    fixed(2)                   >> split(7)   # Geo 2.

  country '257', none >> split(4,4) # Burundi http://www.wtng.info/wtng-257-bi.html

  # Mozambique, https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=MZ
  country '258',
    one_of('600') >> split(3,3) | # audiotext
    one_of('610') >> split(3,3) | # ISP
    one_of('800') >> split(3,3) | # freephone
    one_of('801') >> split(3,3) | # local rate
    one_of('802') >> split(3,3) | # national rate
    one_of(%w(251 252 271 272 281 282 293)) >> split(3,2) |
    one_of(%w(21 23 24 26)) >> split(3,3) |
    one_of(%w(82 84 86)) >> split(4,3) | # mobile
    one_of('89') >> split(4,3) | # satellite GMPCS
    one_of('7') >> split(4,4) | # universal access
    one_of('9') >> split(4,4) | # premium rate
    fixed(2) >> split(3,3)

  country '259', todo # -

  # Zambia
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Zambia
  country '260',
          match(/^(9[567])/)  >> split(7) | # Mobile
          match(/^(21[1-8])/) >> split(6)   # Geographic

  # Madagascar http://www.wtng.info/wtng-261-mg.html
  # http://www.itu.int/oth/T020200007F/en
  country '261',
          none >> matched_split(
              /\A200\d+\z/ => [2,3,3,3], # Telecom Malagasy (Telma)
              /\A20\d+\z/ => [2,3,4], # Telecom Malagasy (Telma)
              /\A23\d+\z/ => [2,3,4], # Digitel
              /\A30\d+\z/ => [2,3,4], # mobile Madamobil (CDMA2000)
              /\A31\d+\z/ => [2,3,4], # mobile Sacel
              /\A32\d+\z/ => [2,3,4], # mobile Orange Madagascar
              /\A34\d+\z/ => [2,3,4], # mobile Telecom Malagasy (Telma)
              /\A5\d+\z/ => [3,3,3],  # pager
              /\A22\d+\z/ => [3,3,3], # satellite GULFSAT Téléphonie
              /\A6\d+\z/ => [3,3,3]   # satellite
          )

  country '262', fixed(3) >> split(3, 3) # Reunion / Mayotte (new) http://www.wtng.info/wtng-262-fr.html

  # country '263' # Zimbabwe, see special file

  # country '264' # Namibia, see special file

  # Malawi
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=MW
  country '265',
          none >> matched_split(
              /\A(21|77)\d+\z/ => [3,3,3], # geographic, mobile
              /\A(88|99)\d{7}\z/ => [3,3,3], # mobile
              /\A18(00|11|18|20)\z/ => [4], # ISP
              /\A\d+\z/ => [4,3]
          )

  country '266', none >> split(4, 4) # Lesotho http://www.wtng.info/wtng-266-ls.html

  # Botswana
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=BW
  country '267',
          one_of(%w(463 495 499 590)) >> split(4) |
          one_of(%w(24 26 29 31 46 47 49 53 54 57 58 59 62 65 68)) >> split(3,2) |
          one_of('79') >> split(3,3) | # VoIP telephony
          one_of('80') >> split(3,3) | # freephone
          one_of('90') >> split(3,3) | # premium rate
          one_of('7') >> split(4,3) | # moblie
          one_of('8') >> split(4,3) | # shared cost
          one_of('3') >> split(3,3) |
          fixed(2) >> split(3,2)

  # Swaziland http://www.wtng.info/wtng-268-sz.html
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=SZ
  country '268',
          none >> matched_split(
              /\A08\d+\z/ => [4,3], # freephone
              /\A(2200|2300|2538|2548)\d+\z/ => [4,4], # VoIP telephony Swaziland Posts and Telecommunications Corporation (SPTC)
              /\A(2400|76)\d+\z/ => [4,4], # mobile Swazi MTN Ltd
              /\A(2550|2551)\d+\z/ => [4,4], # wireless geographic Swaziland Posts and Telecommunications Corporation (SPTC)
              /\A(550|551)\d+\z/ => [3,4], # wireless geographic Swaziland Posts and Telecommunications Corporation (SPTC)
              /\A(22|23|24|25)\d+\z/ => [4,4], # geographic SPTC
              /\A77\d+\z/ => [4,4], # mobile Swaziland Posts and Telecommunications Corporation (SPTC) (CDMA)
              /\A78\d+\z/ => [4,4], # mobile Swazi MTN Ltd
          )

  # Comoros http://www.wtng.info/wtng-269-km.html
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=KM
  country '269',
          none >> matched_split(
              /\A800\d+\z/ => [4,3,3], # freephone Toll-free Global269
              /\A(763|77)\d+\z/ => [4,3], # geographic Comores Télécom
              /\A(32|33|34)\d+\z/ => [4,3], # mobile Comores Télécom (HURI)
              /\A(390|391|900|910)\d+\z/ => [4,3], # premium rate WIAIR SARL
              /\A(76)\d+\z/ => [4,3] # wireless geographic Comores Télécom
          )

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
  country '290', none >> split(4) # Saint Helena http://www.wtng.info/wtng-290-sh.html
  country '291', fixed(1) >> split(3, 3) # Eritrea http://www.wtng.info/wtng-291-er.html
  country '292', todo # -
  country '293', todo # -
  country '294', todo # -
  country '295', todo # -
  country '296', todo # -

  # Aruba
  # http://www.itu.int/dms_pub/itu-t/oth/02/02/T020200000B0001PDFE.pdf
  # Landline numbers begin 52 or 58.
  country '297',
          fixed(3) >> split(4)

  # Faroe Islands http://www.wtng.info/wtng-298-fo.html
  country '298',
          none >> matched_split(
              /\A1\d+\z/ => [4], # universal access: Føroya Tele; ISP: Kall, Føroya Tele
              /\A\d+\z/ => [3,3]
          )

  # Greenland http://www.wtng.info/wtng-299-gl.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=GL
  country '299',
          one_of(%w(199 691)) >> split(3) | # satellite; geographic: Ivittuut
          one_of(%w(31 32 33 34 35 36 61 64 66 68 81 84 85 86 87 89 91 92 94 95 96 97 98 99)) >> split(4) | # geographic
          one_of(%w(22 23 24 25 26 27 28 29 42 43 44 45 46 47 48 49 52 53 54 55 56 57 58 59)) >> split(4) | # mobile: Tele Greenland A/S
          one_of(%w(38 39)) >> split(4) | # VoIP telephony
          match(/\A(50)\d{4}\z/) >> split(4) |   #| voicemail (mobile) Tele Greenland A/S
          match(/\A(50)\d{6}\z/) >> split(3,3) | #|
          fixed(2) >> split(4)

  # Gibraltar
  country '350',
          match(/^(2[012]\d)\d+$/) >> split(5) | # fixed
          match(/^([56]\d)\d+$/) >> split(6)   | # mobile
          match(/^(8\d\d\d)$/) >> split(0)

  # Portugal.
  #
  country '351',
          match(/^([78]\d\d)\d+$/) >> split(3,3) | # Service.
          match(/^(9\d)\d+$/)  >> split(3,4)     | # Mobile.
          one_of('21', '22')   >> split(3,4)     | # Lisboa & Porto
          fixed(3)             >> split(3,3)       # 3-digit NDCs

  # Luxembourg
  #
  country '352',
          one_of('4')                   >> split(2,2,2)   | # Luxembourg City
          match(/^(2[467]\d{2})$/)      >> split(2,2,2)   | # 4-digit NDC
          match(/^(6\d[18])\d+$/)       >> split(3,3)     | # mobile
          match(/^(60\d{2})\d{8}$/)     >> split(2,2,2,2) | # mobile machine to machine
          match(/^([2-9]\d)/)           >> split(2,2,2)     # 2-digit NDC

  # country '353' # Republic of Ireland, see special file.

  country '354', none >> split(3,4) # Iceland
  country '355', trunk('0') |
                 one_of('4') >> split(4,3) | # Albania
                 match(/\A(2[24]|3[2-5]|47|5[2-5]|6[6-9]|8[2-5])\d*\z/) >> split(3,3) |
                 fixed(3) >> split(3,2)

  # Malta
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Malta
  country '356',
          match(/^([79]\d)\d+$/)  >> split(6) | # mobile
          match(/^(2\d\d\d)\d+$/) >> split(4) | # fixed line
          fixed(4)                >> split(4)   # eg. with voice mail

  # Cyprus
  # http://www.cytaglobal.com/cytaglobal/userfiles/NewNumberingPlan.pdf
  country '357', trunk('0') |
                 one_of('121','122','123') >> split(2,6) | # voicemail
                 fixed(2) >> split(6)                      # fixed & mobile

  # Finland
  #
  country '358',
          trunk('0') |
          match(/^([6-8]00)\d+$/)         >> split(3,3)   | # Service
          match(/^(4\d|50)\d+$/)          >> split(3,2,2) | # Mobile
          one_of('2','3','5','6','8','9') >> split(3,3)   | # Short NDCs
          fixed(2)                        >> split(3,3)     # 2-digit NDCs

  # Bulgaria
  #
  country '359',
          trunk('0') |
          fixed(2) >> split(3,2,2) # Bulgaria

  # Lithuania
  #
  country '370',
          trunk('8', normalize: false) |
          one_of('700', '800')  >> split(2,3)   | # Service
          match(/^(6\d\d)\d+$/) >> split(2,3)   | # Mobile
          one_of('5')           >> split(3,2,2) | # Vilnius
          one_of('37','41')     >> split(2,2,2) | # Kaunas, Šiauliai
          fixed(3)              >> split(1,2,2)   # 3-digit NDCs.

  # country '371' # Latvia, see special file

  # Estonia
  #
  country '372',
          match(/^(5\d\d\d)\d+$/)          >> split(3..4) | # Mobile
          match(/^((?:70|8[12])\d\d)\d+$/) >> split(4)    | # Mobile
          fixed(3)                         >> split(4)   # 3-digit NDCs

  # country '373' # Moldova, see special file

  country '374', match(/\A(10|55|77|9[13-9])\d*\z/) >> split(6) | # Armenia
                 fixed(3) >> split(5)

  # Belarus
  #  country '375' # see special file

  country '376', fixed(1) >> split(5) # Andorra

  # Monaco
  #
  country '377',
          one_of('6')  >> split(2,2,2,2) | # mobile
          fixed(2) >> split(2,2,2)

  # San Marino
  country '378',
          none >> matched_split(
              /\A\d{6}\z/ => [3,3],
              /\A\d+\z/ => [3,3,4]
          )

  country '379', todo # Vatican City State

  # country '380' # Ukraine, see special file

  # country '381' # Serbia, see special file

  # country '382' # Montenegro, see special file

  country '383', todo # -
  country '384', todo # -

  # country '385' # Croatia, see special file.

  # Slovenia
  # http://www.itu.int/oth/default.aspx?lang=en&parent=T02020000BE
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Slovenia
  country '386',
          trunk('0') |
          one_of('30','31','40','41','51','64','65','66','67','68','69','70','71')  >> split(3,3) | # Mobile
          one_of('1','2','3','4','5','7')  >> split(3,4) | # Ljubljana, Maribor, Celje, Kranj, Nova Gorica, Novo mesto
          fixed(3)                         >> split(2,3)   # catchall

  country '387', trunk('0') | fixed(2) >> split(3,2,2) # Bosnia and Herzegovina
  country '388', trunk('0') | fixed(2) >> split(3,2,2) # Group of countries, shared code
  country '389', trunk('0') | fixed(2) >> split(3,2,2) # The Former Yugoslav Republic of Macedonia

  country '420', fixed(3) >> split(3,3) # Czech Republic

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

  country '500', none >> split(2,3) # Falkland Islands (Malvinas) http://www.wtng.info/wtng-500-fk.html
  country '501', fixed(3) >> split(4) # Belize

  # Guatemala (Republic of) http://www.wtng.info/wtng-502-gt.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  #
  country '502',
          one_of('19') >> split(3,3,3) | # premium rate
          fixed(1) >> split(3,4)

   # El Salvador (Republic of)
  country '503', fixed(4) >> split(4,4)

  # Honduras (Republic of) http://www.wtng.info/wtng-504-hn.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  country '504',
          one_of('800') >> split(3,4) | # freephone
          fixed(2) >> split(3,3) # geographic, mobile

  # Nicaragua http://www.wtng.info/wtng-505-ni.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=NI
  country '505',
          one_of('9') >> split(3,3) | # premium rate
          fixed(2) >> split(3,3) # geographic, mobile

  # Costa Rica http://www.wtng.info/wtng-506-cr.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=CR
  country '506',
          one_of('800') >> split(3,4) | # freephone
          one_of(%w(905 909)) >> split(3,4) | # premium rate
          fixed(1) >> split(3,4) # geographic

  # Panama (Republic of) http://www.wtng.info/wtng-507-pa.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  country '507',
          one_of(%w(800 809)) >> split(4) | # freephone
          one_of('6') >> split(3,4) | # mobile
          fixed(1) >> split(3,3) # geographic, VoIP telephony, mobile, premium rate, shared cost, pager

  country '508', none >> split(3, 3) # Saint Pierre and Miquelon (Collectivité territoriale de la République française) http://www.wtng.info/wtng-508-pm.html

  country '509', # Haiti (Republic of)
    fixed(2) >> split(2,4)

  # Guadeloupe (French Department of) http://www.wtng.info/wtng-590-fr.html
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  country '590', fixed(3) >> split(3,3)

  country '591', # Bolivia (Republic of) http://www.itu.int/oth/T020200001A/en
    fixed(1) >> split(3,4)

  # Guyana http://www.wtng.info/wtng-592-gy.html
  # https://www.numberingplans.com
  country '592',
          one_of('10') >> split(2) | # audiotext
          one_of(%w(11 16 17 18 19)) >> split(3) | # audiotext
          fixed(3) >> split(4) # geographic, audiotext

  country '593', fixed(2) >> split(3, 4) # Ecuador http://www.wtng.info/wtng-593-ec.html
  country '594', fixed(3) >> split(3, 3) # French Guiana (French Department of) http://www.wtng.info/wtng-594-fr.html

  # country '595' # Paraguay (Republic of), see special file

  # Martinique (French Department of) http://www.wtng.info/wtng-596-mq.html, https://www.numberingplans.com
  country '596', fixed(3) >> split(3, 3)

  # Suriname (Republic of) http://www.wtng.info/wtng-597-sr.html, https://www.numberingplans.com
  country '597',
          none >> matched_split(
              /\A[6789]\d+\z/ => [3,4], # freephone, mobile
              /\A[2345]\d+\z/ => [3,3], # geographic, VoIP telephony
          )

  # country '598' # Uruguay (Eastern Republic of), see special file

  country '599', one_of('9') >> split(3,4) | # Netherlands Antilles (Curacao)
                 fixed(3)    >> split(4)     # (other)

  # Democratic Republic of Timor-Leste http://www.wtng.info/wtng-670-tl.html
  country '670',
          none >> matched_split(
              /\A7\d+\z/ => [4,4], # mobile
              /\A\d+\z/ => [3,4]
          )

  country '671', todo # Spare code
  country '672', todo # Australian External Territories
  country '673', fixed(1) >> split(3, 3) # Brunei Darussalam http://www.wtng.info/wtng-673-bn.html
  country '674', none >> split(3, 4) # Nauru (Republic of) http://www.wtng.info/wtng-674-nr.html

  # Papua New Guinea
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=PG
  country '675',
          one_of(%w(180 181 182 183)) >> split(4) | # freephone
          one_of('170') >> split(2) | # mobile
          one_of('189') >> split(1) | # mobile
          one_of('184') >> split(4,4) | # ISP, PSDN X.28
          one_of(%w(185 270 271)) >> split(4) | # pager
          one_of(%w(275 276)) >> split(4) | # satellite
          one_of(%w(278 279)) >> split(2) | # satellite
          one_of('115') >> split(4,4) | # voicemail (mobile)
          one_of(%w(28 29)) >> split(3,2) | # pager
          one_of(%w(16 18)) >> split(3,2) | # ISP
          one_of(%w(71 72 73 76)) >> split(3,3) | # mobile
          one_of(%w(80 81 82 83)) >> split(3,3) | # freephone
          one_of(%w(90 91 92 93)) >> split(3,3) | # geographic, ISDN
          one_of(%w(3 4 5 6 7 8 9)) >> split(3,3) # geographic
          fixed(1) >> split(3,3) # geographic

  # Tonga (Kingdom of)
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=TO
  country '676',
          none >> matched_split(
              /\A(77|78|87|88|89)\d+\z/ => [2,3,2],
              /\A\d+\z/ => [2,3]
          )

  # Solomon Islands http://www.wtng.info/wtng-677-sb.html, https://www.numberingplans.com
  country '677',
          none >> matched_split(
              /\A7\d+\z/ => [4,3], # mobile
              /\A\d+\z/ => [2,3] # freephone, geographic, mobile, VoIP telephony
          )

  # Vanuatu (Republic of) http://www.wtng.info/wtng-678-vu.html, https://www.numberingplans.com
  country '678',
          none >> matched_split(
              /\A[579]\d+\z/ => [4,3], # mobile
              /\A\d+\z/ => [2,3] # geographic, VoIP telephony
          )

  country '679', none >> split(3, 4) # Fiji (Republic of) http://www.wtng.info/wtng-679-fj.html

  country '680', none >> split(3, 4) # Palau (Republic of) http://www.wtng.info/wtng-680-pw.html
  country '681', todo # Wallis and Futuna (Territoire français d'outre-mer)
  country '682', none >> split(2,3) # Cook Islands http://www.wtng.info/wtng-682-ck.html
  country '683', none >> split(4) # Niue http://www.wtng.info/wtng-683-nu.html
  country '684', todo # -

  # Samoa (Independent State of)
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=WS
  country '685',
          none >> matched_split(
              /\A800\d+\z/ => [3,3], # freephone
              /\A830\d+\z/ => [3,3], # shared cost
              /\A60\d+\z/ => [3,3], # wireless geographic
              /\A(72|75|76|77)\d+\z/ => [3,4], # mobile
              /\A84\d+\z/ => [3,4], # wireless geographic
              /\A\d+\z/ => [2,3] # geographic
          )

  country '686', none >> split(2,3) # Kiribati (Republic of) http://www.wtng.info/wtng-686-ki.html
  country '687', none >> split(3,3) # New Caledonia (Territoire français d'outre-mer) http://www.wtng.info/wtng-687-nc.html
  country '688', none >> split(5) # Tuvalu http://www.wtng.info/wtng-688-tv.html
  country '689', none >> split(2,2,2,2) # French Polynesia (Territoire français d'outre-mer) http://www.wtng.info/wtng-689-pf.html

  country '690', fixed(1) >> split(3) # Tokelau http://www.wtng.info/wtng-690-tk.html
  country '691', none >> split(3, 4) # Micronesia (Federated States of) http://www.wtng.info/wtng-691-fm.html
  country '692', none >> split(3, 4) # Marshall Islands (Republic of the) http://www.wtng.info/wtng-692-mh.html
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

  # Democratic People's Republic of Korea
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=KP
  country '850',
          one_of(%w(191 192 193)) >> split(3,4) | # mobile
          one_of('2') >> matched_split(
              /\A\d{5}\z/ => [3,2],
              /\A\d{7}\z/ => [3,4],
              #/\A(880|881|882|883|885)\d+\z/ => [4,4,4,4],
              /\A\d+\z/ => [3,3,3]) |
          one_of(%w(31 39 41 45 53 57 61 67 73 79))  >> split(3,3) |
          fixed(2) >> split(3,3)

  country '851', todo # Spare code

  # Hong Kong, China

  country '852',
          none >> split(4,4)

  country '853', todo # Macao, China
  country '854', todo # Spare code

  # Lao People's Democratic Republic http://www.wtng.info/wtng-856-la.html, https://www.numberingplans.com
  country '856',
          one_of('30') >> split(3,4) | # geographic
          one_of('20') >> split(4,4) | # mobile
          fixed(2) >> split(3,3) # geographic

  country '857', todo # Spare code
  country '858', todo # Spare code
  country '859', todo # Spare code

  country '870', todo # Inmarsat SNAC
  country '871', todo # Inmarsat (Atlantic Ocean-East)
  country '872', todo # Inmarsat (Pacific Ocean)
  country '873', todo # Inmarsat (Indian Ocean)
  country '874', todo # Inmarsat (Atlantic Ocean-West)
  country '875', todo # Maritime Mobile Service Applications
  country '876', todo # Maritime Mobile Service Applications
  country '877', todo # Maritime Mobile Service Applications
  country '878', todo # Universal Personal Telecommunication Service (UPT)
  reserved '879' # Reserved for national non-commercial purposes

  # Bangladesh (People's Republic of)
  #  country '880' # see special file

  country '881', todo # International Mobile, shared code
  country '882', todo # International Networks, shared code
  country '883', todo # -
  country '884', todo # -
  country '885', todo # -

  # country '886' # Taiwan, see special file

  country '887', todo # -
  reserved '888' # Reserved for future global service
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

  # Maldives (Republic of) http://www.wtng.info/wtng-960-mv.html, https://www.numberingplans.com
  country '960',
          one_of(%w(800 900)) >> split(3,4) | # freephone, premium rate
          fixed(3) >> split(4) # geographic, mobile

  # Lebanon
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=LB
  country '961',
          one_of(%w(70 71 76 78 79)) >> split(3,3) | # mobile
          one_of(%w(90 91)) >> split(3,3) | # premium rate
          one_of(%w(80 81)) >> split(3,3) | # shared cost
          one_of(%w(1 4 5 6 7 8 9)) >> split(3,3) | # geographic
          one_of('3') >> split(3,3) | # mobile
          fixed(1) >> split(3,3)

  # Jordan (Hashemite Kingdom of)
  country '962',
          one_of(%w(6250 8790)) >> split(4) | # wireless geographic
          one_of(%w(800 801 802 803 804 805 806 807 808 809)) >> split(3,2) | # freephone
          one_of('810') >> split(3,2) | # ISP
          one_of('900') >> split(3,2) | # premium rate
          one_of('70') >> split(3,3) | # universal access
          one_of(%w(85 87)) >> split(3,3) | # shared cost
          one_of(%w(2 3 5 6)) >> split(3,4) | # geographic
          one_of('7') >> split(4,4) | # mobile, pager
          fixed(1) >> split(3,4)

  # Syrian Arab Republic
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=SY
  country '963',
          one_of(%w(11 14 31 33)) >> split(3,4) |
          one_of(%w(12 13 15 16 21 22 23 25 34 41 43 51 52 53)) >> split(3,3) |
          one_of('4') >> split(3,4) |
          one_of('9') >> split(4,4) | # mobile
          fixed(2) >> split(3,3)

  # Iraq (Republic of)
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=IQ
  country '964',
          one_of(%w(21 23 24 25 30 32 33 36 37 40 42 43 50 53 60 62 66)) >> split(3,3) |
          one_of(%w(71 72 73 74 75 76 77 78 79)) >> split(4,4) | # mobile
          one_of('1') >> split(3,4) |
          fixed(2) >> split(3,3)

  # Kuwait (State of) http://www.wtng.info/wtng-965-kw.html
  country '965',
          none >> matched_split(
              /\A65816\d+\z/ => [4,4,4], # voicemail (mobile), Wataniya Telecom
              /\A1\d+\z/ => [3,4], # geographic
              /\A2\d+\z/ => [4,4], # geographic
              /\A[569]\d+\z/ => [4,4], # mobile
              /\A8\d+\z/ => [3,3], # geographic
          )

  # Saudi Arabia (Kingdom of)
  # http://www.wtng.info/wtng-966-sa.html
  # http://www.citc.gov.sa/English/MediaCenter/awarenesscampaigns/Pages/PR_AWR_004.aspx
  # http://en.wikipedia.org/wiki/Telephone_numbers_in_Saudi_Arabia
  # https://answers.yahoo.com/question/index?qid=20090303142622AAQBoZ0
  country '966',
          match(/\A(5[0-9])\d+\z/) >> split(3,4) | # mobile numbers
          fixed(3) >> split(3,4)

  # Yemen (Republic of)
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  country '967',
          one_of(%w(70 71 73 77)) >> split(3,4) | # mobile
          one_of('58') >> split(4) | # pager
          one_of('1') >> matched_split(
              /\A\d{6}\z/ => [3,3],
              /\A\d+\z/ => [3,4]) |
          one_of(%w(2 3 4 5 6 7)) >> split(3,3) |
          fixed(1) >> split(3,3)

  # Oman (Sultanate of), https://www.numberingplans.com/?page=dialling&sub=areacodes
  country '968', fixed(2) >> split(3,3)

  reserved '969' # Reserved - reservation currently under investigation

  country '970', # 970 is used in those countries that block access to 972 (Israel)
          one_of('1')                            >> split(3,3,3) | # special numbers
          one_of('2', '3', '4', '8', '9')        >> split(3,4)   | # 1 digit ndc
          match(/^(5[023456789]|7[23467])\d+$/)  >> split(3,4)     # 2 digit ndc

  # United Arab Emirates
  # https://www.numberingplans.com/?page=dialling&sub=areacodes
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=AE
  country '971',
          one_of(%w(200 300)) >> split(3,3) | # shared cost
          one_of('600') >> split(3,3) | # national rate
          one_of(%w(500 700 900)) >> split(3,3) | # premium rate
          one_of('800') >> matched_split(
              /\A\d{2}\z/ => [2],
              /\A\d+\z/ => [2,3,4]) | # freephone
          one_of(%w(50 52 55 56)) >> split(3,4) | # mobile
          one_of(%w(2 3 4 6 7 9)) >> split(3,4) |
          fixed(1) >> split(3,4)

  # Israel (State of) (also works for numbers in Palestinian territories)
  country '972',
    trunk('0') |
    one_of('1')                            >> split(3,3,3) | # special numbers
    one_of('2', '3', '4', '8', '9')        >> split(3,4)   | # 1 digit ndc
    match(/^(5[023456789]|7[23467])\d+$/)  >> split(3,4)     # 2 digit ndc

  country '973', none >> split(4,4..4) # Bahrain (Kingdom of) http://www.itu.int/oth/T0202000011/en

  # Qatar (State of)
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=QA
  country '974',
          one_of(%w(1245 1744)) >> split(3,3) | # voicemail
          one_of(%w(800 900)) >> split(2,2) | # freephone, audiotext
          one_of(%w(20 21 22 26)) >> split(3,2) | # pager
          one_of(%w(92 97)) >> split(3) | # mobile
          fixed(2) >> split(3,3)

  country '975', fixed(1) >> split(3, 3) # Bhutan (Kingdom of) http://www.wtng.info/wtng-975-bt.html

  # Mongolia
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=MN
  country '976',
          one_of(%w(121 122 123 221 222 223)) >> matched_split(
              /\A\d{4}\z/ => [2,2],
              /\A\d+\z/ => [2,3]) |
          one_of(%w(11 12 13 14 15 21 22 23 24 25)) >> split(3,2) |
          one_of(%w(70 75 76 77 78 79)) >> split(3,3) | # VoIP telephony
          one_of(%w(88 89 90 91 94 95 96 99)) >> split(3,3) | # mobile
          one_of(%w(50 55 56 58 92)) >> split(3,3) | # wireless geographic
          fixed(2) >> split(3,3)

  # country '977' # Nepal, see special file

  country '978', todo # -
  country '979', todo # International Premium Rate Service (IPRS)

  country '990', todo # Spare code
  country '991', todo # Trial of a proposed new international telecommunication public correspondence service, shared code

  # country '992' # Tajikistan (Republic of), see special file

  # country '993' # Turkmenistan, see special file

  country '994', fixed(2) >> split(7) # Azerbaijani Republic

  # country '995' # Georgia, see special file

  # country '996' # Kyrgyz Republic, see special file

  country '997', todo # Spare code
  country '998', fixed(2) >> split(3, 4) # Uzbekistan (Republic of) http://www.wtng.info/wtng-998-uz.html
  reserved '999' # Reserved for possible future use within the Telecommunications for Disaster Relief (TDR) concept
end
