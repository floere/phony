# Vietnamese phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Vietnam
# http://www.wtng.info/wtng-84-vn.html
#
# Landline numbers are composed of 1 to 3 digit area code + 5 to 8 digits
# Mobile numbers are composed of 0 (trunk) + 2 to 3 digit carrier code + 5 to 8 digits
#

ndcs_with_7_subscriber_digits = [
  '20',  # Lào Cai Province
  '210', # Phú Thọ Province
  '211', # Vĩnh Phúc Province
  '218', # Hòa Bình Province (18 before 24 Nov 2007)
  '219', # Hà Giang Province (19 before 24 Nov 2007)
  '22',  # Sơn La Province
  '230', # Điện Biên Province (23 before 24 Nov 2007)
  '231', # Lai Châu Province (23 before 24 Nov 2007)
  '240', # Bắc Giang Province
  '241', # Bắc Ninh Province
  '25',  # Lạng Sơn Province
  '26',  # Cao Bằng Province
  '27',  # Tuyên Quang Province
  '280', # Thái Nguyên Province
  '281', # Bắc Kạn Province
  '29',  # Yên Bái Province

  '30',  # Ninh Bình Province
  '31',  # Hai Phong city
  '320', # Hải Dương Province
  '321', # Hưng Yên Province
  '33',  # Quảng Ninh Province
  '350', # Nam Định Province
  '351', # Hà Nam Province
  '36',  # Thái Bình Province
  '37',  # Thanh Hóa Province
  '38',  # Nghệ An Province
  '39',  # Hà Tĩnh Province

  '500', # Đắk Lắk Province (50 before 24 Nov 2007)
  '501', # Đắk Nông Province (50 before 24 Nov 2007)
  '510', # Quảng Nam Province
  '511', # Da Nang city
  '52',  # Quảng Bình Province
  '53',  # Quảng Trị Province
  '54',  # Thừa Thiên–Huế Province
  '55',  # Quảng Ngãi Province
  '56',  # Bình Định Province
  '57',  # Phú Yên Province
  '58',  # Khánh Hòa Province
  '59',  # Gia Lai Province

  '60',  # Kon Tum Province
  '61',  # Đồng Nai Province
  '62',  # Bình Thuận Province
  '63',  # Lâm Đồng Province
  '64',  # Bà Rịa–Vũng Tàu Province
  '650', # Bình Dương Province
  '651', # Bình Phước Province
  '66',  # Tây Ninh Province
  '67',  # Đồng Tháp Province
  '68',  # Ninh Thuận Province

  '70',  # Vĩnh Long Province
  '710', # Cần Thơ city (71 before 24 Nov 2007)
  '711', # Hậu Giang Province (71 before 24 Nov 2007)
  '72',  # Long An Province
  '73',  # Tiền Giang Province
  '74',  # Trà Vinh Province
  '75',  # Bến Tre Province
  '76',  # An Giang Province
  '77',  # Kiên Giang Province
  '780', # Cà Mau Province
  '781', # Bạc Liêu Province
  '79'   # Sóc Trăng Province
]

ndcs_with_8_subscriber_digits = [
  '4', # Hanoi
  '8'  # Ho Chi Minh City
]

mobile = [
  '90', # MobiFone
  '91', # Vinaphone
  '92', # Vietnamobile (previously known as HT Mobile)
  '93', # MobiFone
  '94', # Vinaphone
  '95', # S-Fone
  '96', # previously EVN Telecom, now Viettel Mobile
  '97', # Viettel Mobile
  '98', # Viettel Mobile
  '996', # Gmobile (traded as Beeline)
  '997', # Gmobile (traded as Beeline)
  '998', # Indochina Telecom
  '999', # Indochina Telecom
  '120', # MobiFone
  '121', # MobiFone
  '122', # MobiFone
  '123', # Vinaphone
  '124', # Vinaphone
  '125', # Vinaphone
  '126', # MobiFone
  '127', # Vinaphone
  '128', # MobiFone
  '129', # Vinaphone
  '163', # Viettel Mobile
  '164', # Viettel Mobile
  '165', # Viettel Mobile
  '166', # Viettel Mobile
  '167', # Viettel Mobile
  '168', # Viettel Mobile
  '169', # Viettel Mobile
  '186', # Vietnamobile
  '188', # Vietnamobile (previously known as HT Mobile)
  '199'  # GTel (traded as Beeline)
]

mobile_with_trunk = mobile.map{|num| "0#{num}" }

Phony.define do
  country '84',
    trunk('0') |
    one_of(ndcs_with_7_subscriber_digits) >> split(3,4) |
    one_of(ndcs_with_8_subscriber_digits) >> split(4,4) |
    one_of(mobile)                        >> split(5..8)|
    one_of(mobile_with_trunk)             >> split(5..8)|
    # Govt reserved
    fixed(80)                             >> split(5)   |
    fixed(69)                             >> split(1,5)
end
