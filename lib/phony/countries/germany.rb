# Splits a national number into a fixed size NDC and rest.
#
module Phony
  module Countries
    class Germany < Phony::NationalCode
      
      def initialize
        national_splitter = NationalSplitters::Variable.new 4, @@ndc_mapping
        local_splitter    = LocalSplitter.instance_for [3, 10]
        
        super national_splitter, local_splitter
      end
      
      @@ndc_mapping = {
        :landline => ['10',  # Call-By-Call
                      '11',  # formerly Value Added Services
                      '12',  # Innovative Services
                      '13',  # Voting and Lottery Numbers
                      '30',  # Berlin
                      '32',  # Non Geographical Numbers
                      '40',  # Hamburg
                      '69',  # Frankfurt am Main
                      '89',  # München
                      '201', # Essen
                      '202', # Wuppertal
                      '203', # Duisburg
                      '208', # Mühlheim an der Ruhr
                      '209', # Gelsenkirchen
                      '211', # Düsseldorf
                      '212', # Solingen
                      '214', # Leverkusen
                      '221', # Köln
                      '228', # Bonn
                      '231', # Dortmund
                      '234', # Bochum
                      '241', # Aachen
                      '251', # Münster
                      '261', # Koblenz
                      '271', # Siegen
                      '281', # Wesel
                      '291', # Meschede
                      '310', # Test Number Long Distance
                      '311', # Test Number Local
                      '335', # Frankfurt (Oder)
                      '340', # Dessau
                      '341', # Leipzig
                      '345', # Halle (Saale)
                      '351', # Dresden
                      '355', # Cottbus
                      '361', # Erfurt
                      '365', # Gera
                      '371', # Chemnitz
                      '375', # Zwickau
                      '381', # Rostock
                      '385', # Schwerin
                      '391', # Magdeburg
                      '395', # Neubrandenburg
                      '421', # Bremen
                      '431', # Kiel
                      '441', # Oldenburg
                      '461', # Flensburg
                      '471', # Bremerhaven
                      '481', # Heide
                      '491', # Leer
                      '511', # Hannover
                      '521', # Bielefeld
                      '531', # Braunschweig
                      '541', # Osnabrück
                      '551', # Göttingen
                      '561', # Kassel
                      '571', # Minden
                      '581', # Uelzen
                      '591', # Lingen (Ems)
                      '611', # Wiesbaden
                      '621', # Mannheim / Ludwigshafen
                      '631', # Kaiserslautern
                      '641', # Gießen
                      '651', # Trier
                      '661', # Fulda
                      '671', # Bad Kreuznach
                      '681', # Saarbrücken
                      '700', # Personal Numbers
                      '701', # Personal Numbers, reserved
                      '711', # Stuttgart
                      '721', # Karlsruhe
                      '731', # Ulm
                      '741', # Rottweil
                      '751', # Ravensburg
                      '761', # Freiburg im Breisgau
                      '771', # Donaueschingen
                      '781', # Offenburg
                      '791', # Schwäbisch Hall
                      '800', # Toll-Free Numbers
                      '801', # Toll-Free Numbers, reserved
                      '811', # Hallbergmoos
                      '821', # Augsburg
                      '831', # Kempten
                      '841', # Ingolstadt
                      '851', # Passau
                      '861', # Traunstein
                      '871', # Landshut
                      '881', # Weilheim in Oberbayern
                      '900', # Premium Rate Numbers
                      '901', # Premium Rate Numbers, reserved
                      '902', # Replacement for 0137/0138
                      '906', # Donauwörth
                      '911', # Nürnberg
                      '921', # Bayreuth
                      '931', # Würzburg
                      '941', # Regensburg
                      '951', # Bamberg
                      '961', # Weiden
                      '971', # Bad Kissingen
                      '981', # Ansbach
                      '991' # Deggendorf
                      ],
        :mobile => [
                     '150', # Group3G/Quam
                     '151', # T-Mobile
                     '152', # Vodafone
                     '155', # E-Plus
                     '156', # Mobilcom
                     '157', # E-Plus
                     '159', # O2
                     '160', # T-Mobile
                     '161', # C-Netz
                     '162', # Vodafone
                     '163', # E-Plus
                     '164', # Cityruf
                     '165', # Quix
                     '166', # Telmi
                     '168', # Scall
                     '169', # Cityruf, Scall, Skyper (e*cityruf, e*message, e*skyper)
                     '170', # T-Mobile
                     '171', # T-Mobile
                     '172', # Vodafone
                     '173', # Vodafone
                     '174', # Vodafone
                     '175', # T-Mobile
                     '176', # O2 Germany
                     '177', # E-Plus
                     '178', # E-Plus
                     '179', # O2 Germany
                     '181', # IVPNs
                   ],
        :service => [
                     '182', # Closed User Group
                     '183', # Closed User Group
                     '184', # Closed User Group
                     '185', # Closed User Group
                     '186', # Closed User Group
                     '187', # Closed User Group
                     '189', # Closed User Group
                     '190', # former Premium Rate Services
                     '191', # Online Services
                     '192', # Online Services
                     '193', # Online Services
                     '194', # Online Services
                     '199', # Network-Internal Traffic Control
                    ]
      }
      
    end
  end
end