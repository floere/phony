# encoding: utf-8
#
require 'spec_helper'

describe 'country descriptions' do

  describe 'splitting' do
    describe 'Afghanistan' do
      it { Phony.split('93201234567').should == ['93', '20', '1234567'] } # Kabul
    end
    describe 'Algeria' do
      it { Phony.split('213211231234').should == ['213', '21', '123', '1234'] } # Algiers
      it { Phony.split('213331231234').should == ['213', '33', '123', '1234'] } # Batna
    end
    describe 'Argentina' do
      it { Phony.split('541112345678').should == ['54', '11', '1234', '5678']   }
      it { Phony.split('542911234567').should == ['54', '291', '123', '4567']   }
      it { Phony.split('542965123456').should == ['54', '2965', '12', '3456']   }
      it { Phony.split('5491112345678').should == ['54', '911', '1234', '5678'] }
      it { Phony.split('5492201234567').should == ['54', '9220', '123', '4567'] }
      it { Phony.split('5492221123456').should == ['54', '92221', '12', '3456'] }
    end
    describe 'Austria' do
      it { Phony.split('43198110').should == ['43', '1', '98110']               } # Vienna
      it { Phony.split('4366914093902').should == ['43', '669', '14093902']     } # Mobile
      it { Phony.split('433161234567891').should == ['43', '316', '1234567891'] } # Graz
      it { Phony.split('432164123456789').should == ['43', '2164', '123456789'] } # Rohrau
    end
    describe 'Australia' do
      it { Phony.split('61512341234').should == ['61', '5', '1234', '1234'] } # Landline
      it { Phony.split('61423123123').should == ['61', '423', '123', '123'] } # Mobile
    end
    describe 'Belgium' do
      it { Phony.split('3235551212').should == ['32', '3', '555', '1212']   } # Antwerpen
      it { Phony.split('32505551212').should == ['32', '50', '555', '1212'] } # Brugge
      it { Phony.split('3225551212').should == ['32', '2', '555', '1212']   } # Brussels
      it { Phony.split('3295551914').should == ['32', '9', '555', '1914']   } # Gent
      it { Phony.split('3245551414').should == ['32', '4', '555', '1414']   } # Liège
      it { Phony.split('3216473200').should == ['32', '16', '473', '200']   } # Leuven
      it { Phony.split('32475279584').should == ['32', '475', '279584']     } # mobile
      it { Phony.split('3270123123').should == ['32', '70', '123', '123']   } # Bus Service?
    end
    describe 'Brazil' do
      it { Phony.split('551112341234').should == ['55', '11', '1234', '1234'] }
    end
    describe 'Chile' do
      it { Phony.split('5621234567').should == ['56', '2', '1234567']       } # Santiago
      it { Phony.split('5675123456').should == ['56', '75', '123456']       } # Curico
      it { Phony.split('56912345678').should == ['56', '9', '12345678']     } # Mobile
      it { Phony.split('56137123456').should == ['56', '137', '123', '456'] } # Service
    end
    describe 'China' do
      it { Phony.split('862112345678').should == ['86', '21', '1234', '5678']   } # Shanghai
      it { Phony.split('8675582193447').should == ['86', '755', '8219', '3447'] } # Shenzhen
    end
    describe 'Croatia' do
      it { Phony.split('385112312345').should == ['385', '1', '123', '12345'] } # Zagreb
      it { Phony.split('385491231234').should == ['385', '49', '123', '1234'] } # Krapina
    end
    describe 'Cuba' do
      it { Phony.split('5351231234').should == ['53', '5123', '1234'] } # Mobile
      it { Phony.split('5371234567').should == ['53', '7', '1234567'] } # Havana
      it { Phony.split('5342123456').should == ['53', '42', '123456'] } # Villa Clara
    end
    describe 'Denmark' do
      it { Phony.split('4532121212').should == ['45', false, '32', '12', '12', '12'] }
    end
    describe 'Egypt' do
      it { Phony.split('20212345678').should == ['20', '2', '12345678'] }
      it { Phony.split('20921234567').should == ['20', '92', '1234567'] }
      it { Phony.split('20951234567').should == ['20', '95', '1234567'] }
    end
    describe 'Finland' do
      it { Phony.split('3589123123').should == ['358', '9', '123', '123'] } # Helsinki
      it { Phony.split('3581912312').should == ['358', '19', '123', '12'] } # Nylandia
      it { Phony.split('3585012312').should == ['358', '50', '123', '12'] } # Mobile
      it { Phony.split('358600123').should  == ['358', '600', '123']      } # Service
    end
    describe 'France' do
      it { Phony.split('33112345678').should == ['33', '1', '12','34','56','78'] } # Paris
      it { Phony.split('33812345678').should == ['33', '8', '12','34','56','78'] } # Service number
    end
    describe 'Germany' do
      it { Phony.split('493038625454').should  == ['49', '30', '386', '25454']  } # Berlin
      it { Phony.split('4932221764542').should == ['49', '32', '221', '764542'] } # Non-Geographical
      it { Phony.split('4922137683323').should == ['49', '221', '376', '83323'] } # Cologne
      it { Phony.split('497614767676').should  == ['49', '761', '476', '7676']  } # Freiburg im Breisgau
      it { Phony.split('4921535100').should    == ['49', '2153', '510', '0']    } # Nettetal-Lobberich
      it { Phony.split('493434144602').should  == ['49', '34341', '446', '02']  } # Geithain
      it { Phony.split('491805878323').should  == ['49', '180', '587', '8323']  } # Service number
      it { Phony.split('491815878323').should  == ['49', '181', '587', '8323']  } # Service number
    end
    describe 'Ghana' do
      it { Phony.split('233302123456').should == ['233', '30', '212', '3456'] } # Mobile Vodafone, Accra
    end
    describe 'Greece' do
      it { Phony.split('3021123456').should == ['30', '21', '123456']     } # Athens
      it { Phony.split('3069512345').should == ['30', '695', '12345']     } # Mobile
      it { Phony.split('302108131234').should == ['30', '21', '08131234'] } # Long mobile, noted by vilcsak in pull request #26.
      it { Phony.split('3025941234').should == ['30', '2594', '1234']     }
      it { Phony.split('3022631234').should == ['30', '2263', '1234']     }
    end
    describe 'Hungary' do
      it { Phony.split('3612345678').should == ['36', '1', '234', '5678'] }
      it { Phony.split('3622123456').should == ['36', '22', '123', '456'] }
    end
    describe 'Iceland' do
      it { Phony.split('354112').should == ['354', false, '112']             } # Emergency TODO
      it { Phony.split('3544211234').should == ['354', false, '421', '1234'] } # Keflavík
      it { Phony.split('3544621234').should == ['354', false, '462', '1234'] } # Akureyri
      it { Phony.split('3545511234').should == ['354', false, '551', '1234'] } # Reykjavík
    end
    describe 'Ireland' do
      it { Phony.split('35311234567').should  == ['353', '1', '123', '4567']  } # Dublin, 7 digit subscriber #
      it { Phony.split('3532212345').should   == ['353', '22', '12345']       } # Mallow, 5 digit subscriber #
      it { Phony.split('35345123456').should  == ['353', '45', '123456']      } # Naas, 6 digit subscriber #
      it { Phony.split('353801234567').should == ['353', '80', '123', '4567'] } # Mobile
      it { Phony.split('353761234567').should == ['353', '76', '123', '4567'] } # VoIP
      it { Phony.split('353800123456').should == ['353', '800', '123456']     } # Freefone
      it { Phony.split('353000123456').should == ['353', '000', '123456']     } # Default fixed 3 split for unrecognized
    end
    describe 'Italy' do
      it { Phony.split('3934869528').should   == ['39', '3486', '952', '8']   } # Mobile
      it { Phony.split('390612341234').should == ['39', '06', '1234', '1234'] } # Roma
      it { Phony.split('390909709511').should == ['39', '090', '970', '9511'] } # Barcellona
    end
    describe 'Kenya' do
      it { Phony.split('254201234567').should == ['254', '20', '1234567'] } # Nairobi
      it { Phony.split('254111234567').should == ['254', '11', '1234567'] } # Mombasa
    end
    describe 'Lithuania' do
      it { Phony.split('37070012123').should == ['370', '700', '12', '123']     } # Service
      it { Phony.split('37061212123').should == ['370', '612', '12', '123']     } # Mobile
      it { Phony.split('37051231212').should == ['370', '5', '123', '12', '12'] } # Vilnius
      it { Phony.split('37037121212').should == ['370', '37', '12', '12', '12'] } # Kaunas
      it { Phony.split('37044011212').should == ['370', '440', '1', '12', '12'] } # Skuodas
    end
    describe 'Malaysia' do
      it { Phony.split('6082123456').should == ['60', '82', '123456']   } # Kuching
      it { Phony.split('60312345678').should == ['60', '3', '12345678'] } # Kuala Lumpur
      it { Phony.split('60212345678').should == ['60', '2', '12345678'] } # Singapore
    end
    describe 'Mexico' do
      it { Phony.split('525512121212').should == ['52', '55', '12', '12', '12', '12'] } # Mexico City
      it { Phony.split('526641231212').should == ['52', '664', '123', '12', '12']     } # Tijuana
    end
    describe 'The Netherlands' do
      it { Phony.split('31612345678').should == ['31', '6', '12345678'] } # mobile
      it { Phony.split('31201234567').should == ['31', '20', '1234567'] } 
      it { Phony.split('31222123456').should == ['31', '222', '123456'] } 
    end
    describe 'Norway' do
      Phony.split('4721234567').should == ['47',false,'21','23','45','67']
      Phony.split('4731234567').should == ['47',false,'31','23','45','67']
      Phony.split('4741234567').should == ['47',false,'412','34','567']
      Phony.split('4751234567').should == ['47',false,'51','23','45','67']
      Phony.split('4761234567').should == ['47',false,'61','23','45','67']
      Phony.split('4771234567').should == ['47',false,'71','23','45','67']
      Phony.split('4781234567').should == ['47',false,'812','34','567']
      Phony.split('4791234567').should == ['47',false,'912','34','567']
    end
    describe 'Peru' do
      Phony.split('51112341234').should == ['51', '1', '1234', '1234'] # Lima
      Phony.split('51912341234').should == ['51', '9', '1234', '1234'] # mobile
      Phony.split('51841234123').should == ['51', '84', '1234', '123'] # Cuzco, best effort
    end
    describe 'Poland' do
      Phony.split('48123456789').should == ['48', '12', '345', '67', '89'] # Landline
      Phony.split('48501123456').should == ['48', '501', '123', '456']     # Mobile
      Phony.split('48800123456').should == ['48', '800', '123', '456']     # Free
      Phony.split('48801123456').should == ['48', '801', '123', '456']     # Shared cost
      Phony.split('48701123456').should == ['48', '701', '123', '456']     # Premium
    end
    describe 'Portugal' do
      Phony.split('351211231234').should == ['351', '21', '123', '1234'] # Lisboa
      Phony.split('351241123123').should == ['351', '241', '123', '123'] # Abrantes
      Phony.split('351931231234').should == ['351', '93', '123', '1234'] # mobile
    end
    describe 'Romania' do
      it { Phony.split('40211231234').should == ['40', '21', '123', '1234'] } # Bucureşti
      it { Phony.split('40721231234').should == ['40', '72', '123', '1234'] } # mobile
      it { Phony.split('40249123123').should == ['40', '249', '123', '123'] } # Olt
    end
    describe 'Russia' do
      it { Phony.split('78122345678').should == ['7', '812', '234', '56', '78'] } # Russia 3-digit
      it { Phony.split('74012771077').should == ['7', '4012', '77', '10', '77'] } # Russia 4-digit
      it { Phony.split('78402411212').should == ['7', '84024', '1', '12', '12'] } # Russia 5-digit
      it { Phony.split('7840121212').should  == ['7', '840', '12', '12', '12']  } # Abhasia
      it { Phony.split('7209175276').should  == ['7', '209', '17', '52', '76']  } # Fantasy number
    end
    describe 'South Korea' do
      it { Phony.split('82212345678').should  == ['82', '2', '1234', '5678']  } # Seoul
      it { Phony.split('825112345678').should == ['82', '51', '1234', '5678'] } # Busan
      it { Phony.split('821027975588').should == ['82', '10', '2797', '5588'] } # mobile
      it { Phony.split('821087971234').should == ['82', '10', '8797', '1234'] } # mobile
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
      it { Phony.split('441412770011').should == ['44', '141', '277', '0011'] } # Glasgow
      it { Phony.split('441382229845').should == ['44', '1382', '229845'] }     # Dundee
      it { Phony.split('441204500532').should == ['44', '1204', '500532'] }     # Bolton
      it { Phony.split('44120462532').should  == ['44', '1204', '62532']  }     # Bolton
      it { Phony.split('441539648756').should == ['44', '15396', '48756'] }     # Sedbergh
      it { Phony.split('441697744555').should == ['44', '16977', '44555'] }     # Brampton
      it { Phony.split('44169772333').should  == ['44', '16977', '2333']  }     # Brampton
      it { Phony.split('443005878323').should == ['44', '300', '587', '8323'] } # Non-geographic
      it { Phony.split('443457777334').should == ['44', '345', '777', '7334'] } # Non-geographic
      it { Phony.split('44500557788').should  == ['44', '500', '557788'] }      # Freefone
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