# encoding: utf-8
#
require 'spec_helper'

describe 'country descriptions' do

  describe 'splitting' do
    it 'handles afghan numbers' do
      Phony.split('93201234567').should == ['93', '20', '1234567'] # Kabul
    end
    it 'handles algerian numbers' do
      Phony.split('213211231234').should == ['213', '21', '123', '1234'] # Algiers
      Phony.split('213331231234').should == ['213', '33', '123', '1234'] # Batna
    end
    it 'handles austrian numbers' do
      Phony.split('43198110').should == ['43', '1', '98110'] # Vienna
      Phony.split('4366914093902').should == ['43', '669', '14093902'] # Mobile
      Phony.split('433161234567891').should == ['43', '316', '1234567891'] # Graz
      Phony.split('432164123456789').should == ['43', '2164', '123456789'] # Rohrau
    end
    it 'handles australian numbers' do
      Phony.split('61512341234').should == ['61', '5', '1234', '1234'] # Landline
      Phony.split('61423123123').should == ['61', '423', '123', '123'] # Mobile
    end
    it 'handles belgian numbers' do
      Phony.split('3235551212').should == ['32', '3', '555', '1212']   # Antwerpen
      Phony.split('32505551212').should == ['32', '50', '555', '1212'] # Brugge
      Phony.split('3225551212').should == ['32', '2', '555', '1212']   # Brussels
      Phony.split('3295551914').should == ['32', '9', '555', '1914']   # Gent
      Phony.split('3245551414').should == ['32', '4', '555', '1414']   # Liège
      Phony.split('3216473200').should == ['32', '16', '473', '200']   # Leuven
      Phony.split('32475279584').should == ['32', '475', '279584']     # mobile
      Phony.split('3270123123').should == ['32', '70', '123', '123']   # Bus Service?
    end
    it 'handles brazilian numbers' do
      Phony.split('551112341234').should == ['55', '11', '1234', '1234']
    end
    it 'handles chilean numbers' do
      Phony.split('5621234567').should == ['56', '2', '1234567']       # Santiago
      Phony.split('5675123456').should == ['56', '75', '123456']       # Curico
      Phony.split('56912345678').should == ['56', '9', '12345678']     # Mobile
      Phony.split('56137123456').should == ['56', '137', '123', '456'] # Service
    end
    it 'handles chinese numbers' do
      Phony.split('862112345678').should == ['86', '21', '1234', '5678'] # Shanghai
      Phony.split('8675582193447').should == ['86', '755', '8219', '3447'] # Shenzhen
    end
    it 'handles croatian numbers' do
      Phony.split('385112312345').should == ['385', '1', '123', '12345'] # Zagreb
      Phony.split('385491231234').should == ['385', '49', '123', '1234'] # Krapina
    end
    it 'handles cuban numbers' do
      Phony.split('5351231234').should == ['53', '5123', '1234'] # Mobile
      Phony.split('5371234567').should == ['53', '7', '1234567'] # Havana
      Phony.split('5342123456').should == ['53', '42', '123456'] # Villa Clara
    end
    it 'handles danish numbers' do
      Phony.split('4532121212').should == ['45', '32', '12', '12', '12']
    end
    it 'handles dutch numbers' do
      Phony.split('31612345678').should == ['31', '6', '12345678'] # mobile
      Phony.split('31201234567').should == ['31', '20', '1234567']
      Phony.split('31222123456').should == ['31', '222', '123456']
    end
    it 'handles egyptian numbers' do
      Phony.split('20212345678').should == ['20', '2', '12345678']
      Phony.split('20921234567').should == ['20', '92', '1234567']
      Phony.split('20951234567').should == ['20', '95', '1234567']
    end
    it 'handles finnish numbers' do
      Phony.split('3589123123').should == ['358', '9', '123', '123'] # Helsinki
      Phony.split('3581912312').should == ['358', '19', '123', '12'] # Nylandia
      Phony.split('3585012312').should == ['358', '50', '123', '12'] # Mobile
      Phony.split('358600123').should  == ['358', '600', '123'] # Service
    end
    it 'handles french numbers' do
      Phony.split('33112345678').should == ['33', '1', '12','34','56','78']
    end
    it 'handles german numbers' do
      Phony.split('493038625454').should  == ['49', '30', '386', '25454'] # Berlin
      Phony.split('4922137683323').should == ['49', '221', '376', '83323'] # Cologne
      Phony.split('497614767676').should  == ['49', '761', '476', '7676'] # Freiburg im Breisgau
      Phony.split('4921535100').should    == ['49', '2153', '510', '0'] # Nettetal-Lobberich
      Phony.split('493434144602').should  == ['49', '34341', '446', '02'] # Geithain
      Phony.split('491805878323').should  == ['49', '180', '587', '8323'] # Service numbers
      Phony.split('491815878323').should  == ['49', '181', '587', '8323'] # Service numbers
    end
    it 'handles greek numbers' do
      Phony.split('3021123456').should == ['30', '21', '123456'] # Athens
      Phony.split('3069512345').should == ['30', '695', '12345'] # Mobile
      Phony.split('302108131234').should == ['30', '21', '08131234'] # Long mobile, noted by vilcsak in pull request #26.
      Phony.split('3025941234').should == ['30', '2594', '1234']
      Phony.split('3022631234').should == ['30', '2263', '1234']
    end
    it 'handles hungarian numbers' do
      Phony.split('3612345678').should == ['36', '1', '234', '5678']
      Phony.split('3622123456').should == ['36', '22', '123', '456']
    end
    it 'handles icelandic numbers' do
      Phony.split('354112').should == ['354', '112'] # Emergency TODO
      Phony.split('3544211234').should == ['354', '421', '1234'] # Keflavík
      Phony.split('3544621234').should == ['354', '462', '1234'] # Akureyri
      Phony.split('3545511234').should == ['354', '551', '1234'] # Reykjavík
    end
    it 'handles italian numbers' do
      Phony.split('3934869528').should == ['39', '3486', '952', '8']     # Mobile
      Phony.split('39068546705').should == ['39', '06', '854', '6705']   # Roma
      Phony.split('390909709511').should == ['39', '090', '970', '9511'] # Barcellona
    end
    it 'handles kenyan numbers' do
      Phony.split('254201234567').should == ['254', '20', '1234567'] # Nairobi
      Phony.split('254111234567').should == ['254', '11', '1234567'] # Mombasa
    end
    it 'handles lithuanian numbers' do
      Phony.split('37070012123').should == ['370', '700', '12', '123']     # Service
      Phony.split('37061212123').should == ['370', '612', '12', '123']     # Mobile
      Phony.split('37051231212').should == ['370', '5', '123', '12', '12'] # Vilnius
      Phony.split('37037121212').should == ['370', '37', '12', '12', '12'] # Kaunas
      Phony.split('37044011212').should == ['370', '440', '1', '12', '12'] # Skuodas
    end
    it 'handles malay numbers' do
      Phony.split('6082123456').should == ['60', '82', '123456'] # Kuching
      Phony.split('60312345678').should == ['60', '3', '12345678'] # Kuala Lumpur
      Phony.split('60212345678').should == ['60', '2', '12345678'] # Singapore
    end
    it 'handles mexican numbers' do
      Phony.split('525512121212').should == ['52', '55', '12', '12', '12', '12'] # Mexico City
      Phony.split('526641231212').should == ['52', '664', '123', '12', '12'] # Tijuana
    end
    it 'handles norwegian numbers' do
      Phony.split('4721234567').should == ['47','21','23','45','67']
      Phony.split('4731234567').should == ['47','31','23','45','67']
      Phony.split('4741234567').should == ['47','412','34','567']
      Phony.split('4751234567').should == ['47','51','23','45','67']
      Phony.split('4761234567').should == ['47','61','23','45','67']
      Phony.split('4771234567').should == ['47','71','23','45','67']
      Phony.split('4781234567').should == ['47','812','34','567']
      Phony.split('4791234567').should == ['47','912','34','567']
    end
    it 'handles peruvian numbers' do
      Phony.split('51112341234').should == ['51', '1', '1234', '1234'] # Lima
      Phony.split('51912341234').should == ['51', '9', '1234', '1234'] # mobile
      Phony.split('51841234123').should == ['51', '84', '1234', '123'] # Cuzco, best effort
    end
    it 'handles polish numbers' do
      Phony.split('48123123123').should == ['48', '123', '123', '123']
    end
    it 'handles portuguese numbers' do
      Phony.split('351211231234').should == ['351', '21', '123', '1234'] # Lisboa
      Phony.split('351241123123').should == ['351', '241', '123', '123'] # Abrantes
      Phony.split('351931231234').should == ['351', '93', '123', '1234'] # mobile
    end
    it 'handles romanian numbers' do
      Phony.split('40211231234').should == ['40', '21', '123', '1234'] # Bucureşti
      Phony.split('40721231234').should == ['40', '72', '123', '1234'] # mobile
      Phony.split('40249123123').should == ['40', '249', '123', '123'] # Olt
    end
    it 'handles russian numbers' do
      Phony.split('78122345678').should == ['7', '812', '234', '56', '78']
    end
    it 'handles south korean numbers' do
      Phony.split('82212345678').should == ['82', '2', '1234', '5678']   # Seoul
      Phony.split('825112345678').should == ['82', '51', '1234', '5678'] # Busan
      Phony.split('821027975588').should == ['82', '10', '2797', '5588'] # mobile
    end
    it 'handles thai numbers' do
      Phony.split('6621231234').should == ['66', '2', '123', '1234'] # Bangkok
      Phony.split('6636123123').should == ['66', '36', '123', '123'] # Lop Buri
    end
    it 'handles tunisian numbers' do
      Phony.split('21611231234').should == ['216', '1', '123', '1234'] # Ariana
      Phony.split('21621231234').should == ['216', '2', '123', '1234'] # Bizerte
    end
    it 'handles singaporean numbers' do
      Phony.split('6561231234').should == ['65', '6123', '1234'] # Fixed line
    end
    it 'handles slovakian numbers' do
      Phony.split('421912123456').should == ['421', '912', '123456'] # Mobile
      Phony.split('421212345678').should == ['421', '2', '12345678'] # Bratislava
      Phony.split('421371234567').should == ['421', '37', '1234567'] # Nitra / Other
    end
    it 'handles swedish numbers' do
      Phony.split('46812345678').should == ['46', '8', '12345678'] # Stockholm
      Phony.split('46111234567').should == ['46', '11', '1234567']
      Phony.split('46125123456').should == ['46', '125', '123456']
    end
    it 'handles swiss numbers' do
      Phony.split('41443643532').should == ['41', '44', '364', '35', '32']
    end
    it 'handles tanzanian numbers' do
      Phony.split('255221231234').should == ['255', '22', '123', '1234'] # Dar Es Salaam
      Phony.split('255651231234').should == ['255', '65', '123', '1234'] # TIGO
      Phony.split('255861123123').should == ['255', '861', '123', '123'] # Special Rates
    end
    it 'handles turkish numbers' do
      Phony.split('903121234567').should == ['90', '312', '123', '4567'] # Ankara
    end
    it 'handles ugandan numbers' do
      Phony.split('256414123456').should == ['256', '41', '4123456'] # Kampania
      Phony.split('256464441234').should == ['256', '464', '441234'] # Mubende
    end
    it 'handles UK numbers' do
      Phony.split('442045671113').should == ['44', '20', '4567', '1113'] # London
      Phony.split('442076229901').should == ['44', '20', '7622', '9901'] # Cardiff
      Phony.split('441136770011').should == ['44', '113', '677', '0011'] # Leeds
      Phony.split('441382229845').should == ['44', '1382', '229845'] # Dundee
      Phony.split('44120499532').should  == ['44', '1204', '99532'] # Bolten
      Phony.split('441539618756').should == ['44', '15396', '18756'] # Sedbergh
      Phony.split('447780605207').should == ['44', '7780', '605207'] # Mobile
      Phony.split('447480605207').should == ['44', '7480', '605207'] # Mobile
      Phony.split('448005878323').should == ['44', '800', '587', '8323'] # Service, regression
    end
    it 'handles US numbers' do
      Phony.split('15551115511').should == ['1', '555', '111', '5511']
    end
    it 'handles venezuelan numbers' do
      Phony.split('582121234567').should == ['58', '212', '1234567']
    end
    it 'handles new zealand numbers' do
      Phony.split('6491234567').should == ['64', '9', '123', '4567']
    end

    it 'handles french service numbers' do
      Phony.split('33812345678').should == ['33', '8', '12','34','56','78']
    end
    it 'handles swiss service numbers' do
      Phony.split('41800334455').should == ['41', '800', '334', '455']
    end
  end

end