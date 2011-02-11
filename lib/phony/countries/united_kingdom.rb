# The United Kingdom uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Note: The United Kingdom uses a variable ndc format from length 2 to 4.
#
Phony::Countries::UnitedKingdom = Phony::Country.configured :local_format => [4, 6],
                                                            :local_special_format => [8],
                                                            :mobile_local_format => [6],
                                                            :ndc_fallback_length => 4,
                                                            :ndc_mapping => {
                                                              :landline => [
'20',   # London
'23',   # Southampton, Portsmith
'24',   # Coventry
'28',   # Northern Ireland
'29',   # Caridff
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
# 5 Digit prefixes
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

],
:mobile => [
'7400',
'7500',
'7600',
'7700',
'7780',
'7800',
'7900',
],
:service => [
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
}

