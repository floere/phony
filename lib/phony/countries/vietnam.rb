# frozen_string_literal: true

# Vietnamese phone numbers.
#
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Vietnam
# http://www.wtng.info/wtng-84-vn.html
#
# Landline numbers are composed of 1 to 3 digit area code + 5 to 8 digits
# Mobile numbers are composed of 0 (trunk) + 2 to 3 digit carrier code + 5 to 8 digits
#

ndcs_with_7_subscriber_digits = [
  '203', # Quảng Ninh Province
  '204', # Bắc Giang (From 15 April 2017)
  '205', # Lạng Sơn Province
  '206', # Cao Bằng Province
  '207', # Tuyên Quang Province
  '208', # Thái Nguyên Provine
  '209', # Bắc Kạn Province
  '210', # Phú Thọ Province
  '211', # Vĩnh Phúc Province
  '212', # Sơn La Province
  '213', # Lai Châu
  '214', # Lào Cai Province
  '215', # Điện Biên Province
  '216', # Yên Bái Province
  '218', # Hòa Bình Province
  '219', # Hà Giang Province
  '220', # Hải Dương Province
  '221', # Hưng Yên Province
  '222', # Bắc Ninh Province
  '225', # Hải Phòng Province
  '226', # Hà Nam Province
  '227', # Thái Bình Province
  '228', # Nam Định Province
  '229', # Ninh Bình Province
  '232', # Quảng Bình Province
  '233', # Quảng Trị Province
  '234', # Thừa Thiên Huế Province
  '235', # Quảng Nam Province
  '236', # Đà Nẵng Province
  '237', # Thanh Hóa Province
  '238', # Nghệ An Province
  '239', # Hà Tĩnh Province
  '251', # Đồng Nai Province
  '252', # Bình Thuận Province
  '254', # Bà Rịa Vũng Tàu Province
  '255', # Quảng Ngãi Province
  '256', # Bình Định Province
  '257', # Phú Yên Province
  '258', # Khánh Hòa Province
  '259', # Ninh Thuận Province
  '260', # Kon Tum Province
  '261', # Đăk Nông Province
  '262', # Đăk Lăk Province
  '263', # Lâm Đồng Province
  '269', # Gia Lai Province
  '270', # Vĩnh Long Province
  '271', # Bình Phước Province
  '272', # Long An Province
  '273', # Tiền Giang Province
  '274', # Bình Dương Province
  '275', # Bến Tre Province
  '276', # Tây Ninh Province
  '277', # Đồng Tháp Province
  '290', # Cà Mau Province
  '291', # Bạc Liêu Province
  '292', # Cần Thơ Province
  '293', # Hậu Giang Province
  '294', # Trà Vinh Province
  '296', # An Giang Province
  '297', # Kiên Giang Province
  '299', # Sóc Trăng Province
]

ndcs_with_8_subscriber_digits = [
  '4',  # Hà Nội Province
  '24', # Hà Nội Province
  '28', # Hồ Chí Minh Province
  '8',  # Hồ Chí Minh Province
]

mobile = [
  '32', # Viettel Mobile
  '33', # Viettel Mobile
  '34', # Viettel Mobile
  '35', # Viettel Mobile
  '36', # Viettel Mobile
  '37', # Viettel Mobile
  '38', # Viettel Mobile
  '39', # Viettel Mobile
  '52', # Vietnammobile
  '56', # Vietnamobile
  '58', # Vietnamobile (previously known as HT Mobile)
  '59',  # GTel (traded as Beeline)
  '70', # MobiFone
  '76', # MobiFone
  '77', # MobiFone
  '78', # MobiFone
  '79', # MobiFone
  '81', # Vinaphone
  '82', # Vinaphone
  '83', # Vinaphone
  '84', # Vinaphone
  '85', # Vinaphone
  '86', # Viettel
  '88', # Vinaphone
  '89',  # MobiFone,
  '90', # MobiFone
  '91', # Vinaphone
  '92', # Vietnamobile (previously known as HT Mobile)
  '93', # MobiFone
  '94', # Vinaphone
  '96', # previously EVN Telecom, now Viettel Mobile
  '97', # Viettel Mobile
  '98', # Viettel Mobile
  '99', # Gmobile (traded as Beeline)
]

mobile_with_trunk = (mobile).map{ |num| "0#{num}" }

Phony.define do
  country '84',
    trunk('0') |
    one_of(mobile)                        >> split(4..8)|
    one_of(ndcs_with_7_subscriber_digits) >> split(3,4) |
    one_of(ndcs_with_8_subscriber_digits) >> split(4,4) |
    one_of(mobile_with_trunk)             >> split(5..8)|
    # Govt reserved
    fixed(80)                             >> split(5)   |
    fixed(69)                             >> split(1,5)
end
