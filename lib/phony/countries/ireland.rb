# The Republic of Ireland has variable-length NDCs from 2-3 digits in length.  Depending on the NDC, the length of the subscriber number varies from 5-7 characters in length.  There does not appear to be any pattern that relates NDCs to subscriber number length.
#
# 7 digit subscriber numbers follow a 3-4 split pattern.
# 5 and 6 digit subscriber numbers appear split in some examples, and not in others; to be conservative, these are not currently split.  
#
# For NDCs that are not recognized, we fall back to not attempting to split out an NDC at all. 
#
# References:
# http://www.comreg.ie/_fileupload/publications/ComReg03147.pdf
# http://en.wikipedia.org/wiki/Telephone_numbers_in_the_Republic_of_Ireland
#
ndcs_with_5_subscriber_digits = [
  ('22'..'29').to_a, # Mallow, Bandon, Youghal, Fermoy, Macroom, Bantry, Skibbereen, Kanturk
  '402',  # Arklow
  '404',  # Wicklow
  '43',   # Longford, Granard
  '44',   # Mullingar, Castlepollard, Tyrellspass
  '47',   # Monaghan, Clones
  '48',   # Northern Ireland
  '502',  # Portlaoise, Abbeyleix
  '504',  # Thurles
  '505',  # Roscrea
  '506',  # Tullamore
  '509',  # Bin-
  ('52'..'55').to_a, # Killenaule, Wexford, Enniscorthy, Ferns, Gorey
  '62',   # Tipperary, Cashel
  '63',   # Charleville
  '64',   # Killarney, Rathmore
  '67',   # Nenagh
  '68',   # Listowel
  '69',   # Newcastle West
  '93',   # Tuam
  ('94'..'99').to_a # Castlebar, Castlerea, Claremorris, Clifden, Ballina, Belmullet, Westport, Kilronan
].flatten

ndcs_with_6_subscriber_digits = [
  '45',  # Naas, Kildare, Curragh
  '51',  # Waterford, Carrick-on-Suir, New Ross, Kilmacthomas
  '61',  # Limerick, Scariff
  '91',  # Galway, GOrt, Loughrea
]

ndcs_with_7_subscriber_digits = [
  '1',  # Dublin
  '21', # Cork, Coachford, Kinsale
  '41', # Ardee
  '42', # Dundalk, Carrickmacross, Castleblaney
  '46', # Navan, Kells, Trim, Enfield, Edenderry
  '49', # Cavan, Cootehill, Oldcastle, Belturbet
  '56', # Kilkenny, Castlecomer
  '58', # Dungarvan
  '59', # Carlow, Muine Bheag, Athy, Baltinglass
  '65', # Ennistymon, Kilrush
  '66', # Tralee, Dingle, Killorglin, Cahirciveen
  '71', # Sligo, Manorhamilton, Carrick-on-Shannon
  '74', # Donegal, Letterkenny, Dungloe, Buncrana
  '76', # VoIP
  '90', # Athlone, Ballinasloe, Portumna, Roscommon
  '94'  # Ballinrobe
]

freefone = [
  '800'
]

Phony.define do
  country '353', trunk('0') |
                 one_of(ndcs_with_7_subscriber_digits)   >> split(3,4) |
                 one_of(ndcs_with_5_subscriber_digits)   >> split(5)   |
                 one_of(ndcs_with_6_subscriber_digits)   >> split(6)   |
                 one_of(freefone)                        >> split(6)   |
                 match(/^(8\d).+$/)                      >> split(3,4) | # mobile
                 fixed(3)                                >> split(6)     # Fallback

end
