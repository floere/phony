# Splits a german national number into a fixed size NDC and rest.
#
# Note: We do ignore places with 5 numbers as NDC, like Groß Glienicke (33201)
#
module E164
  module NDC
    class Germany < Prefix

      self.max_ndc_size = 4
      self.format = '%s %s'

      # prefix length => [ndcs]
      self.ndcs = {
        1 => [

        ],
        2 => [
          '30',  # Berlin
          '32',  # Non Geographical Numbers
          '40',  # Hamburg
          '',  #
        ],
        3 => [
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
          '', #
          '', #
          '', #
          '', #
          '', #
          '', #
          '', #
          '', #
        ]
      }

    end
  end
end