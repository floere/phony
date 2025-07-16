# frozen_string_literal: true

# Sweden uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
# Note: Sweden use a variable ndc format with length 1 to 3.
#
# Taken from: https://pts.se/globalassets/globala-block/nummertillstand/the-swedish-numbering-plan-for-telephony-according-to-itu---2024-01-08.pdf
#             https://nummer.pts.se/NbrPlanSearch
#             https://www.sosalarm.se/en/112-and-other-important-numbers/important-phone-numbers/

regional_ndcs_1 = [
  '8' # Stockholm
]

regional_ndcs_2 = [
  '11', # Norrköping
  '13', # Linköping
  '16', # Eskilstuna-Torshälla
  '21', # Västerås
  '23', # Falun
  '26', # Gävle-Sandviken
  '33', # Borås
  '35', # Halmstad
  '36', # Jönköping-Huskvarna
  '40', # Malmö
  '42', # Helsingborg-Höganäs
  '44', # Kristianstad
  '46', # Lund
  '60', # Sundsvall-Timrå
  '63', # Östersund
  '90' # Umeå; NB: Conflicts with 900 (Premium cost services)
]

large_regional_ndcs_2 = [
  '18', # Uppsala
  '19', # Örebro-Kumla
  '31', # Göteborg
  '54' # Karlstad
]

regional_ndcs_3 = [
  '120', # Åtvidaberg
  '121', # Söderköping
  '122', # Finspång
  '123', # Valdemarsvik
  '125', # Vikbolandet
  '140', # Tranås
  '141', # Motala
  '142', # Mjöby-Skänninge-Boxholm
  '143', # Vadstena
  '144', # Ödeshög
  '150', # Katrineholm
  '151', # Vingåker
  '152', # Strängnäs
  '155', # Nyköping-Oxelösund
  '156', # Trosa-Vagnhärad
  '157', # Flen Malmköping
  '158', # Gnesta
  '159', # Mariefred
  '171', # Enköping
  '173', # Öregrund-Östhammar
  '174', # Alunda
  '175', # Hallstavik-Rimbo
  '176', # Norrtälje
  '220', # Hallstahammar-Surahammar
  '221', # Köping
  '222', # Skinnskatteberg
  '223', # Fagersta-Norberg
  '224', # Sala-Heby
  '225', # Hedemora-Säter
  '226', # Avesta-Krylbo
  '227', # Kungsör
  '240', # Ludvika-Smedjebacken
  '241', # Gagnef-Floda
  '243', # Borlänge
  '246', # Svärdsjö-Enviken
  '247', # Leksand-Insjön
  '248', # Rättvik
  '250', # Mora-Orsa
  '251', # Älvdalen
  '253', # Idre-Särna
  '258', # Furudal
  '270', # Söderhamn
  '271', # Alfta-Edsbyn
  '278', # Bollnäs
  '280', # Malung
  '281', # Vansbro
  '290', # Hofors-Storvik
  '291', # Hedesunda-Österfärnebo
  '292', # Tärnsjö-Östervåla
  '293', # Tierp-Söderfors
  '294', # Karlholmsbruk-Skärplinge
  '295', # Örbyhus-Dannemora
  '297', # Ockelbo-Hamrånge
  '300', # Kungsbacka
  '301', # Hindås
  '302', # Lerum
  '303', # Kungälv
  '304', # Orust-Tjörn
  '320', # Kinna
  '321', # Ulricehamn
  '322', # Alingsås-Vårgårda
  '325', # Svenljunga-Tranemo
  '340', # Varberg
  '345', # Hyltebruk-Torup
  '346', # Falkenberg
  '370', # Värnamo
  '371', # Gislaved-Anderstorp
  '372', # Ljungby
  '380', # Nässjö
  '381', # Eksjö
  '382', # Sävsjö
  '383', # Vetlanda
  '390', # Gränna
  '392', # Mullsjö
  '393', # Vaggeryd
  '410', # Trelleborg
  '411', # Ystad
  '413', # Eslöv-Höör
  '414', # Simrishamn
  '415', # Hörby
  '416', # Sjöbo
  '417', # Tomelilla
  '418', # Landskrona-Svalöv
  '430', # Laholm
  '431', # Ängelholm-Båstad
  '433', # Markaryd-Strömsnäsbruk
  '435', # Klippan-Perstorp
  '451', # Hässleholm
  '454', # Karlshamn-Olofström
  '455', # Karlskrona
  '456', # Sölvesborg-Bromölla
  '457', # Ronneby
  '459', # Ryd
  '470', # Växjö
  '471', # Emmaboda
  '472', # Alvesta-Rydaholm
  '474', # Åseda-Lenhovda
  '476', # Älmhult
  '477', # Tingsryd
  '478', # Lessebo
  '479', # Osby
  '480', # Kalmar
  '481', # Nybro
  '485', # Öland
  '486', # Torsås
  '490', # Västervik
  '491', # Oskarshamn-Högsby
  '492', # Vimmerby
  '493', # Gamleby
  '494', # Kisa
  '495', # Hultsfred-Virserum
  '496', # Mariannelund
  '498', # Gotland
  '499', # Mönsterås
  '500', # Skövde
  '501', # Mariestad
  '502', # Tidaholm
  '503', # Hjo
  '504', # Tibro
  '505', # Karlsborg
  '506', # Töreboda-Hova
  '510', # Lidköping
  '511', # Skara-Götene
  '512', # Vara-Nossebro
  '513', # Herrljunga
  '514', # Grästorp
  '515', # Falköping
  '520', # Trollhättan
  '521', # Vänerborg
  '522', # Uddevalla
  '523', # Lysekil
  '524', # Munkedal
  '525', # Grebbestad
  '526', # Strömstad
  '528', # Färgelanda
  '530', # Mellerud
  '531', # Bengtsfors
  '532', # Åmål
  '533', # Säffle
  '534', # Ed
  '550', # Kristinehamn
  '551', # Gullspång
  '552', # Deje
  '553', # Molkom
  '554', # Kil
  '555', # Grums
  '560', # Torsby
  '563', # Hagfors-Munkfors
  '564', # Sysslebäck
  '565', # Sunne
  '570', # Arvika
  '571', # Charlottenberg-Åmotfors
  '573', # Årjäng
  '580', # Kopparberg
  '581', # Lindesberg
  '582', # Hallsberg
  '583', # Askersund
  '584', # Laxå
  '585', # Fjugesta-Svartå
  '586', # Karlskoga-Degerfors
  '587', # Nora
  '589', # Arboga
  '590', # Filipstad
  '591', # Hällefors-Grythyttan
  '611', # Härnösand
  '612', # Kramfors
  '613', # Ullånger
  '620', # Sollefteå
  '621', # Junsele
  '622', # Näsåker
  '623', # Ramsele
  '624', # Backe
  '640', # Krokom
  '642', # Lit
  '643', # Hallen-Oviken
  '644', # Hammerdal
  '645', # Föllinge
  '647', # Åre-Järpen
  '650', # Hudiksvall
  '651', # Ljusdal
  '652', # Bergsjö
  '653', # Delsbo
  '657', # Los
  '660', # Örnsköldsvik
  '661', # Bredbyn
  '662', # Björna
  '663', # Husum
  '670', # Strömsund
  '671', # Hoting
  '672', # Gäddede
  '680', # Sveg
  '682', # Rätan
  '684', # Hede-Funäsdalen
  '687', # Svenstavik
  '690', # Ånge
  '691', # Torpshammar
  '692', # Liden
  '693', # Bräcke-Gällö
  '695', # Stugun
  '696', # Hammarstrand
  '910', # Skellefteå
  '911', # Piteå
  '912', # Byske
  '913', # Lövånger
  '914', # Burträsk
  '915', # Bastuträsk
  '916', # Jörn
  '918', # Norsjö
  '920', # Luleå
  '921', # Boden
  '922', # Haparanda
  '923', # Kalix
  '924', # Råneå
  '925', # Lakaträsk
  '926', # Överkalix
  '927', # Övertorneå
  '928', # Harads
  '929', # Älvsbyn
  '930', # Nordmaling
  '932', # Bjurholm
  '933', # Vindeln
  '934', # Robertsfors
  '935', # Vännäs
  '940', # Vilhelmina
  '941', # Åsele
  '942', # Dorotea
  '943', # Fredrika
  '950', # Lycksele
  '951', # Storuman
  '952', # Sorsele
  '953', # Malå
  '954', # Tärnaby
  '960', # Arvidsjaur
  '961', # Arjeplog
  '970', # Gällivare
  '971', # Jokkmokk
  '973', # Porjus
  '975', # Hakkas
  '976', # Vuollerim
  '977', # Korpilombolo
  '978', # Pajala
  '980', # Kiruna
  '981' # Vittangi
]

location_independent_ndcs = [
  '10', # Location independent services (VoIP)
  '70', # Mobile telephony services
  '72', # Mobile telephony services
  '73', # Mobile telephony services
  '74', # Paging services
  '75', # Personal numbering services
  '76', # Mobile telephony services
  '77', # Shared cost services
  '79' # Mobile telephony services
]

service_ndcs = [
  '20', # Toll-free services
  '900', # Premium cost services; NB: Conflicts with 90 (Umeå)
  '939', # Premium cost services
  '944' # Premium cost services
]

mobile_telematic_service_ndcs = ['71']
fixed_telematic_service_ndcs = ['378']
operator_specific_ndcs = ['78']
mass_call_service_ndcs = ['99']
routing_ndcs = [
  '252', # Routing address - Assigned to Tele2 Sverige AB
  '254', # Routing address – Assigned to Tele2 Sverige AB
  '255', # Routing address – Assigned to Telenor Sverige AB
  '673', # Routing address – Assigned to TeliaSonera Sverige AB
  '674', # Routing address – Assigned to Telenor Sverige AB
  '675', # Routing address – Assigned to Hi3G Access AB
  '676', # Routing address – Assigned to Spring Mobil AB
  '678' # Routing address – Assigned to Götalandsnätet AB
]

misc_ndcs = [
  '649', # Routing address – Assigned to Eniro 118118 AB
  '655', # Sample number (national use)
  '656', # Sample number (national use)
  '958' # Routing address – Assigned to TeliaSonera Sverige AB
]

services = [
  '112', # For emergencies when there is a danger to life, property, or the environment
  '1177', # Healthcare advice for private individuals
  '11313', # National information number for severe accidents and crises
  '11414', # National police number for non-urgent police matters
  '116000' # EU-wide hotline number to report missing children
]

three_digit_service_ndcs = [
  '116', # Psychological Help (116 xxx)
  '118' # Number enquiries (118 xxx)
]

Phony.define do
  country '46',
          trunk('0') |
          match(/^(#{services.join('|')})$/) >> split(0) |
          match(/^(#{three_digit_service_ndcs.join('|')})\d{3}$/) >> split(3) |
          one_of(service_ndcs) >> matched_split( # NB: Must be *before* the regional NDCs due to ambiguity of 0900
            /^\d{4}$/ => [4],
            /^\d{5}$/ => [3, 2],
            /^\d{6}$/ => [2, 2, 2],
            /^\d{7}$/ => [3, 2, 2]
          ) |
          one_of(fixed_telematic_service_ndcs) >> split(3, 2, 2) |
          one_of(routing_ndcs) >> split(3, 3, 3) |
          one_of(regional_ndcs_3) >> matched_split(
            /^11\d$/ => [3],
            /^95\d{2}$/ => [4],
            /^\d{5}$/ => [3, 2],
            /^\d{6}$/ => [2, 2, 2]
          ) |
          one_of(large_regional_ndcs_2) >> matched_split(
            /^11\d$/ => [3],
            /^95\d{2}$/ => [4],
            /^90\d{3}$/ => [3, 2],
            /^\d{6}$/ => [2, 2, 2],
            /^\d{7}$/ => [3, 2, 2]
          ) |
          one_of(regional_ndcs_2) >> matched_split(
            /^11\d$/ => [3],
            /^95\d{2}$/ => [4],
            /^\d{5}$/ => [3, 2],
            /^\d{6}$/ => [2, 2, 2],
            /^\d{7}$/ => [3, 2, 2]
          ) |
          one_of(location_independent_ndcs) >> split(3, 2, 2) |
          one_of(mobile_telematic_service_ndcs) >> split(3, 3, 3, 2) |
          one_of(mass_call_service_ndcs) >> split(3, 2) |
          one_of(regional_ndcs_1) >> matched_split(
            /^11\d$/ => [3],
            /^95\d$/ => [3],
            /^95\d{2}$/ => [4],
            /^90\d{3}$/ => [3, 2],
            /^\d{6}$/ => [3, 3],
            /^\d{7}$/ => [3, 2, 2],
            /^\d{8}$/ => [3, 2, 3]
          ) |
          one_of(operator_specific_ndcs) >> split(1..11) |
          one_of(misc_ndcs) >> split(1..10)
end
