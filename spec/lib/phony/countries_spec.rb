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
    describe 'Brazil' do
      it_splits '551112341234', ['55', '11', '1234', '1234']
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
    describe 'Germany' do
      it_splits '493038625454',  ['49', '30', '386', '25454']  # Berlin
      it_splits '4932221764542', ['49', '32', '221', '764542'] # Non-Geographical
      it_splits '4922137683323', ['49', '221', '376', '83323'] # Cologne
      it_splits '497614767676',  ['49', '761', '476', '7676']  # Freiburg im Breisgau
      it_splits '4921535100',    ['49', '2153', '510', '0']    # Nettetal-Lobberich
      it_splits '493434144602',  ['49', '34341', '446', '02']  # Geithain
      it_splits '491805878323',  ['49', '180', '587', '8323']  # Service number
      it_splits '491815878323',  ['49', '181', '587', '8323']  # Service number
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
      it_splits '3021123456', ['30', '21', '123456']     # Athens
      it_splits '3069512345', ['30', '695', '12345']     # Mobile
      it_splits '302108131234', ['30', '21', '08131234'] # Long mobile, noted by vilcsak in pull request #26.
      it_splits '3025941234', ['30', '2594', '1234']
      it_splits '3022631234', ['30', '2263', '1234']
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
    describe 'Italy' do
      it_splits '3934869528',   ['39', '3486', '952', '8']   # Mobile
      it_splits '390612341234', ['39', '06', '1234', '1234'] # Roma
      it_splits '390909709511', ['39', '090', '970', '9511'] # Barcellona
    end
    describe 'Kenya' do
      it_splits '254201234567', ['254', '20', '1234567'] # Nairobi
      it_splits '254111234567', ['254', '11', '1234567'] # Mombasa
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
      it_splits '6082123456', ['60', '82', '123456']   # Kuching
      it_splits '60312345678', ['60', '3', '12345678'] # Kuala Lumpur
      it_splits '60212345678', ['60', '2', '12345678'] # Singapore
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
    describe 'Morocco' do
      it_splits '212537718685', ['212', '53', '7718', '685']
    end
    describe 'The Netherlands' do
      it_splits '31612345678', ['31', '6', '12345678'] # mobile
      it_splits '31201234567', ['31', '20', '1234567']
      it_splits '31222123456', ['31', '222', '123456']
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
    describe 'Peru' do
      it_splits '51112341234', ['51', '1', '1234', '1234'] # Lima
      it_splits '51912341234', ['51', '9', '1234', '1234'] # mobile
      it_splits '51841234123', ['51', '84', '1234', '123'] # Cuzco, best effort
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
    describe 'Romania' do
      it_splits '40211231234', ['40', '21', '123', '1234'] # Bucureşti
      it_splits '40721231234', ['40', '72', '123', '1234'] # mobile
      it_splits '40249123123', ['40', '249', '123', '123'] # Olt
    end
    describe 'Russia' do
      it_splits '78122345678',   ['7', '812', '234', '56', '78'] # Russia 3-digit
      it_splits '74012771077',   ['7', '4012', '77', '10', '77'] # Russia 4-digit
      it_splits '78402411212',   ['7', '84024', '1', '12', '12'] # Russia 5-digit
      it_splits '7840121212',    ['7', '840', '12', '12', '12']  # Abhasia
      it_splits '7799121212',    ['7', '799', '12', '12', '12']  # Kazachstan
      it_splits '7995344121212', ['7','995344','12','12','12']   # South Osetia
      it_splits '7209175276',    ['7', '209', '17', '52', '76']  # Fantasy number
    end
    describe 'South Korea' do
      it { Phony.split('82212345678').should  == ['82', '2', '1234', '5678']  } # Seoul
      it { Phony.split('825112345678').should == ['82', '51', '1234', '5678'] } # Busan
      it { Phony.split('821027975588').should == ['82', '10', '2797', '5588'] } # mobile
      it { Phony.split('821087971234').should == ['82', '10', '8797', '1234'] } # mobile
    end
    describe 'Sudan' do
      it_splits '249187171100', ['249', '18', '717', '1100']
    end
    describe 'Thailand' do
      it { Phony.split('6621231234').should == ['66', '2', '123', '1234'] } # Bangkok
      it { Phony.split('6636123123').should == ['66', '36', '123', '123'] } # Lop Buri
    end
    describe 'Tunesia' do
      it { Phony.split('21611231234').should == ['216', '1', '123', '1234'] } # Ariana
      it { Phony.split('21621231234').should == ['216', '2', '123', '1234'] } # Bizerte
    end
    describe 'Singapore' do
      it { Phony.split('6561231234').should == ['65', false, '6123', '1234'] } # Fixed line
    end
    describe 'Slovakia' do
      it { Phony.split('421912123456').should == ['421', '912', '123456'] } # Mobile
      it { Phony.split('421212345678').should == ['421', '2', '12345678'] } # Bratislava
      it { Phony.split('421371234567').should == ['421', '37', '1234567'] } # Nitra / Other
    end
    describe 'Sweden' do
      it { Phony.split('46812345678').should == ['46', '8', '12345678'] } # Stockholm
      it { Phony.split('46111234567').should == ['46', '11', '1234567'] }
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
      it { Phony.split('442075671113').should == ['44', '20', '7567', '1113'] } # London
      it { Phony.split('442920229901').should == ['44', '29', '2022', '9901'] } # Cardiff
      it { Phony.split('441134770011').should == ['44', '113', '477', '0011'] } # Leeds
      it { Phony.split('441412770022').should == ['44', '141', '277', '0022'] } # Glasgow
      it { Phony.split('441204500532').should == ['44', '1204', '500532'] }     # Bolton
      it { Phony.split('44120462532').should  == ['44', '1204', '62532']  }     # Bolton
      it { Phony.split('441382229845').should == ['44', '1382', '229845'] }     # Dundee
      it { Phony.split('441539248756').should == ['44', '1539', '248756'] }     # Kendal
      it { Phony.split('441539648788').should == ['44', '15396', '48788'] }     # Sedbergh
      it { Phony.split('441697222555').should == ['44', '1697', '222555'] }     # Brampton
      it { Phony.split('441697388555').should == ['44', '16973', '88555'] }     # Wigton
      it { Phony.split('44169772333').should  == ['44', '16977', '2333']  }     # Brampton
      it { Phony.split('441697744888').should == ['44', '16977', '44888'] }     # Brampton
      it { Phony.split('441946555777').should == ['44', '1946', '555777']  }    # Whitehaven
      it { Phony.split('44194662888').should  == ['44', '1946', '62888']  }     # Whitehaven
      it { Phony.split('441946722444').should == ['44', '19467', '22444']  }    # Gosforth
      it { Phony.split('443005878323').should == ['44', '300', '587', '8323'] } # Non-geographic
      it { Phony.split('443457777334').should == ['44', '345', '777', '7334'] } # Non-geographic
      it { Phony.split('44500557788').should  == ['44', '500', '557788'] }      # Freefone 500 + 6
      it { Phony.split('445575671113').should == ['44', '55', '7567', '1113'] } # Corporate
      it { Phony.split('445644775533').should == ['44', '56', '4477', '5533'] } # LIECS/VoIP
      it { Phony.split('447020229901').should == ['44', '70', '2022', '9901'] } # Personal numbers
      it { Phony.split('447780605207').should == ['44', '7780', '605207'] }     # Mobile
      it { Phony.split('447480605207').should == ['44', '7480', '605207'] }     # Mobile
      it { Phony.split('44800557788').should  == ['44', '800', '557788']  }     # Freefone 800 + 6
      it { Phony.split('448084682355').should == ['44', '808', '468', '2355'] } # Freefone
      it { Phony.split('448005878323').should == ['44', '800', '587', '8323'] } # Freefone, regression
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
    describe 'New Zealand' do
      it { Phony.split('6491234567').should == ['64', '9', '123', '4567'] }
    end
  end

end
