# Italian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Italy
#

ndcs_2digit = [
  '02', # Milan
  '06', # Rome (including State of Vatican City) and Aprilia
]

ndcs_3digit = [
 '010', # Genoa
 '011', # Turin
 '015', # Biella
 '019', # Savona
 '030', # Brescia
 '031', # Como
 '035', # Bergamo
 '039', # Monza
 '040', # Trieste
 '041', # Venice
 '045', # Verona
 '049', # Padua
 '050', # Pisa
 '051', # Bologna
 '055', # Florence
 '059', # Modena
 '070', # Cagliari
 '071', # Ancona
 '075', # Perugia
 '079', # Sassari
 '080', # Bari
 '081', # Naples
 '085', # Pescara
 '089', # Salerno
 '090', # Messina
 '091', # Palermo
 '092', # Agrigento
 '095', # Catania
 '099', # Taranto
]

ndcs_4digit = [
  '0122', # Sestrieres, Bardonecchia and other Susa Valley mountain resorts
  '0125', # Ivrea
  '0131', # Alessandria
  '0141', # Asti
  '0161', # Vercelli
  '0165', # Aosta, Courmayeur
  '0166', # Cervinia
  '0171', # Cuneo
  '0185', # Tigullio
  '0187', # La Spezia and Cinque Terre
  '0321', # Novara
  '0331', # Varese
  '0341', # Lecco
  '0342', # Sondrio
  '0369', # Mediaset Cologno Monzese and Segrate TV studios, geographical rate (used for polls, television programs, etc.)
  '0376', # Mantua
  '0382', # Pavia
  '0425', # Rovigo
  '0432', # Udine
  '0444', # Vicenza
  '0461', # Trento
  '0471', # Bolzano
  '0481', # Gorizia
  '0521', # Parma
  '0522', # Reggio nell'Emilia
  '0523', # Piacenza
  '0532', # Ferrara
  '0536', # Sassuolo
  '0541', # Rimini
  '0549', # San Marino (Most Serene Republic of San Marino)
  '0573', # Pistoia
  '0577', # Siena
  '0586', # Livorno
  '0769', # RAI Saxa Rubra Studios, geographical rate (used for polls, television programs, etc.)
  '0771', # Fondi
  '0773', # Latina
  '0775', # Frosinone
  '0789', # Olbia and Costa Smeralda
  '0823', # Caserta
  '0824', # Benevento
  '0825', # Avellino
  '0865', # Isernia
  '0871', # Chieti
  '0872', # Lanciano
  '0873', # Vasto
  '0874', # Campobasso
  '0875', # Termoli
  '0881', # Foggia
  '0961', # Catanzaro
  '0965', # Reggio di Calabria
  '0971', # Potenza
]

# All 3-- numbers are reserved for mobile phones according to
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Italy#Mobile_telephones
mobile = (300..399).collect(&:to_s).to_a

service = [ # Not exhaustive.
 '112',
 '113',
 '115',
 '117',
 '118',
 '1515',
 '1518',
 '1530'
]

Phony.define do
  country '39', trunk('0', :normalize => false) |
                one_of(*service)     >> split(3,3) |
                one_of(*mobile)      >> split(3,4,-1..1) |
                one_of(*ndcs_2digit) >> split(4,4) |
                one_of(*ndcs_3digit) >> matched_split(
                  /^1\d{6}$/ => [7],
                  /^1\d{7}$/ => [8],
                  /^[^1]\d{5}$/ => [6],
                  /^[^1]\d{6}$/ => [7]
                ) |
                one_of(*ndcs_4digit) >> matched_split(
                /^1\d{5}$/ => [6],
                /^1\d{6}$/ => [7],
                /^[^1]\d{4}$/ => [5],
                /^[^1]\d{5}$/ => [3,3]
                )
end
