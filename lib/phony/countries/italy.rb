# Italian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Italy
#
Phony::Countries::Italy = Phony::Country.configured :local_format => [3, 4],
  :local_special_format => [3, 3],
  :ndc_fallback_length => 3,
  :ndc_mapping => {
    :landline => [
                   '10', # Genoa
                   '11', # Turin
                  '122', # Sestrieres, Bardonecchia and other Susa Valley mountain resorts
                  '125', # Ivrea
                  '131', # Alessandria
                  '141', # Asti
                   '15', # Biella
                  '161', # Vercelli
                  '165', # Aosta, Courmayeur
                  '166', # Cervinia
                  '171', # Cuneo 
                  '185', # Tigullio
                  '187', # La Spezia and Cinque Terre
                   '19', # Savona
                    '2', # Milan
                   '30', # Brescia
                   '31', # Como
                  '321', # Novara
                  '331', # Varese
                  '341', # Lecco
                  '342', # Sondrio
                   '35', # Bergamo
                  '369', # Mediaset Cologno Monzese and Segrate TV studios, geographical rate (used for polls, television programs, etc.)
                  '376', # Mantua
                  '382', # Pavia
                   '39', # Monza
                   '40', # Trieste
                   '41', # Venice
                  '425', # Rovigo
                  '432', # Udine
                  '444', # Vicenza
                   '45', # Verona
                  '461', # Trento
                  '471', # Bolzano
                  '481', # Gorizia
                   '49', # Padua
                   '50', # Pisa
                   '51', # Bologna
                  '521', # Parma
                  '522', # Reggio nell'Emilia
                  '523', # Piacenza
                  '532', # Ferrara
                  '536', # Sassuolo
                  '541', # Rimini
                  '549', # San Marino (Most Serene Republic of San Marino)
                   '55', # Florence
                  '573', # Pistoia
                  '577', # Siena
                  '586', # Livorno
                   '59', # Modena
                    '6', # Rome (including State of Vatican City) and Aprilia
                   '70', # Cagliari
                   '71', # Ancona
                   '75', # Perugia
                  '769', # RAI Saxa Rubra Studios, geographical rate (used for polls, television programs, etc.)
                  '771', # Fondi
                  '773', # Latina
                  '775', # Frosinone
                  '789', # Olbia and Costa Smeralda 
                   '79', # Sassari
                   '80', # Bari
                   '81', # Naples
                  '823', # Caserta
                  '824', # Benevento
                  '825', # Avellino 
                   '85', # Pescara
                  '865', # Isernia 
                  '871', # Chieti
                  '872', # Lanciano
                  '873', # Vasto
                  '874', # Campobasso 
                  '875', # Termoli
                  '881', # Foggia
                   '89', # Salerno 
                   '90', # Messina
                   '91', # Palermo
                   '92', # Agrigento
                   '95', # Catania
                  '961', # Catanzaro 
                  '965', # Reggio di Calabria
                  '971', # Potenza
                   '99', # Taranto
                  ],
    :mobile => [], # TODO
    :service => [ # Not exhaustive.
                  '112',
                  '113',
                  '115',
                  '117',
                  '118',
                  '878',
                  '1515',
                  '1518',
                  '1530'
                ]
  }