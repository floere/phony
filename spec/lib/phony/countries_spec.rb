# encoding: utf-8
#
require 'spec_helper'

describe 'country descriptions' do

  def self.it_splits number, expected
    it { Phony.split(number).should == expected }
  end

  describe 'splitting' do
    describe 'Ascension Island' do
      it_splits '2473551', ['247', false, '3551']
    end
    describe 'Afghanistan' do
      it_splits '93201234567', ['93', '20', '1234567'] # Kabul
    end
    describe 'Algeria' do
      it_splits '213211231234', ['213', '21', '123', '1234'] # Algiers
      it_splits '213331231234', ['213', '33', '123', '1234'] # Batna
    end
    describe 'Argentina' do
      it_splits '541112345678', ['54', '11', '1234', '5678']
      it_splits '542911234567', ['54', '291', '123', '4567']
      it_splits '542965123456', ['54', '2965', '12', '3456']
      it_splits '5491112345678', ['54', '911', '1234', '5678']
      it_splits '5492201234567', ['54', '9220', '123', '4567']
      it_splits '5492221123456', ['54', '92221', '12', '3456']
      it_splits '548001234567', ['54', '800', '123', '4567']
    end
    describe 'Austria' do
      it_splits '43198110', ['43', '1', '98110']               # Vienna
      it_splits '4366914093902', ['43', '669', '14093902']     # Mobile
      it_splits '433161234567891', ['43', '316', '1234567891'] # Graz
      it_splits '432164123456789', ['43', '2164', '123456789'] # Rohrau
    end
    describe 'Australia' do
      it_splits '61512341234', ['61', '5', '1234', '1234'] # Landline
      it_splits '61423123123', ['61', '423', '123', '123'] # Mobile
    end

    describe 'Bahrain' do
      it_splits '97312345678', ['973', false, '1234', '5678']
    end

    describe 'Bangladesh' do
      it_splits '88021234567', %w(880 2 1234567)
      it_splits '8805112345', %w(880 51 12345)
      it_splits '88031123456', %w(880 31 123456)
      it_splits '88032112345', %w(880 321 12345)
      it_splits '8804311234567', %w(880 431 1234567)
      it_splits '880902012345', %w(880 9020 12345)
    end

    describe 'Belarus' do
      it_splits '375152123456', %w(375 152 123456)
      it_splits '375151512345', %w(375 1515 12345)
      it_splits '375163423456', %w(375 163 423456)
      it_splits '375163112345', %w(375 1631 12345)
      it_splits '375291234567', %w(375 29 1234567)
      it_splits '375800123', %w(375 800 123)
      it_splits '3758001234', %w(375 800 1234)
      it_splits '3758001234567', %w(375 800 1234567)
      it_splits '37582012345678', %w(375 820 12345678)
    end

    describe 'Belgium' do
      it_splits '3235551212', ['32', '3', '555', '1212']   # Antwerpen
      it_splits '32505551212', ['32', '50', '555', '1212'] # Brugge
      it_splits '3225551212', ['32', '2', '555', '1212']   # Brussels
      it_splits '3295551914', ['32', '9', '555', '1914']   # Gent
      it_splits '3245551414', ['32', '4', '555', '1414']   # Liège
      it_splits '3216473200', ['32', '16', '473', '200']   # Leuven
      it_splits '32475279584', ['32', '475', '279584']     # mobile
      it_splits '3270123123', ['32', '70', '123', '123']   # Bus Service?
    end

    describe 'Belize' do
      it_splits '5012051234', %w(501 205 1234)
    end

    describe 'Benin' do
      it_splits '22912345678', ['229', false, '1234', '5678']
    end

    describe 'Bolivia' do
      it_splits '59122772266', %w(591 2 277 2266)
    end

    describe 'Botswana' do
      it_splits '26780123456', %w(267 80 123 456)
      it_splits '2672956789', %w(267 29 567 89)
      it_splits '2674634567', %w(267 463 4567)
      it_splits '2675812345', %w(267 58 123 45)
      it_splits '26776712345', %w(267 7 6712 345)
      it_splits '26781234567', %w(267 8 1234 567)
    end
    describe 'Brazil' do
      it_splits '551112341234', ['55', '11', '1234', '1234']
      it_splits '5511981231234', ['55', '11', '9812', '31234'] # São Paulo's 9 digits mobile
    end
    describe 'Cambodia' do
      it_splits '85512236142', ["855", "12", "236", "142"]   # mobile (Mobitel)
      it_splits '855977100872', ["855", "97", "710", "0872"] # mobile (Metfone)
      it_splits '855234601183', ["855", "23", "460", "1183"] # Long fixed line (Phnom Penh)
      it_splits '85533123456', ["855", "33", "123", "456"]   # Regular fixed line (Kampot)
    end
    describe 'Chile' do
      it_splits '5621234567', ['56', '2', '1234567']       # Santiago
      it_splits '5675123456', ['56', '75', '123456']       # Curico
      it_splits '56912345678', ['56', '9', '12345678']     # Mobile
      it_splits '56137123456', ['56', '137', '123', '456'] # Service
    end
    describe 'China' do
      it_splits '862112345678', ['86', '21', '1234', '5678']   # Shanghai
      it_splits '8675582193447', ['86', '755', '8219', '3447'] # Shenzhen
    end
    describe 'Colombia' do
      it_splits '5711234567', ['57', '1', '123', '4567']
      it_splits '573101234567', ['57', '310', '123', '4567'] # mobile
    end
    describe 'Croatia' do
      it_splits '385112312345', ['385', '1', '123', '12345'] # Zagreb
      it_splits '385491231234', ['385', '49', '123', '1234'] # Krapina
    end
    describe 'Cuba' do
      it_splits '5351231234', ['53', '5123', '1234'] # Mobile
      it_splits '5371234567', ['53', '7', '1234567'] # Havana
      it_splits '5342123456', ['53', '42', '123456'] # Villa Clara
    end
    describe 'Cyprus' do
      it_splits '35712322123456', ['357', '123', '22', '123456'] # Voicemail
      it_splits '35722123456',    ['357', '22', '123456']        # Fixed
      it_splits '35791123456',    ['357', '91', '123456']        # Mobile
    end
    describe 'Denmark' do
      it_splits '4532121212', ['45', false, '32', '12', '12', '12']
    end
    describe 'Egypt' do
      it_splits '20212345678', ['20', '2', '12345678']
      it_splits '20921234567', ['20', '92', '1234567']
      it_splits '20951234567', ['20', '95', '1234567']
    end
    describe 'Equatorial Guinea' do
      it_splits '240222201123', ['240', false, '222', '201', '123']
      it_splits '240335201123', ['240', false, '335', '201', '123']
    end
    describe 'Estonia' do
      it_splits '3723212345',  ['372', '321', '2345']   # Landline
      it_splits '37251231234', ['372', '5123', '1234']  # Mobile
      it_splits '3728001234',  ['372', '800', '1234']   # Freephone
      it_splits '37281231234', ['372', '8123', '1234']  # Mobile
      it_splits '37282231234', ['372', '8223', '1234']  # Mobile
      it_splits '37283212345', ['372', '832', '12345']  # Mobile
      it_splits '37270121234', ['372', '7012', '1234']  # Premium
    end
    describe 'Finland' do
      it_splits '3589123123', ['358', '9', '123', '123'] # Helsinki
      it_splits '3581912312', ['358', '19', '123', '12'] # Nylandia
      it_splits '3585012312', ['358', '50', '123', '12'] # Mobile
      it_splits '358600123',  ['358', '600', '123']      # Service
    end
    describe 'France' do
      it_splits '33112345678', ['33', '1', '12','34','56','78'] # Paris
      it_splits '33812345678', ['33', '8', '12','34','56','78'] # Service number
    end
    describe 'Georgia' do
      it_splits '99522012345', %w(995 220 123 45)
      it_splits '995321234567', %w(995 32 123 4567)
      it_splits '995342123456', %w(995 342 123 456)
      it_splits '995596123456', %w(995 596 123 456)
    end
    describe 'Germany' do
      it_splits '493038625454',  ['49', '30', '386', '25454']  # Berlin
      it_splits '4932221764542', ['49', '32', '221', '764542'] # Non-Geographical
      it_splits '4922137683323', ['49', '221', '376', '83323'] # Cologne
      it_splits '497614767676',  ['49', '761', '476', '7676']  # Freiburg im Breisgau
      it_splits '4921535100',    ['49', '2153', '510', '0']    # Nettetal-Lobberich
      it_splits '493434144602',  ['49', '34341', '446', '02']  # Geithain
      it_splits '491805878323',  ['49', '180', '587', '8323']  # Service number
      it_splits '491815878323',  ['49', '181', '587', '8323']  # Service number
      it_splits '4915112312345', ['49', '151', '123', '12345']  # Mobile number
      it_splits '49152112312345',['49', '1521', '123', '12345']  # Mobile number
      it_splits '4916312312345', ['49', '163', '123', '12345']  # Mobile number
    end
    describe 'Ghana' do
      it_splits '233302123456', ['233', '30', '212', '3456'] # Mobile Vodafone, Accra
    end
    describe 'Gibraltar' do
      it_splits '35020012345', ['350', '200', '12345'] # Fixed
      it_splits '35021112345', ['350', '211', '12345'] # Fixed
      it_splits '35022212345', ['350', '222', '12345'] # Fixed
      it_splits '35054123456', ['350', '54', '123456'] # Mobile
      it_splits '35056123456', ['350', '56', '123456'] # Mobile
      it_splits '35057123456', ['350', '57', '123456'] # Mobile
      it_splits '35058123456', ['350', '58', '123456'] # Mobile
      it_splits '35060123456', ['350', '60', '123456'] # Mobile
      it_splits '3508012', ['350', '8012', '' ] # Freephone
    end
    describe 'Greece' do
      it_splits '302142345678', %w(30 21 4234 5678)
      it_splits '302442345678', %w(30 24 4234 5678)
      it_splits '305034571234', %w(30 50 3457 1234)
      it_splits '306901234567', %w(30 69 0123 4567)
      it_splits '307001234567', %w(30 70 0123 4567)
      it_splits '308001001234', %w(30 800 100 1234)
      it_splits '308011001234', %w(30 801 100 1234)
      it_splits '308071001234', %w(30 807 100 1234)
      it_splits '308961001234', %w(30 896 100 1234)
      it_splits '309011234565', %w(30 901 123 4565)
      it_splits '309091234565', %w(30 909 123 4565)
    end

    describe 'Haiti' do
      it_splits '50922121234', ['509', '22', '12', '1234']
    end

    describe 'Hong Kong' do
      it_splits '85212341234', ['852', false, '1234', '1234']     #
    end

    describe 'Hungary' do
      it_splits'3612345678', ['36', '1', '234', '5678']
      it_splits'3622123456', ['36', '22', '123', '456']
    end
    describe 'Iceland' do
      it_splits '354112',     ['354', false, '112']         # Emergency TODO
      it_splits '3544211234', ['354', false, '421', '1234'] # Keflavík
      it_splits '3544621234', ['354', false, '462', '1234'] # Akureyri
      it_splits '3545511234', ['354', false, '551', '1234'] # Reykjavík
    end
    describe 'Indonesia' do
      it_splits '6242323032', ["62", "4", "2323", "032"]
      it_splits '6285220119289', ['62', '852', '2011', '9289']
      it_splits '62217815263', ['62', '21', '7815', '263']
      it_splits '6213123', %w(62 13 123)
      it_splits '6213123456', %w(62 13 123 456)
      it_splits '6217412', %w(62 174 12)
      it_splits '6217412345', %w(62 174 12 345)
      it_splits '6217712', %w(62 177 12)
      it_splits '6217712123456', %w(62 177 1212 3456)
      it_splits '62178123', %w(62 178 123)
      it_splits '6217812345', %w(62 178 123 45)
      it_splits '622112345', %w(62 21 123 45)
      it_splits '622112345567', %w(62 21 1234 5567)
      it_splits '622212345', %w(62 22 123 45)
      it_splits '62221234567', %w(62 22 123 4567)
      it_splits '624311234', %w(62 4 311 234)
      it_splits '62431123456', %w(62 4 3112 3456)
      it_splits '6262212345', %w(62 6 221 2345)
      it_splits '62622123456', %w(62 6 2212 3456)
      it_splits '6270123456', %w(62 70 123 456)
      it_splits '6271123456', %w(62 71 123 456)
      it_splits '62711234567', %w(62 71 123 4567)
      it_splits '62810123456', %w(62 810 123 456)
      it_splits '6281012345678', %w(62 810 1234 5678)
      it_splits '62820123456', %w(62 820 123 456)
      it_splits '6287012345', %w(62 870 123 45)
      it_splits '62877123456', %w(62 877 123 456)
      it_splits '62881123456', %w(62 881 123 456)
      it_splits '6288112345656', %w(62 881 1234 5656)
      it_splits '6291234567', %w(62 9 1234 567)
      it_splits '629123456789', %w(62 9 123 456 789)
    end

    describe 'India' do
      it_splits '919911182111', ['91', '99', '111', '82', '111'] # mobile
      it_splits '912212345678', ['91', '22', '123', '45', '678'] # New Delhi
      it_splits '911411234567', ['91', '141', '123', '45', '67'] # Jaipur
      it_splits '913525123456', ['91', '3525', '123', '456' ]    # DALKHOLA
    end

    describe 'Iran' do
      it_splits '982112341234', ['98', '21', '1234', '1234'] # Teheran
      it_splits '989191231234', ['98', '919', '123', '1234'] # Example Cell Phone
    end

    describe 'Ireland' do
      it_splits '35311234567',  ['353', '1', '123', '4567']  # Dublin, 7 digit subscriber #
      it_splits '3532212345',   ['353', '22', '12345']       # Mallow, 5 digit subscriber #
      it_splits '35345123456',  ['353', '45', '123456']      # Naas, 6 digit subscriber #
      it_splits '353801234567', ['353', '80', '123', '4567'] # Mobile
      it_splits '353761234567', ['353', '76', '123', '4567'] # VoIP
      it_splits '353800123456', ['353', '800', '123456']     # Freefone
      it_splits '353000123456', ['353', '000', '123456']     # Default fixed 3 split for unrecognized
    end

    describe 'Israel (972)' do
      it_splits '972100',       ['972', '1', '00']  # Police
      it_splits '97221231234',  ['972', '2', '123', '1234']  # Jerusalem Area
      it_splits '97282411234',  ['972', '8', '241', '1234']  # Gaza Strip (Palestine)
      it_splits '97291231234',  ['972', '9', '123', '1234']  # Sharon Area
      it_splits '972501231234', ['972', '50', '123', '1234']  # Mobile (Pelephone)
      it_splits '972591231234', ['972', '59', '123', '1234']  # Mobile Jawwal (Palestine)
      it_splits '972771231234', ['972', '77', '123', '1234']  # Cable Phone Services
      it_splits '9721700123123', ['972', '1', '700', '123', '123']  # Cable Phone Services
    end
    describe 'Israel (970)' do
      it_splits '97021231234',  ['970', '2', '123', '1234']  # Jerusalem Area
      it_splits '97082411234',  ['970', '8', '241', '1234']  # Gaza Strip (Palestine)
      it_splits '97091231234',  ['970', '9', '123', '1234']  # Sharon Area
      it_splits '970501231234', ['970', '50', '123', '1234']  # Mobile (Pelephone)
      it_splits '970591231234', ['970', '59', '123', '1234']  # Mobile Jawwal (Palestine)
      it_splits '970771231234', ['970', '77', '123', '1234']  # Cable Phone Services
      it_splits '9701700123123', ['970', '1', '700', '123', '123']  # Cable Phone Services
    end
    describe 'Italy' do
      it_splits '3934869528',   ['39', '348', '695', '28']   # Mobile
      it_splits '393357210488', ['39', '335', '721', '0488'] # Mobile
      it_splits '390612341234', ['39', '06', '1234', '1234'] # Roma
      it_splits '390288838883', ['39', '02', '8883', '8883'] # Milano
      it_splits '390141595661', ['39', '0141', '595', '661'] # Asti
      it_splits '3903123391',   ['39', '031', '233', '91']   # Como
      it_splits '390909709511', ['39', '090', '970', '9511'] # Barcellona
    end
    describe 'Japan' do
      it_splits '81312345678', %w(81 3 1234 5678)
      it_splits '81120123456', %w(81 120 123 456)
      it_splits '81111234567', %w(81 11 1234 567)
      it_splits '81123123456', %w(81 123 123 456)
      it_splits '81126712345', %w(81 1267 123 45)
      it_splits '819012345678', %w(81 90 1234 5678)
    end
    describe 'Kenya' do
      it_splits '254201234567', ['254', '20', '1234567'] # Nairobi
      it_splits '254111234567', ['254', '11', '1234567'] # Mombasa
      it_splits '254723100220', ['254', '723', '100220'] # Mombasa
    end
    describe 'Kyrgyzstan' do
      it_splits '996312212345', %w(996 312 212 345)
      it_splits '996315212345', %w(996 315 212 345)
      it_splits '996313121234', %w(996 3131 212 34)
      it_splits '996394621234', %w(996 3946 212 34)
      it_splits '996501234567', %w(996 50 123 4567)
      it_splits '996521234567', %w(996 52 123 4567)
      it_splits '996581234567', %w(996 58 123 4567)
      it_splits '996800123456', %w(996 800 123 456)
    end
    describe 'Lithuania' do
      it_splits '37070012123', ['370', '700', '12', '123']     # Service
      it_splits '37061212123', ['370', '612', '12', '123']     # Mobile
      it_splits '37051231212', ['370', '5', '123', '12', '12'] # Vilnius
      it_splits '37037121212', ['370', '37', '12', '12', '12'] # Kaunas
      it_splits '37044011212', ['370', '440', '1', '12', '12'] # Skuodas
    end
    describe 'Luxembourg' do
      it_splits '352222809',       ['352', '22', '28', '09']
      it_splits '35226222809',     ['352', '26', '22', '28', '09']
      it_splits '352621123456',    ['352', '621', '123', '456']
      it_splits '3524123456',      ['352', '4', '12', '34', '56']
      it_splits '352602112345678', ['352', '6021', '12', '34', '56', '78']
      it_splits '352370431',       ['352', '37', '04', '31']
      it_splits '35227855',        ['352', '27', '85', '5']
    end
    describe 'Malaysia' do
      it_splits '6082123456',   ['60', '82', '123456']   # Kuching
      it_splits '60312345678',  ['60', '3', '12345678'] # Kuala Lumpur
      it_splits '60212345678',  ['60', '2', '12345678'] # Singapore
      it_splits '60111231234', ['60', '11', '123', '1234'] # Mobile
      it_splits '60800121234',  ['60', '800', '12', '1234'] # Freephone
      # it_splits '60112',       ['60', '112'] # Service
     end
    describe 'Malta' do
      it_splits '35621231234', ['356', '2123', '1234'] # Fixed
      it_splits '35677123456', ['356', '77', '123456'] # Mobile
      it_splits '35698123456', ['356', '98', '123456'] # Mobile
      it_splits '35651231234', ['356', '5123', '1234'] # Voice Mail
    end
    describe 'Mexico' do
      it_splits '525512121212', ['52', '55', '12', '12', '12', '12'] # Mexico City
      it_splits '526641231212', ['52', '664', '123', '12', '12']     # Tijuana
    end
    describe 'Monaco' do
      it_splits '37741123456', ['377', '41', '12', '34', '56'] # Mobile
      it_splits '377612345678', ['377', '6', '12', '34', '56', '78'] # Mobile
    end
    describe 'Montenegro' do
      it_splits '38280123456', %w(382 80 123 456)
      it_splits '3822012345', %w(382 20 123 45)
      it_splits '38220123456', %w(382 20 123 456)
      it_splits '38232123456', %w(382 32 123 456)
      it_splits '38278103456', %w(382 78 103 456)
      it_splits '38263123', %w(382 63 123)
      it_splits '382631234567890', %w(382 63 123 456 7890)
      it_splits '38277103456', %w(382 77 103 456)
      it_splits '38294103456', %w(382 94 103 456)
      it_splits '38288103456', %w(382 88 103 456)
      it_splits '3826812', %w(382 68 12)
      it_splits '382681212345678', %w(382 68 12 1234 5678)
      it_splits '38270123', %w(382 70 123)
      it_splits '382701234567890', %w(382 70 123 456 7890)
    end
    describe 'Morocco' do
      it_splits '212537718685', ['212', '53', '7718', '685']
      it_splits '212612345678', ['212', '6', '12', '34', '56', '78']
    end
    describe 'The Netherlands' do
      it_splits '31612345678', ['31', '6', '12', '34', '56', '78'] # mobile
      it_splits '31201234567', ['31', '20', '123', '4567']
      it_splits '31222123456', ['31', '222', '123', '456']
    end
    describe 'Norway' do
      it_splits '4721234567', ['47',false,'21','23','45','67']
      it_splits '4731234567', ['47',false,'31','23','45','67']
      it_splits '4741234567', ['47',false,'412','34','567']
      it_splits '4751234567', ['47',false,'51','23','45','67']
      it_splits '4761234567', ['47',false,'61','23','45','67']
      it_splits '4771234567', ['47',false,'71','23','45','67']
      it_splits '4781234567', ['47',false,'812','34','567']
      it_splits '4791234567', ['47',false,'912','34','567']
    end
    describe 'Oman' do
      it_splits '96824423123', %w(968 24 423 123)
      it_splits '96825423123', %w(968 25 423 123)
    end
    describe 'Pakistan' do
      it_splits '922112345678', %w(92 21 1234 5678)
      it_splits '92221234567', %w(92 22 1234 567)
      it_splits '92232123456', %w(92 232 123 456)
      it_splits '923012345678', %w(92 30 1234 5678)
    end
    describe 'Paraguay (Republic of)' do
      it_splits '59521123456', %w(595 21 123 456)
      it_splits '595211234567', %w(595 21 123 4567)
      it_splits '595345123456', %w(595 345 123 456)
      it_splits '595961611234', %w(595 96 161 1234)
    end
    describe 'Peru' do
      it_splits '51112341234', ['51', '1', '1234', '1234'] # Lima
      it_splits '51912341234', ['51', '9', '1234', '1234'] # mobile
      it_splits '51841234123', ['51', '84', '1234', '123'] # Cuzco, best effort
    end
    describe 'Philippines' do
      it_splits '6321234567', ['63', '2', '1234567']
      it_splits '6321234567890', ['63', '2', '1234567890']
      it_splits '632123456789012', ['63', '2', '123456789012']
      it_splits '639121234567', ['63', '912', '1234567']
      it_splits '63881234567', ['63', '88', '1234567']
    end
    describe 'Poland' do
      it_splits '48123456789', ['48', '12', '345', '67', '89'] # Landline
      it_splits '48501123456', ['48', '501', '123', '456']     # Mobile
      it_splits '48800123456', ['48', '800', '123', '456']     # Free
      it_splits '48801123456', ['48', '801', '123', '456']     # Shared cost
      it_splits '48701123456', ['48', '701', '123', '456']     # Premium
    end
    describe 'Portugal' do
      it_splits '351211231234', ['351', '21', '123', '1234'] # Lisboa
      it_splits '351241123123', ['351', '241', '123', '123'] # Abrantes
      it_splits '351931231234', ['351', '93', '123', '1234'] # mobile
    end
    describe 'Qatar' do
      it_splits '9741245123456', %w(974 1245 123 456)
      it_splits '9742613456', %w(974 26 134 56)
      it_splits '97433123456', %w(974 33 123 456)
      it_splits '97444412456', %w(974 44 412 456)
      it_splits '9748001234', %w(974 800 12 34)
      it_splits '9749001234', %w(974 900 12 34)
      it_splits '97492123', %w(974 92 123)
      it_splits '97497123', %w(974 97 123)
    end
    describe 'Romania' do
      it_splits '40211231234', ['40', '21', '123', '1234'] # Bucureşti
      it_splits '40721231234', ['40', '72', '123', '1234'] # mobile
      it_splits '40249123123', ['40', '249', '123', '123'] # Olt
    end
    describe 'Russia' do
      it_splits '78122345678',   ['7', '812', '234', '56', '78'] # Russia 3-digit
      it_splits '74012771077',   ['7', '4012', '77', '10', '77'] # Russia 4-digit
      it_splits '78402411212',   ['7', '84024', '1', '12', '12'] # Russia 5-digit
      it_splits '79296119119',   ['7', '929', '611', '91', '19'] # Russia 3-digit, Megafon Mobile.
      it_splits '7840121212',    ['7', '840', '12', '12', '12']  # Abhasia
      it_splits '7799121212',    ['7', '799', '12', '12', '12']  # Kazachstan
      it_splits '7995344121212', ['7','995344','12','12','12']   # South Osetia
      it_splits '7209175276',    ['7', '209', '17', '52', '76']  # Fantasy number
    end
		describe 'Rwanda' do
      it_splits '250781234567', ['250', '78', '1234567'] # mobile
      it_splits '250721234567', ['250', '72', '1234567'] # mobile
      it_splits '250731234567', ['250', '73', '1234567'] # mobile
      it_splits '250251234567', ['250', '25', '1234567'] # fixed
      it_splits '25006123456',  ['250', '06', '123456']  # fixed
    end
    describe 'Sao Tome and Principe' do
      it_splits '2392220012', %w(239 2 220 012)
      it_splits '2399920012', %w(239 9 920 012)
    end
    describe 'South Korea' do
      it { Phony.split('82212345678').should  == ['82', '2', '1234', '5678']  } # Seoul
      it { Phony.split('825112345678').should == ['82', '51', '1234', '5678'] } # Busan
      it { Phony.split('821027975588').should == ['82', '10', '2797', '5588'] } # mobile
      it { Phony.split('821087971234').should == ['82', '10', '8797', '1234'] } # mobile
    end
    describe 'South Sudan' do
      it_splits '211123212345', ['211', '123', '212', '345']
      it_splits '211973212345', ['211', '973', '212', '345']
    end
    describe 'Sudan' do
      it_splits '249187171100', ['249', '18', '717', '1100']
    end
    describe 'Thailand' do
      it { Phony.split('6621231234').should == ['66', '2', '123', '1234'] } # Bangkok
      it { Phony.split('6636123123').should == ['66', '36', '123', '123'] } # Lop Buri
      it { Phony.split('66851234567').should == ['66', '851', '234', '567'] } # Lop Buri
    end
    describe 'Tunesia' do
      it { Phony.split('21611231234').should == ['216', '1', '123', '1234'] } # Ariana
      it { Phony.split('21621231234').should == ['216', '2', '123', '1234'] } # Bizerte
    end
    describe 'Salvador (El)' do
      it { Phony.split('50321121234').should == ['503', '2112', '1234'] } # Fixed number
      it { Phony.split('50361121234').should == ['503', '6112', '1234'] } # Mobile number
    end

    describe 'Singapore' do
      it { Phony.split('6561231234').should == ['65', false, '6123', '1234'] } # Fixed line
    end
    describe 'Slovakia' do
      it { Phony.split('421912123456').should == ['421', '912', '123456'] } # Mobile
      it { Phony.split('421212345678').should == ['421', '2', '12345678'] } # Bratislava
      it { Phony.split('421371234567').should == ['421', '37', '1234567'] } # Nitra / Other
    end

    describe 'Sri Lanka' do
      it { Phony.split('94711231212').should == ['94', '71', '123', '12', '12'] } # Mobile
    end

    describe 'Sweden' do
      it { Phony.split('46812345678').should == ['46', '8', '12345678'] } # Stockholm
      it { Phony.split('46111234567').should == ['46', '11', '1234567'] }
      it { Phony.split('46721234567').should == ['46', '72', '1234567'] } # mobile
      it { Phony.split('46125123456').should == ['46', '125', '123456'] }
    end
    describe 'Switzerland' do
      it { Phony.split('41443643532').should == ['41', '44', '364', '35', '32'] } # Zurich (usually)
      it { Phony.split('41800334455').should == ['41', '800', '334', '455'] }     # Service number
    end
    describe 'Tanzania' do
      it { Phony.split('255221231234').should == ['255', '22', '123', '1234'] } # Dar Es Salaam
      it { Phony.split('255651231234').should == ['255', '65', '123', '1234'] } # TIGO
      it { Phony.split('255861123123').should == ['255', '861', '123', '123'] } # Special Rates
    end
    describe 'Turkey' do
      it { Phony.split('903121234567').should == ['90', '312', '123', '4567'] } # Ankara
    end
    describe 'Uganda' do
      it { Phony.split('256414123456').should == ['256', '41', '4123456'] } # Kampania
      it { Phony.split('256464441234').should == ['256', '464', '441234'] } # Mubende
    end
    describe 'The UK' do
      it { Phony.split('442075671113').should == ['44', '20', '7567', '1113'] } # [2+8] London
      it { Phony.split('442920229901').should == ['44', '29', '2022', '9901'] } # [2+8] Cardiff
      it { Phony.split('441134770011').should == ['44', '113', '477', '0011'] } # [3+7] Leeds
      it { Phony.split('441412770022').should == ['44', '141', '277', '0022'] } # [3+7] Glasgow
      it { Phony.split('441204500532').should == ['44', '1204', '500532'] }     # [4+6] Bolton
      it { Phony.split('44120462532').should  == ['44', '1204', '62532']  }     # [4+5] Bolton
      it { Phony.split('441333247700').should == ['44', '1333', '247700'] }     # [4+6] Leven (Fife)
      it { Phony.split('441382229845').should == ['44', '1382', '229845'] }     # [4+6] Dundee
      it { Phony.split('441420700378').should == ['44', '1420', '700378'] }     # [4+6] Alton
      it { Phony.split('44142080378').should  == ['44', '1420', '80378']  }     # [4+5] Alton
      it { Phony.split('441475724688').should == ['44', '1475', '724688'] }     # [4+6] Greenock
      it { Phony.split('441539248756').should == ['44', '1539', '248756'] }     # [4+6] Kendal (Mixed area)
      it { Phony.split('441539648788').should == ['44', '15396', '48788'] }     # [5+5] Sedbergh (Mixed area)
      it { Phony.split('441652757248').should == ['44', '1652', '757248'] }     # [4+6] Brigg
      it { Phony.split('441664333456').should == ['44', '1664', '333456'] }     # [4+6] Melton Mowbray
      it { Phony.split('441697222555').should == ['44', '1697', '222555'] }     # [4+6] Brampton (Mixed area)
      it { Phony.split('441697388555').should == ['44', '16973', '88555'] }     # [5+5] Wigton (Mixed area)
      it { Phony.split('441697433777').should == ['44', '16974', '33777'] }     # [5+5] Raughton Head (Mixed area)
      it { Phony.split('44169772333').should  == ['44', '16977', '2333']  }     # [5+4] Brampton (Mixed area)
      it { Phony.split('441697744888').should == ['44', '16977', '44888'] }     # [5+5] Brampton (Mixed area)
      it { Phony.split('441757850526').should == ['44', '1757', '850526'] }     # [4+6] Selby
      it { Phony.split('441890234567').should == ['44', '1890', '234567'] }     # [4+6] Coldstream (ELNS area)
      it { Phony.split('441890595378').should == ['44', '1890', '595378'] }     # [4+6] Ayton (ELNS area)
      it { Phony.split('441931306526').should == ['44', '1931', '306526'] }     # [4+6] Shap
      it { Phony.split('441946555777').should == ['44', '1946', '555777']  }    # [4+6] Whitehaven (Mixed area)
      it { Phony.split('44194662888').should  == ['44', '1946', '62888']  }     # [4+5] Whitehaven (Mixed area)
      it { Phony.split('441946722444').should == ['44', '19467', '22444']  }    # [5+5] Gosforth (Mixed area)
      it { Phony.split('441987705337').should == ['44', '1987', '705337'] }     # [4+6] Ebbsfleet
      it { Phony.split('443005828323').should == ['44', '300', '582', '8323'] } # Non-geographic (NTS)
      it { Phony.split('443334253344').should == ['44', '333', '425', '3344'] } # Non-geographic (NTS)
      it { Phony.split('443437658834').should == ['44', '343', '765', '8834'] } # Non-geographic (NTS)
      it { Phony.split('443452273512').should == ['44', '345', '227', '3512'] } # Non-geographic (NTS)
      it { Phony.split('443707774444').should == ['44', '370', '777', '4444'] } # Non-geographic (NTS)
      it { Phony.split('443725247722').should == ['44', '372', '524', '7722'] } # Non-geographic (NTS)
      it { Phony.split('44500557788').should  == ['44', '500', '557788'] }      # Freefone (500 + 6)
      it { Phony.split('445575671113').should == ['44', '55', '7567', '1113'] } # Corporate numbers
      it { Phony.split('445644775533').should == ['44', '56', '4477', '5533'] } # LIECS/VoIP
      it { Phony.split('447020229901').should == ['44', '70', '2022', '9901'] } # Personal numbers
      it { Phony.split('447688554246').should == ['44', '76', '8855', '4246'] } # Pager
      it { Phony.split('447180605207').should == ['44', '7180', '605207'] }     # Mobile
      it { Phony.split('447480605207').should == ['44', '7480', '605207'] }     # Mobile
      it { Phony.split('447624605207').should == ['44', '7624', '605207'] }     # Mobile (Isle of Man)
      it { Phony.split('447780605207').should == ['44', '7780', '605207'] }     # Mobile
      it { Phony.split('447980605207').should == ['44', '7980', '605207'] }     # Mobile
      it { Phony.split('44800557788').should  == ['44', '800', '557788']  }     # Freefone (800 + 6)
      it { Phony.split('448084682355').should == ['44', '808', '468', '2355'] } # Freefone (808 + 7)
      it { Phony.split('448005878323').should == ['44', '800', '587', '8323'] } # Freefone (800 + 7), regression
      it { Phony.split('448437777334').should == ['44', '843', '777', '7334'] } # Non-geographic (NTS)
      it { Phony.split('448457777334').should == ['44', '845', '777', '7334'] } # Non-geographic (NTS)
      it { Phony.split('448707777334').should == ['44', '870', '777', '7334'] } # Non-geographic (NTS)
      it { Phony.split('448727777334').should == ['44', '872', '777', '7334'] } # Non-geographic (NTS)
      it { Phony.split('449052463456').should == ['44', '905', '246', '3456'] } # Non-geographic (PRS)
      it { Phony.split('449122463456').should == ['44', '912', '246', '3456'] } # Non-geographic (PRS)
      it { Phony.split('449832463456').should == ['44', '983', '246', '3456'] } # Non-geographic (SES)
    end
    describe 'US' do
      it { Phony.split('15551115511').should == ['1', '555', '111', '5511'] }
    end
    describe 'Venezuela' do
      it { Phony.split('582121234567').should == ['58', '212', '1234567'] }
    end
    describe 'Vietnam' do
      it { Phony.split('8498123456').should == ['84', '98', '123456'] } # Viettel Mobile
      it { Phony.split('8499612345').should == ['84', '996', '12345'] } # GTel
      it { Phony.split('8441234567').should == ['84', '4', '1234567'] } # Hanoi
    end
    describe 'Zambia' do
      it_splits '260977640895', ['260', '97', '7640895'] # mobile
      it_splits '260211229049', ['260', '211', '229049'] # fixed
    end
    describe 'New Zealand' do
      it { Phony.split('6491234567').should == ['64', '9', '123', '4567'] }
    end
    describe 'Bhutan (Kingdom of)' do
      it_splits '9759723642', %w(975 9 723 642)
    end
    describe 'Brunei Darussalam' do
      it_splits '6737932744', %w(673 7 932 744)
    end
    describe 'Burkina Faso' do
      it_splits '22667839323', ['226', false, '6783', '9323']
    end
    describe 'Burundi' do
      it_splits '25712345678', ['257', false, '1234', '5678']
    end
    describe 'Cameroon' do
      it_splits '23727659381', ['237', false, '2765', '9381']
    end
    describe 'Cape Verde' do
      it_splits '2385494177', ['238', false, '549', '4177']
    end
    describe 'Central African Republic' do
      it_splits '23612345678', ['236', false, '1234', '5678']
    end
    describe 'Chad' do
      it_splits '23512345678', ['235', false, '1234', '5678']
    end
    describe 'Comoros' do
      it_splits '2693901234', ['269', false, '3901', '234']
      it_splits '2693401234', ['269', false, '3401', '234']
    end
    describe 'Congo' do
      it_splits '242123456789', ['242', false, '1234', '56789']
    end
    describe 'Cook Islands' do
      it_splits '68251475', ['682', false, '51', '475']
    end
    describe 'Costa Rica' do
      it_splits '50622345678', %w(506 2 234 5678)
    end
    describe "Côte d'Ivoire" do
      it_splits '22537335518', ['225', false, '3733', '5518']
    end
    describe 'Democratic Republic of Timor-Leste' do
      it_splits '6701742945', ['670', false, '174', '2945']
    end
    describe 'Democratic Republic of the Congo' do
      it_splits '24311995381', %w(243 1 199 5381)
    end
    describe 'Diego Garcia' do
      it_splits '2461234683', ['246', false, '123', '4683']
    end
    describe 'Djibouti' do
      it_splits '25349828978', ['253', false, '4982', '8978']
    end
    describe 'Ecuador' do
      it_splits '593445876756', %w(593 44 587 6756)
    end
    describe 'Eritrea' do
      it_splits '2916537192', %w(291 6 537 192)
    end
    describe 'Ethiopia' do
      it_splits '251721233486', %w(251 72 123 3486)
    end
    describe 'Falkland Islands (Malvinas)' do
      it_splits '50014963', ['500', false, '14', '963']
    end
    describe 'Faroe Islands' do
      it_splits '298997986', ['298', false, '997', '986']
    end
    describe 'Fiji (Republic of)' do
      it_splits '6798668123', ['679', false, '866', '8123']
    end
    describe 'French Guiana (French Department of)' do
      it_splits '594594123456', %w(594 594 123 456)
    end
    describe "French Polynesia (Territoire français d'outre-mer)" do
      it_splits '689219889', ['689', false, '219', '889']
    end
    describe 'Gabonese Republic' do
      it_splits '2411834375', ['241', '1', '834', '375']
    end
    describe 'Gambia' do
      it_splits '2206683355', ['220', false, '668', '3355']
    end
    describe 'Greenland' do
      it_splits '299314185', ['299', '31', '4185']
      it_splits '299691123', ['299', '691', '123']
    end
    describe 'Guadeloupe (French Department of)' do
      it_splits '590123456789', %w(590 123 456 789)
    end
    describe 'Guatemala (Republic of)' do
      it_splits '50219123456789', ['502', '19', '123', '456', '789']
      it_splits '50221234567', ['502', '2', '123', '4567']
    end
    describe 'Guinea' do
      it_splits '22412345678', ['224', false, '1234', '5678']
    end
    describe 'Guinea-Bissau' do
      it_splits '2453837652', ['245', false, '383', '7652']
    end
    describe 'Guyana' do
      it_splits '5922631234', %w(592 263 1234)
    end
    describe 'Honduras (Republic of)' do
      it_splits '50412961637', %w(504 12 961 637)
    end
    describe 'Iraq' do
      it_splits '96411234567', %w(964 1 123 4567)
      it_splits '96421113456', %w(964 21 113 456)
      it_splits '9647112345678', %w(964 71 1234 5678)
    end
    describe 'Jordan (Hashemite Kingdom of)' do
      it_splits '96280012345', %w(962 800 123 45)
      it_splits '96226201234', %w(962 2 620 1234)
      it_splits '962712345678', %w(962 7 1234 5678)
      it_splits '962746612345', %w(962 7 4661 2345)
      it_splits '96290012345', %w(962 900 123 45)
      it_splits '96285123456', %w(962 85 123 456)
      it_splits '96270123456', %w(962 70 123 456)
      it_splits '96262501456', %w(962 6250 1456)
      it_splits '96287901456', %w(962 8790 1456)
    end
    describe 'Kiribati (Republic of)' do
      it_splits '68634814', ['686', false, '34', '814']
    end
    describe "Democratic People's Republic of Korea" do
      it_splits '850212345', %w(850 2 123 45)
      it_splits '8502123456789', %w(850 2 123 456 789)
      it_splits '85023812356', %w(850 2 381 2356)
      #it_splits '85028801123456781256', %w(850 2 8801 1234 5678 1256)
      it_splits '8501911234567', %w(850 191 123 4567)
    end
    describe 'Kuwait (State of)' do
      it_splits '96523456789', ['965', false, '2345', '6789']
      it_splits '9651812345', ['965', false, '181', '2345']
    end
    describe "Lao People's Democratic Republic" do
      it_splits '85697831195', %w(856 97 831 195)
    end
    describe 'Latvia' do
      it_splits '37180123456', %w(371 801 234 56)
      it_splits '37163723456', %w(371 637 234 56)
      it_splits '37129412345', %w(371 294 123 45)
    end
    describe 'Lebanon' do
      it_splits '9611123456', %w(961 1 123 456)
      it_splits '9614123456', %w(961 4 123 456)
      it_splits '9613123456', %w(961 3 123 456)
      it_splits '96170123456', %w(961 70 123 456)
      it_splits '96190123456', %w(961 90 123 456)
      it_splits '96181123456', %w(961 81 123 456)
    end
    describe 'Lesotho' do
      it_splits '26623592495', ['266', false, '2359', '2495']
    end
    describe 'Liberia' do
      it_splits '23121234567', ['231', false, '2123', '4567']
      it_splits '2314123456', ['231', false, '4123', '456']
    end
    describe 'Libya' do
      it_splits '21820512345', %w(218 205 123 45)
      it_splits '21822123456', %w(218 22 123 456)
      it_splits '218211234456', %w(218 21 1234 456)
      it_splits '218911234456', %w(218 91 1234 456)
    end
    describe 'Madagascar' do
      it_splits '26120012345678', ['261', false, '20', '012', '345', '678']
      it_splits '261201243456', ['261', false, *%w(20 124 3456)]
      it_splits '261512345678', ['261', false, *%w(512 345 678)]
    end
    describe 'Malawi' do
      it_splits '2651725123', ['265', false, '1725', '123']
      it_splits '265213456789',[ '265', false, '213', '456', '789']
      it_splits '2659123456', ['265', false, '9123', '456']
      it_splits '265991123456', ['265', false, '991', '123', '456']
    end
    describe 'Maldives (Republic of)' do
      it_splits '9606568279', ['960', '656', '8279']
    end
    describe 'Mali' do
      it_splits '22379249349', ['223', false, '7924', '9349']
    end
    describe 'Marshall Islands (Republic of the)' do
      it_splits '6924226536', ['692', false, '422', '6536']
    end
    describe 'Martinique (French Department of)' do
      it_splits '596596123456', %w(596 596 123 456)
    end
    describe 'Mauritania' do
      it_splits '22212345678', ['222', false, '1234', '5678']
    end
    describe 'Mauritius' do
      it_splits '2309518919', ['230', false, '951', '8919']
    end
    describe 'Micronesia (Federated States of)' do
      it_splits '6911991754', ['691', false, '199', '1754']
    end
    describe 'Moldova' do
      it_splits '37380012345', %w(373 800 123 45)
      it_splits '37322123345', %w(373 22 123 345)
      it_splits '37324112345', %w(373 241 123 45)
      it_splits '37360512345', %w(373 605 123 45)
      it_splits '37380312345', %w(373 803 123 45)
    end
    describe 'Mongolia' do
      it_splits '9761112345', %w(976 11 123 45)
      it_splits '9761211234', %w(976 121 12 34)
      it_splits '97612112345', %w(976 121 12 345)
      it_splits '97670123456', %w(976 70 123 456)
      it_splits '97675123456', %w(976 75 123 456)
      it_splits '97688123456', %w(976 88 123 456)
      it_splits '97650123456', %w(976 50 123 456)
    end
    describe 'Mozambique' do
      it_splits '258600123456', %w(258 600 123 456)
      it_splits '25825112345', %w(258 251 123 45)
      it_splits '258821234456', %w(258 82 1234 456)
      it_splits '258712344567', %w(258 7 1234 4567)
    end
    describe 'Namibia' do
      it_splits '264675161324', %w(264 6751 613 24)
      it_splits '26467175890', %w(264 67 175 890)
      it_splits '26463088612345', %w(264 63 088 612 345)
      it_splits '264851234567', %w(264 85 1234 567)
    end
    describe 'Nauru (Republic of)' do
      it_splits '6741288739', ['674', false, '128', '8739']
    end
    describe 'Nepal' do
      it_splits '97714345678', %w(977 1 434 5678)
      it_splits '97710123456', %w(977 10 123 456)
      it_splits '9779812345678', %w(977 98 1234 5678)
    end
    describe "New Caledonia (Territoire français d'outre-mer)" do
      it_splits '687747184', ['687', false, '747', '184']
    end
    describe 'Nicaragua' do
      it_splits '50512345678', ['505', '12', '345', '678']
    end
    describe 'Niger' do
      it_splits '22712345678', ['227', false, '1234', '5678']
    end
    describe 'Niue' do
      it_splits '6833651', ['683', false, '3651']
    end
    describe 'Palau (Republic of)' do
      it_splits '6804873653', ['680', false, '487', '3653']
    end
    describe 'Panama (Republic of)' do
      it_splits '5078001234', %w(507 800 1234)
      it_splits '50761234567', %w(507 6 123 4567)
      it_splits '5072123456', %w(507 2 123 456)
    end
    describe 'Papua New Guinea' do
      it_splits '6753123567', %w(675 3 123 567)
      it_splits '6751801234', %w(675 180 1234)
      it_splits '67580123456', %w(675 80 123 456)
      it_splits '67591123456', %w(675 91 123 456)
      it_splits '6751612345', %w(675 16 123 45)
      it_splits '67518412345678', %w(675 184 1234 5678)
      it_splits '67517012', %w(675 170 12)
      it_splits '6751891', %w(675 189 1)
      it_splits '6752701234', %w(675 270 1234)
      it_splits '6752751234', %w(675 275 1234)
      it_splits '67527912', %w(675 279 12)
      it_splits '67511512345678', %w(675 115 1234 5678)
    end
    describe 'Reunion / Mayotte (new)' do
      it_splits '2625943992657', ['262', false, '59439', '92657']
    end
    describe 'Saint Helena' do
      it_splits '2903614', ['290', false, '3614']
    end
    describe 'Saint Pierre and Miquelon (Collectivité territoriale de la République française)' do
      it_splits '508418826', ['508', false, '418', '826']
    end
    describe 'Samoa (Independent State of)' do
      it_splits '685800123', ['685', false, '800', '123']
      it_splits '68561123', ['685', false, '61', '123']
      it_splits '6857212345', ['685', false, '721', '2345']
      it_splits '685830123', ['685', false, '830', '123']
      it_splits '685601234', ['685', false, '601', '234']
      it_splits '6858412345', ['685', false, '841', '2345']
    end
    describe 'San Marino' do
      it_splits '378800123', ['378', false, '800', '123']
      it_splits '3788001234567', ['378', false, '800', '123', '4567']
      it_splits '378012345', ['378', false, '012', '345']
      it_splits '3780123456789', ['378', false, '012', '345', '6789']
      it_splits '378512345', ['378', false, '512', '345']
      it_splits '3785123456789', ['378', false, '512', '345', '6789']
    end
    describe 'Saudi Arabia (Kingdom of)' do
      it_splits '96628528423', %w(966 2 852 8423)
    end
    describe 'Senegal' do
      it_splits '221123456789', ['221', false, '1234', '56789']
    end
    describe 'Serbia' do
      it_splits '38180012345', %w(381 800 123 45)
      it_splits '3811012345', %w(381 10 123 45)
      it_splits '38110123456', %w(381 10 123 456)
      it_splits '38111123456', %w(381 11 123 456)
      it_splits '381111234567', %w(381 11 123 4567)
      it_splits '381721234567', %w(381 72 123 4567)
      it_splits '38160123', %w(381 60 123)
      it_splits '381601234567', %w(381 60 123 4567)
      it_splits '38142123456', %w(381 42 123 456)
      it_splits '38191234567', %w(381 9 123 4567)
      it_splits '38160123', %w(381 60 123)
      it_splits '381601234567890', %w(381 60 123 456 7890)
      it_splits '38170123456', %w(381 70 123 456)
    end
    describe 'Sierra Leone' do
      it_splits '23264629769', %w(232 64 629 769)
    end
    describe 'Solomon Islands' do
      it_splits '67754692', ['677', false, '54', '692']
      it_splits '6777546921', ['677', false, '7546', '921']
    end
    describe 'Somali Democratic Republic' do
      it_splits '252103412345', %w(252 1034 123 45)
      it_splits '2521313123', %w(252 1313 123)
      it_splits '2521601234', %w(252 160 12 34)
      it_splits '25250012345', %w(252 500 123 45)
      it_splits '252671234567', %w(252 67 1234 567)
    end
    describe 'Suriname (Republic of)' do
      it_splits '597958434', ['597', false, '958', '434']

      it_splits  '597212345',  ['597', false, '212', '345']
      it_splits  '5976123456', ['597', false, '612', '3456']
    end
    describe 'Swaziland' do
      it_splits '26822071234', ['268', false, '2207', '1234']
      it_splits '2685501234', ['268', false, '550', '1234']
    end
    describe 'Syrian Arab Republic' do
      it_splits '963111234567', %w(963 11 123 4567)
      it_splits '963311234567', %w(963 31 123 4567)
      it_splits '96315731234', %w(963 15 731 234)
      it_splits '963912345678', %w(963 9 1234 5678)
    end
    describe 'Taiwan' do
      it_splits '88618123456', %w(886 18 123 456)
      it_splits '8866121234567', %w(886 612 123 4567)
      it_splits '886212345678', %w(886 2 1234 5678)
      it_splits '88631234567', %w(886 3 123 4567)
      it_splits '88633123456', %w(886 33 123 456)
      it_splits '88682712345', %w(886 827 123 45)
      it_splits '8864121234', %w(886 412 1234)
      it_splits '88690123456', %w(886 90 123 456)
      it_splits '886901234567', %w(886 90 123 4567)
      it_splits '88694991345', %w(886 94 991 345)
    end
    describe 'Togolese Republic' do
      it_splits '22812345678', ['228', false, '1234', '5678']
    end
    describe 'Tajikistan' do
      it_splits '992313012345', %w(992 3130 123 45)
      it_splits '992331700123', %w(992 331700 123)
      it_splits '992372123345', %w(992 372 123 345)
      it_splits '992505123456', %w(992 505 123 456)
      it_splits '992973123456', %w(992 973 123 456)
      it_splits '992474456123', %w(992 474 456 123)
    end
    describe 'Tokelau' do
      it_splits '6901371', %w(690 1 371)
    end
    describe 'Tonga (Kingdom of)' do
      it_splits '67620123', ['676', false, '20', '123']
      it_splits '67684123', ['676', false, '84', '123']
      it_splits '6767712345', ['676', false, '77', '123', '45']
      it_splits '6768912345', ['676', false, '89', '123', '45']
    end
    describe 'Tuvalu' do
      it_splits '68893741', ['688', false, '93741']
    end
    describe 'Turkmenistan' do
      it_splits '99312456789', %w(993 12 456 789)
      it_splits '99313145678', %w(993 131 456 78)
      it_splits '99313924567', %w(993 1392 4567)
      it_splits '99361234567', %w(993 6 123 4567)
    end
    describe 'Ukraine' do
      it_splits '380800123456', %w(380 800 123 456)
      it_splits '380312123456', %w(380 312 123 456)
      it_splits '380320123456', %w(380 32 0123 456)
      it_splits '380325912345', %w(380 3259 123 45)
      it_splits '380326061234', %w(380 32606 1234)
      it_splits '380981234567', %w(380 981 234 567)
    end
    describe 'United Arab Emirates' do
      it_splits '97180012', %w(971 800 12)
      it_splits '971800123456789', %w(971 800 12 345 6789)
      it_splits '97121234567', %w(971 2 123 4567)
      it_splits '971506412345', %w(971 50 641 2345)
      it_splits '971600641234', %w(971 600 641 234)
      it_splits '971500641234', %w(971 500 641 234)
      it_splits '971200641234', %w(971 200 641 234)
    end
    describe 'Uruguay (Eastern Republic of)' do
      it_splits '59880012345', %w(598 800 123 45)
      it_splits '59820123456', %w(598 2 012 3456)
      it_splits '59821123456', %w(598 21 123 456)
      it_splits '59890912345', %w(598 909 123 45)
      it_splits '59893123456', %w(598 93 123 456)
      it_splits '59890812345', %w(598 908 123 45)
      it_splits '59880512345', %w(598 805 123 45)
    end
    describe 'Uzbekistan (Republic of)' do
      it_splits '998433527869', %w(998 43 352 7869)
    end
    describe 'Vanuatu (Republic of)' do
      it_splits '67889683', ['678', false, '89', '683']
    end
    describe 'Yemen' do
      it_splits '9671234567', %w(967 1 234 567)
      it_splits '96712345678', %w(967 1 234 5678)
      it_splits '9677234567', %w(967 7 234 567)
      it_splits '967771234567', %w(967 77 123 4567)
      it_splits '967581234', %w(967 58 1234)
    end
    describe 'Zimbabwe' do
      it_splits  '2632582123456', %w(263 2582 123 456)
      it_splits  '2632582123', %w(263 2582 123)
      it_splits  '263147123456', %w(263 147 123 456)
      it_splits  '263147123', %w(263 147 123)
      it_splits  '263270123456', %w(263 270 123 456)
      it_splits  '26327012345', %w(263 270 123 45)
      it_splits  '2638612354567', %w(263 86 1235 4567)
    end
  end

end
