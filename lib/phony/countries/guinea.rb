# frozen_string_literal: true

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

# NOTE We're not using *('660'..'669') since it does not freeze easily.
mobile_ndcs_with_3_digits = [
  '600', '601', '602', '603', '604', '605', '606', '607', '608', '609', # Sotelgui
  '620', '621', '622', '623', '624', '625', '626', '627', '628', '629', # Orange
  '650', '651', '652', '653', '654', '655', '656', '657', '658', '659', # Cellcom
  '630', '631', '632', '633', '634', '635', '636', '637', '638', '639', # Intercel
  '660', '661', '662', '663', '664', '665', '666', '667', '668', '669', # Areeba
]

Phony.define do
  country '224',
    one_of(land_ndcs_with_5_digits)   >> split(2, 2)    | # 2-2-2-2
    one_of(land_ndcs_with_4_digits)   >> split(2, 2)    | # 2-2-2-2
    one_of(mobile_ndcs_with_3_digits) >> split(2, 2, 2) | # 3-2-2-2
    match(/^(7\d{2})\d{6}/)           >> split(2, 2, 2) | # voip numbers
    fixed(3)                          >> split(2, 2, 2)
end
