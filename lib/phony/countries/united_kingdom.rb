# The United Kingdom uses a variable-length NDC code,
# thus we use a separate file to not let countries.rb explode.
#
# Note: The United Kingdom uses a variable NDC format from length 2 to 5.
#
# The UK is special in formatting in that it uses:
#  a 2-4-4 formatting rule with area codes that are 2 digits long,
#  a 3-3-4 or 3-6 formatting rule with area codes that are 3 digits long,
#  a 4-6 or 4-5 formatting rule with area codes that are 4 digits long, and
#  a 5-5 or 5-4 formatting rule with area codes that are 5 digits long.
# There can be a mix of number lengths within a single area code.
#

two_digit_ndc = [
  # Geographic [2+8].
  #
  '20',   # London
  '23',   # Southampton, Portsmith
  '24',   # Coventry
  '28',   # Northern Ireland
  '29',   # Cardiff

  # Non-geographic [2+8].
  #
  '55',   # Corporate
  '56',   # LIECS/VoIP
  '70',   # Personal numbers
]

# three_digit_ndc_with_nine_digits
  # Non-geographic [3+6].
  #
  # '500', # Freephone (9 digits) handled in specific rule, see below.
  # '800', # Freephone (9 digits) handled in specific rule, see below.

three_digit_ndc = [
  # Geographic [3+7].
  #
  '113',  # Leeds
  '114',  # Sheffield
  '115',  # Nottingham
  '116',  # Leicester
  '117',  # Bristol
  '118',  # Reading
  '121',  # Birmingham
  '131',  # Edinburgh
  '141',  # Glasgow
  '151',  # Liverpool
  '161',  # Manchester
  '191',  # Tyne and Wear/County Durham

  # Non-geographic [3+7].
  #
  '300', # Non-geographic numbers charged at geographic rates.
  '301',
  '302',
  '303',
  '306',
  '308',
  '309',
  '330',
  '331',
  '332',
  '333',
  '336',
  '339',
  '342',
  '343',
  '344',
  '345',
  '370',
  '371',
  '372',
  '373',

  '800', # Freephone (10 digits) # 9 digits handled in specific rule, see below.
  '808', # Freephone (10 digits)

  '842', # Non-geographic numbers (NTS) with Service Charge up to 7p/min [3+7].
  '843',
  '844',
  '845',

  '870', # Non-geographic numbers (NTS) with Service Charge up to 13p/min [3+7].
  '871',
  '872',
  '873',

  '900', # Premium Rate Services (PRS) with Service Charge up to 300p/min [3+7].
  '901',
  '902',
  '903',
  '904',
  '905',
  '906',
  '907',
  '910',
  '911',
  '912',
  '913',
  '914',
  '915',
  '916',
  '917',
  '918',
  '919',

  '908', # Sexual entertainment services (SES) with Service Charge up to 300p/min [3+7].
  '909',
  '981',
  '982',
  '983',
  '984',
  '989',
]

# five_digit_ndc_with_nine_digits
  # Geographic [5+4].
  #
  # '16977', # Brampton (contains both 4 and 5 digit numbers)
  #          # 9 digits handled in specific rule, see below.

five_digit_ndc = [
  # Geographic [5+5].
  #
  # These areas use 5-5 format. One area has some 5-4 numbers too (see above).
  # They share their initial digits with area codes using 4-6 (and 4-5).
  '13873', # Langholm
  '15242', # Hornby
  '15394', # Hawkshead
  '15395', # Grange-over-Sands
  '15396', # Sedbergh
  '16973', # Wigton
  '16974', # Raughton Head
  '16977', # Brampton (contains both 4 and 5 digit numbers)
  '17683', # Appleby
  '17684', # Pooley Bridge
  '17687', # Keswick
  '19467', # Gosforth
]

no_split = [
  # Geographic [4+6]/[4+5].
  #
  # These 40 area codes have a mix of 4-6 and 4-5 numbers
  # The three 'mixed' areas also have part of their number
  # range sub-allocated as 5-5.
  '1204', # Bolton
  '1208', # Bodmin
  '1254', # Blackburn
  '1276', # Camberley
  '1297', # Axminster
  '1298', # Buxton
  '1363', # Crediton
  '1364', # Ashburton
  '1384', # Dudley
  '1386', # Evesham
  '1404', # Honiton
  '1420', # Alton
  '1460', # Chard
  '1461', # Gretna
  '1480', # Huntingdon
  '1488', # Hungerford
  '1524', # Lancaster (Mixed area)
  '1527', # Redditch
  '1562', # Kidderminster
  '1566', # Launceston
  '1606', # Northwich
  '1629', # Matlock
  '1635', # Newbury
  '1647', # Moretonhampstead
  '1659', # Sanquhar
  '1695', # Skelmersdale
  '1726', # St Austell
  '1744', # St Helens
  '1750', # Selkirk
  '1768', # Penrith (Mixed area)
  '1827', # Tamworth
  '1837', # Okehampton
  '1884', # Tiverton
  '1900', # Workington
  '1905', # Worcester
  '1935', # Yeovil
  '1946', # Whitehaven (Mixed area)
  '1949', # Whatton
  '1963', # Wincanton
  '1995', # Garstang 

# 6 is the fallback length.
#
  # Mobile [4+6].
  #
  ('7100'..'7599').to_a,
  '7624',
  ('7700'..'7999').to_a,

  # Geographic [4+6].
  #
  # About 500 area codes use the 4-6 format
  # The three 'mixed' areas also have part of their number
  # range sub-allocated as 5-5 and one also has some 5-4.
  '1224', # Aberdeen 
  '1244', # Chester
  '1382', # Dundee
  '1387', # Dumfries (Mixed area)
  '1429', # Hartlepool
  '1482', # Hull
  '1539', # Kendal (Mixed area)
  '1582', # Luton
  '1670', # Morpeth
  '1697', # Brampton (Mixed area)
  '1730', # Petersfield
  '1736', # Penzance
  '1772', # Preston
  '1853', # Ullapool
  '1947', # Whitby
          # and 500 others
].flatten

Phony.define do
  country '44', one_of(two_digit_ndc)    >> split(4,4) | # 2-4-4
                match(/^([58]00)\d{6}$/) >> split(6)   | # Special handling for 500 and 800: 3-6 numbers.
                one_of(three_digit_ndc)  >> split(3,4) | # 3-3-4
                match(/^(16977)\d{4}$/)  >> split(4)   | # Special handling for 16977: 5-4 numbers.
                one_of(five_digit_ndc)   >> split(5)   | # 5-5
                one_of(no_split)         >> split(6)   | # 4-6 and 4-5
                fixed(4)                 >> split(6)     # Catchall for 4-6 numbers.
end