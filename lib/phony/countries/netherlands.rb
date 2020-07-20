# frozen_string_literal: true

# The Netherlands use a variable-length ndc code, thus we use a separate file to not let all_other.rb explode. The
# latest version of the numbering plan is available at http://wetten.overheid.nl/BWBR0010198/
#
# Note: The netherlands use a variable ndc format from length 2 to 3.
#       To save space, we only use ndcs of length 2 (and use the fallback of 3 to handle the rest).
#
ndcs = [
  '10', # Rotterdam
  '13', # Tilburg
  '14', # KPN
  '15', # Delft
  '20', # Amsterdam
  '23', # Haarlem
  '24', # Nijmegen
  '26', # Arnhem
  '30', # Utrecht
  '33', # Amersfoort
  '35', # Hilversum
  '36', # Almere
  '38', # Zwolle
  '40', # Eindhoven
  '43', # Maastricht
  '45', # Heerlen
  '46', # Sittard
  '50', # Groningen
  '53', # Enschede
  '55', # Apeldoorn
  '58', # Leeuwarden
  '70', # Den Haag
  '71', # Leiden
  '72', # Alkmaar
  '73', # 's-Hertogenbosch
  '74', # Hengelo
  '75', # Zaanstad
  '76', # Breda
  '77', # Venlo
  '78', # Dordrecht
  '79', # Zoetermeer
 ]

service = [
  '84',  # Persoonlijke-assistentdiensten, zoals voicemail en faxmail
  '85',  # Plaatsonafhankelijk netnummer
  '87',  # Both of the above.
  '88',  # Bedrijfsnummers
  '91',  # Plaatsonafhankelijk netnummer
]

service3 = [
  '676', # Inbelnummers van Internetproviders
  '800', # Gratis informatienummers
  '900', # Betaalde informatienummers
  '906', # Betaalde informatienummers
  '909', # Betaalde informatienummers
 ]

Phony.define do
  country '31',
    trunk('0', :normalize => true)                |
    match(/\A(97[0,9])\d{8}\z/) >> split(4,4)     | # machine-to-machine
    one_of(service)             >> split(4,3)     |
    match(/\A(800|900)\d{4}\z/) >> split(4)       |
    one_of(service3)            >> split(4,3)     |
    one_of('6')                 >> split(2,2,2,2) | # mobile
    one_of(ndcs)                >> split(3,4)     | # landline (geographic region)
    fixed(3)                    >> split(3,3)       # 3 digit ndc
end
