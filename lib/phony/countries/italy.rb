# Italian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Italy
#

ndcs_2digit = [
   '02', # Milan
   '06', # Rome (including State of Vatican City) and Aprilia
]

ndcs = [
  '010', # Genoa
  '011', # Turin
 '0122', # Sestrieres, Bardonecchia and other Susa Valley mountain resorts
 '0125', # Ivrea
 '0131', # Alessandria
 '0141', # Asti
  '015', # Biella
 '0161', # Vercelli
 '0165', # Aosta, Courmayeur
 '0166', # Cervinia
 '0171', # Cuneo
 '0185', # Tigullio
 '0187', # La Spezia and Cinque Terre
  '019', # Savona
  '030', # Brescia
  '031', # Como
 '0321', # Novara
 '0331', # Varese
 '0341', # Lecco
 '0342', # Sondrio
  '035', # Bergamo
 '0369', # Mediaset Cologno Monzese and Segrate TV studios, geographical rate (used for polls, television programs, etc.)
 '0376', # Mantua
 '0382', # Pavia
  '039', # Monza
  '040', # Trieste
  '041', # Venice
 '0425', # Rovigo
 '0432', # Udine
 '0444', # Vicenza
  '045', # Verona
 '0461', # Trento
 '0471', # Bolzano
 '0481', # Gorizia
  '049', # Padua
  '050', # Pisa
  '051', # Bologna
 '0521', # Parma
 '0522', # Reggio nell'Emilia
 '0523', # Piacenza
 '0532', # Ferrara
 '0536', # Sassuolo
 '0541', # Rimini
 '0549', # San Marino (Most Serene Republic of San Marino)
  '055', # Florence
 '0573', # Pistoia
 '0577', # Siena
 '0586', # Livorno
  '059', # Modena
  '070', # Cagliari
  '071', # Ancona
  '075', # Perugia
 '0769', # RAI Saxa Rubra Studios, geographical rate (used for polls, television programs, etc.)
 '0771', # Fondi
 '0773', # Latina
 '0775', # Frosinone
 '0789', # Olbia and Costa Smeralda
  '079', # Sassari
  '080', # Bari
  '081', # Naples
 '0823', # Caserta
 '0824', # Benevento
 '0825', # Avellino
  '085', # Pescara
 '0865', # Isernia
 '0871', # Chieti
 '0872', # Lanciano
 '0873', # Vasto
 '0874', # Campobasso
 '0875', # Termoli
 '0881', # Foggia
  '089', # Salerno
  '090', # Messina
  '091', # Palermo
  '092', # Agrigento
  '095', # Catania
 '0961', # Catanzaro
 '0965', # Reggio di Calabria
 '0971', # Potenza
  '099', # Taranto
 ]


mobile = [
 '310',
 '311',
 '313',
 '319',
 '320',
 '322',
 '323',
 '327',
 '328',
 '329',
 '330',
 '331',
 '333',
 '334',
 '335',
 '336',
 '337',
 '338',
 '339',
 '340',
 '341',
 '343',
 '345',
 '346',
 '347',
 '348',
 '349',
 '350',
 '360',
 '361',
 '362',
 '363',
 '366',
 '368',
 '370',
 '373',
 '377',
 '380',
 '388',
 '389',
 '390',
 '391',
 '392',
 '393',
 '397'
]

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
  country '39', one_of(*service)                >> trunk('0', normalize: false) >> split(3,3) |
                one_of(*mobile)                 >> trunk('0', normalize: false) >> split(3,4) |
                one_of(*ndcs_2digit)            >> trunk('0', normalize: false) >> split(4,4) |
                one_of(*ndcs, :max_length => 3) >> trunk('0', normalize: false) >> split(3,4)
end
