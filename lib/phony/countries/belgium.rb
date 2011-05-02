# Belgium uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Taken from: http://en.wikipedia.org/wiki/Telephone_numbers_in_Belgium
#
ndcs = [
 '2', # Brussels (Bruxelles/Brussel)
 '3', # Antwerpen (Antwerp), Sint-Niklaas
 '4', # Liège (Luik), Voeren (Fourons)
 '9', # Gent (Ghent/Gand)
 '15',# Mechelen
 '16',# Leuven
 '67',# Ath
 '53',# Aalst
 '63',# Arlon
 '50',# Brugge
 '71',# Charleroi
 '60',# Chimay
 '83',# Ciney
 '52',# Dendermonde
 '13',# Diest
 '82',# Dinant
 '86',# Durbuy
 '89',# Genk
 '11',# Hasselt
 '14',# Herentals
 '85',# Huy (Hoei)
 '57',# Ieper
 '56',# Kortrijk
 '64',# La Louvière
 '61',# Libramont
 '65',# Mons (Bergen)
 '81',# Namur (Namen)
 '58',# Nieuwpoort
 '54',# Ninove
 '67',# Nivelles (Nijvel)
 '59',# Oostende
 '51',# Roeselare
 '55',# Ronse
 '80',# Stavelot
 '12',# Tongeren
 '69',# Tounai
 '14',# Turnhout
 '87',# Verviers
 '58',# Veurne
 '19',# Wareme
 '10',# Wavre (Waver)
 '50',# Zeebrugge
]

mobile_regex = /^(4[789]\d)\d{6}$/ # Mobistar, Base, Proximus

service = [
  '70', # Specialty numbers, i.e. bus information or bank information
 '800', # Tollfree
 '900', # Premium
 '901', # Premium
 '902', # Premium
 '903', # Premium
 '904', # Premium
 '905', # Premium
 '906', # Premium
 '907', # Premium
 '908', # Premium
 '909'  # Premium
]

Phony.define do
  country '32', one_of(service)                >> split(3,3) |
                match(mobile_regex)            >> split(6)   |
                one_of(ndcs, :max_length => 2) >> split(3,5)
end