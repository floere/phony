# The United Kingdom uses a variable-length ndc code,
# thus we use a separate file to not let all_other.rb explode.
#
# Note: The United Kingdom uses a variable ndc format from length 2 to 5.
#
# The UK is special in formatting in that it uses:
#  a 4-4 formatting rule with area codes that are 2 digits long,
#  a 3-4 formatting rule with area codes that are 3 digits long,
#  a 6 or 5 formatting rule with area codes that are 4 digits long, and
#  a 5 or 4 formatting rule with area codes that are 5 digits long.
#
# To reflect this different formatting, we need to install all handlers in a row.
# First, the area codes of length 2, without a fallback length (since this
# captures all), but with a nil fallback length.
#
# TODO Implement and use length-based splitter.
#

two_digit_ndc = [
  '20',   # London
  '23',   # Southampton, Portsmith
  '24',   # Coventry
  '28',   # Northern Ireland
  '29',   # Cardiff
  '55',   # Corporate
  '56',   # LIECS/VoIP
  '70',   # Personal numbers
]

three_digit_ndc = [
  # Geographic.
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
  '171',  # Used for inner London until 2000
  '181',  # Used for outer London until 2000
  '191',  # Tyne and Wear/County Durham

  # Services.
  #
  '300', # Non-geographic charged at same rate as 01
  '301',
  '303',
  '308',
  '309',
  '330',
  '331',
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

  '800', # Freephone (9 or 10 digits)
  '808', # Freephone (10 digits)

  '842', # Business rate
  '843',
  '844',
  '845',
  '870',

  '871', # Premium rate
  '872',
  '873',

  '900', # Premium rate content services
  '901',
  '902',
  '903',
  '904',
  '905',
  '906',
  '907',

  '908', # Sexual entertainment services
  '909', # Sexual entertainment services
  '982', # Sexual entertainment services
]

# 6 is the fallback length.
#
no_split = [
  '500', # Freephone (9 digits)

  # Geographic.
  #
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

  # Geographic.
  #
  '1224', # Aberdeen 
  '1244', # Chester
  '1382', # Dundee
  '1429', # Hartlepool
  '1482', # Hull
  '1582', # Luton
  '1670', # Morpeth
  '1730', # Petersfield
  '1736', # Penzance
  '1772', # Preston
  '1853', # Ullapool
  '1947', # Whitby
          # and 500 others

  # Mobile.
  #
  ('7400'..'7599').to_a,
  '7624',
  ('7700'..'7999').to_a,

  # Geographic.
  #
  # Note: We could remove these and use fixed(5) >> split(5)
  #       for this as a catchall (see sweden.rb).
  #
  '13873', # Langholm
  '15242', # Hornby
  '15394', # Hawkshead
  '15395', # Grange-over-Sands
  '15396', # Sedbergh
  '16973', # Wigton
  '16974', # Raughton Head
  '16977', # Brampton
  '17683', # Appleby
  '17684', # Pooley Bridge
  '17687', # Keswick
  '19467', # Gosforth
].flatten

#  '16977', # Brampton -- TODO 016977 + 4 digits for 169772 and 169773

Phony.define do
  country '44', one_of(two_digit_ndc)   >> split(4,4) |
                one_of(three_digit_ndc) >> split(3,4) |
                one_of(no_split)        >> split(6)
end