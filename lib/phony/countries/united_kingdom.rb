# The United Kingdom uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Note: The United Kingdom uses a variable ndc format from length 2 to 6.
#
# The UK is special in formatting in that it uses a 4-4, or 3-4 formatting rule with area
# codes that are 2 or 3 digits long, and a 6 formatting rule with area codes that are 4-6 digits long.
#
# To reflect this different formatting, we need to install all handlers in a row.
# First, the area codes of length 2, without a fallback length (since this captures all), but with a nil fallback length.
#
# TODO Implement and use length-based splitter.
#
handlers = []

area_code_2_national = Phony::NationalSplitters::Variable.new nil, [
  '20',   # London
  '23',   # Southampton, Portsmith
  '24',   # Coventry
  '28',   # Northern Ireland
  '29',   # Cardiff 
]
area_code_2_local    = Phony::LocalSplitters::Fixed.instance_for [4, 4]
handlers            << Phony::NationalCode.new(area_code_2_national, area_code_2_local)

area_code_3_national = Phony::NationalSplitters::Variable.new nil, [
  # Geographical.
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
  '800', # Freephone
  '808', # Freephone
  '842',
  '843',
  '844',
  '845', 
  '870',
  '871',
  '872',
  '873',
  '900', # Premium rate content services
  '908', # Sexual entertainment services
  '909', # Sexual entertainment services
  '982', # Sexual entertainment services
]
area_code_3_local    = Phony::LocalSplitters::Fixed.instance_for [3, 4]
handlers            << Phony::NationalCode.new(area_code_3_national, area_code_3_local)

# 6 is the fallback length.
#
area_code_45_national = Phony::NationalSplitters::Variable.new 6, [
  # Geographical.
  #
  '1204', # Bolton
  '1224', # Aberdeen
  '1244', # Chester
  '1382', # Dundee
  '1429', # Hartlepool
  '1482', # Hull
  '1527', # Redditch	
  '1582', # Luton
  '1670', # Morpeth
  '1730', # Petersfield
  '1736', # Penzance
  '1750', # Selkirk
  '1772', # Preston
  '1853', # Ullapool
  '1900', # Workington
  '1946', # Whitehaven
  '1947', # Whitby
  # Mobile.
  #
  ('7400'..'7599').to_a,
  '7624',
  ('7700'..'7999').to_a,
  # Geographical.
  #
  '13873', # Langholm
  '15242', # Hornby
  '15394', # Hawkshead
  '15395', # Grange-over-Sands
  '15396', # Sedbergh
  '16973', # Wigton
  '16974', # Raughton Head
  '16977', # Brampton[3][4]
  '17683', # Appleby
  '17684', # Pooley Bridge
  '17687', # Keswick
  '19467', # Gosforth
].flatten
area_code_45_local    = Phony::LocalSplitters::Fixed.instance_for [6]
handlers             << Phony::NationalCode.new(area_code_45_national, area_code_45_local)

Phony::Countries::UnitedKingdom = Phony::Country.new *handlers