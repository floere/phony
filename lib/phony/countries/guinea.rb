# Guinea (sometimes Guinea-Conakry; officially Republic of Guinea)
# http://www.itu.int/oth/T020200005B/en

land_ndcs_with_4_digits = [
  '3031', # Boké
  '3046', # Boussoura
  *['3041', '3043', '3045', '3047'], # Conakry
  '3069', # Delaba
  '3081', # Faranah
  '3024', # Fria
  '3097', # Guéckédou
  '3032', # Kamsar
  '3071', # Kankan
  '3061', # Kindia
  '3098', # Kissidougou
  '3051', # Labé
  '3094', # Macenta
  '3068', # Mamou
  '3091', # N'Zérékoré
  '3053', # Pita
  '3042'  # Sangoya
]

land_ndcs_with_5_digits = [
  '30613' # Télimélé
]

mobile_ndcs_with_3_digits = [
  *('660'..'669').to_a, # Areeba
  *('620'..'629').to_a, # Orange
  *('650'..'659').to_a, # Cellcom
  *('630'..'639').to_a, # Intercel
  *('600'..'609').to_a  # Sotelgui
]

Phony.define do
  country '224',
    one_of(land_ndcs_with_5_digits)   >> split(2, 2)    | # 2-2-2-2
    one_of(land_ndcs_with_4_digits)   >> split(2, 2)    | # 2-2-2-2
    one_of(mobile_ndcs_with_3_digits) >> split(2, 2, 2) | # 3-2-2-2
    match(/^(7\d{2})\d{6}/)           >> split(2, 2, 2) | # voip numbers
    none                              >> split(2, 2, 2)
end
