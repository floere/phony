# Italian phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Italy
#
Phony::Countries::Italy = Phony::Country.configured :local_format => [3, 4],
  :local_special_format => [3, 3],
  :normalize => false,
  :ndc_fallback_length => 3,
  :ndc_mapping => {
    :landline => [
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
       '02', # Milan
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
       '06', # Rome (including State of Vatican City) and Aprilia
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
     ],
    :mobile => [
     '310',
     '31100',
     '31101',
     '31102',
     '31103',
     '31104',
     '31105',
     '313',
     '319',
     ('3200'..'3209').to_a,
     '322',
     ('3230'..'3239').to_a,
     ('3270'..'3279').to_a,
     ('3280'..'3289').to_a,
     ('3290'..'3299').to_a,
     ('3300'..'3309').to_a,
     '331',
     ('3330'..'3339').to_a,
     ('3340'..'3349').to_a,
     ('3350'..'3359').to_a,
     ('3360'..'3369').to_a,
     ('3370'..'3379').to_a,
     ('3380'..'3389').to_a,
     ('3390'..'3399').to_a,
     ('3400'..'3409').to_a,
     '341',
     ('3430'..'3439').to_a,
     '345',
     ('3460'..'3469').to_a,
     ('3470'..'3479').to_a,
     ('3480'..'3489').to_a,
     ('3490'..'3499').to_a,
     '350',
     ('3600'..'3609').to_a,
     '361',
     '362',
     ('3630'..'3639').to_a,
     ('3660'..'3669').to_a,
     ('3680'..'3689').to_a,
     '370',
     '373',
     '377',
     ('3800'..'3809').to_a,
     ('3880'..'3889').to_a,
     ('3890'..'3899').to_a,
     ('3900'..'3909').to_a,
     ('3910'..'3919').to_a,
     ('3920'..'3929').to_a,
     ('3930'..'3939').to_a,
     '397'
     ].flatten,
    :service => [ # Not exhaustive.
      '112',
      '113',
      '115',
      '117',
      '118',
      '1515',
      '1518',
      '1530'
    ]
  }
