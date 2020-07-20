# frozen_string_literal: true

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
  '0121', # Pinerolo
  '0122', # Sestrieres, Bardonecchia and other Susa Valley mountain resorts
  '0123', # Lanzo Torinese
  '0124', # Rivarolo Canavese
  '0125', # Ivrea
  '0131', # Alessandria
  '0141', # Asti
  '0142', # Casale Monferrato
  '0143', # Novi Ligure
  '0144', # Acqui Terme
  '0161', # Vercelli
  '0163', # Borgosesia
  '0165', # Aosta, Courmayeur
  '0166', # Cervinia
  '0171', # Cuneo
  '0172', # Savigliano
  '0173', # Alba
  '0174', # Mondoví
  '0175', # Saluzzo
  '0182', # Albenga
  '0183', # Imperia
  '0184', # San Remo
  '0185', # Rapallo, Chiavari
  '0187', # La Spezia and Cinque Terre
  '0321', # Novara
  '0322', # Arona
  '0323', # Baveno
  '0324', # Domodossola
  '0331', # Busto Arsizio
  '0332', # Varese
  '0341', # Lecco
  '0342', # Sondrio
  '0343', # Chiavenna
  '0344', # Menaggio
  '0345', # San Pellegrino Terme
  '0346', # Clusone
  '0362', # Seregno
  '0363', # Treviglio
  '0364', # Breno
  '0365', # Salò
  '0369', # Mediaset Cologno Monzese and Segrate TV studios, premium rate (used for polls, television programs, etc.)
  '0371', # Lodi
  '0372', # Cremona
  '0373', # Crema
  '0374', # Soresina
  '0375', # Casalmaggiore
  '0376', # Mantua
  '0377', # Codogno
  '0381', # Vigevano
  '0382', # Pavia
  '0383', # Voghera
  '0384', # Mortara
  '0385', # Stradella
  '0386', # Ostiglia
  '0421', # San Donà di Piave
  '0422', # Treviso
  '0423', # Montebelluna
  '0424', # Bassano del Grappa
  '0425', # Rovigo
  '0426', # Adria
  '0427', # Spilimbergo
  '0428', # Tarvisio
  '0429', # Este
  '0431', # Cervignano del Friuli
  '0432', # Udine
  '0433', # Tolmezzo
  '0434', # Pordenone
  '0435', # Pieve di Cadore
  '0436', # Cortina d'Ampezzo
  '0437', # Belluno
  '0438', # Conegliano
  '0439', # Feltre
  '0442', # Legnano
  '0444', # Vicenza
  '0445', # Schio
  '0461', # Trento
  '0462', # Cavalese
  '0463', # Cles
  '0464', # Rovereto
  '0465', # Tione di Trento
  '0471', # Bolzano
  '0472', # Brixen
  '0473', # Merano
  '0474', # Bruneck
  '0481', # Gorizia
  '0521', # Parma
  '0522', # Reggio nell'Emilia
  '0523', # Piacenza
  '0524', # Fidenza
  '0525', # Fornovo di Taro
  '0532', # Ferrara
  '0533', # Comacchio
  '0534', # Porretta Terme
  '0535', # Mirandola
  '0536', # Sassuolo
  '0541', # Rimini
  '0542', # Imola
  '0543', # Forlì
  '0544', # Ravenna
  '0545', # Lugo
  '0546', # Faenza
  '0547', # Cesena
  '0549', # San Marino (Most Serene Republic of San Marino)
  '0564', # Grosseto
  '0565', # Piombino
  '0566', # Follonica
  '0571', # Empoli
  '0572', # Montecatini Terme
  '0573', # Pistoia
  '0574', # Prato
  '0575', # Arezzo
  '0577', # Siena
  '0578', # Chianciano Terme
  '0583', # Lucca
  '0584', # Viareggio
  '0585', # Massa
  '0586', # Livorno
  '0587', # Pontedera
  '0588', # Volterra
  '0721', # Province of Pesaro and Urbino
  '0722', # Province of Pesaro and Urbino
  '0731', # Jesi
  '0732', # Fabriano
  '0733', # Macerata
  '0734', # Fermo
  '0735', # San Benedetto del Tronto
  '0736', # Ascoli Piceno
  '0737', # Camerino
  '0742', # Foligno
  '0743', # Spoleto
  '0744', # Terni
  '0746', # Rieti
  '0761', # Viterbo
  '0763', # Orvieto
  '0765', # Poggio Mirteto
  '0766', # Civitavecchia
  '0769', # RAI Saxa Rubra Studios, premium rate (used for polls, television programs, etc.)
  '0771', # Formia, Fondi
  '0773', # Latina
  '0774', # Tivoli
  '0775', # Frosinone
  '0776', # Cassino
  '0781', # Iglesias
  '0782', # Lanusei
  '0783', # Oristano
  '0784', # Nuoro
  '0785', # Macomer
  '0789', # Olbia and Costa Smeralda
  '0823', # Caserta
  '0824', # Benevento
  '0825', # Avellino
  '0827', # Sant'Angelo dei Lombardi
  '0828', # Campagna
  '0831', # Brindisi
  '0832', # Lecce
  '0833', # Gallipoli
  '0835', # Matera
  '0836', # Maglie
  '0861', # Teramo
  '0862', # L'Aquila
  '0863', # Avezzano
  '0864', # Sulmona
  '0865', # Isernia
  '0871', # Chieti
  '0872', # Lanciano
  '0873', # Vasto
  '0874', # Campobasso
  '0875', # Termoli
  '0881', # Foggia
  '0882', # San Severo
  '0883', # Barletta-Andria-Trani
  '0884', # Manfredonia
  '0885', # Cerignola
  '0921', # Cefalù
  '0922', # Agrigento
  '0923', # Trapani
  '0924', # Alcamo
  '0925', # Sciacca
  '0931', # Siracusa
  '0932', # Ragusa
  '0933', # Caltagirone
  '0934', # Caltanisetta
  '0935', # Enna
  '0941', # Patti
  '0942', # Taormina
  '0961', # Catanzaro
  '0962', # Crotone
  '0963', # Vibo Valentia
  '0964', # Locri
  '0965', # Reggio di Calabria
  '0966', # Palmi
  '0967', # Soverato
  '0968', # Lamezia Terme
  '0971', # Potenza
  '0972', # Melfi
  '0973', # Lagonegro
  '0974', # Vallo della Lucania
  '0975', # Sala Consilina
  '0976', # Muro Lucano
  '0981', # Castrovillari
  '0982', # Paola
  '0983', # Rossano
  '0984', # Cosenza
  '0985', # Scalea
]

# All 3-- numbers are reserved for mobile phones according to
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Italy#Mobile_telephones
# NOTE was:
#   mobile = ('300'..'399').to_a
# but this was not frozen so easily.
mobile = %w(300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399)

service = [ # Not exhaustive.
 '112',
 '113',
 '115',
 '116',
 '117',
 '118',
 '1515',
 '1518',
 '1530'
]

Phony.define do
  country '39', trunk('', :normalize => false) |
                one_of(*service)     >> split(3,3) |
                one_of(*mobile)      >> split(3,4,-1..1) |
                one_of(*ndcs_2digit) >> split(4, 2..4) |
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
