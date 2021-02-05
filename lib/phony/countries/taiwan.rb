# frozen_string_literal: true

# Taiwan
# https://zh.wikipedia.org/wiki/%E4%B8%AD%E8%8F%AF%E6%B0%91%E5%9C%8B%E9%95%B7%E9%80%94%E9%9B%BB%E8%A9%B1%E5%8D%80%E8%99%9F%E8%A1%A8
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Taiwan

Phony.define do
  country '886',
    trunk('0') |
    match(/\A(826)\d{5}\z/) >> split(1,4) | # 烏坵, start with 0826, plus 5 digits
    match(/\A(836)\d{5}\z/) >> split(1,4) | # 馬祖, start with 0836, plus 5 digits
    match(/\A(82)\d{6}\z/)  >> split(2,4) | # 金門, start with 082, plus 6 digits
    match(/\A(89)\d{6}\z/)  >> split(2,4) | # 臺東, start with 089, plus 6 digits
    match(/\A(8)\d{7}\z/)   >> split(3,4) | # 屏東, start with 08, plus 7 digits
    match(/\A(49)\d{7}\z/)  >> split(3,4) | # 南投, start with 049, plus 7 digits
    one_of(%w(4)) >> matched_split(
       /\A\d{7}\z/          =>      [3,4],  # 彰化, start with 04, plus 7 digits
       /\A\d+\z/            =>      [4,4])| # 臺中, start with 04, plus 8 digits
    match(/\A(37)\d{6}\z/)  >> split(2,4) | # 苗栗, start with 037, plus 6 digits
    match(/\A(3)\d{7}\z/)   >> split(3,4) | # 桃園 新竹 花蓮 宜蘭, start with 03, plus 7 digits
    match(/\A(5)\d{7}\z/)   >> split(3,4) | # 嘉義 雲林, start with 05, plus 7 digits
    match(/\A(6)\d{7}\z/)   >> split(3,4) | # 臺南 澎湖, start with 06, plus 7 digits
    match(/\A(7)\d{7}\z/)   >> split(3,4) | # 高雄, start with 07, plus 7 digits
    match(/\A(2)\d{8}\z/)   >> split(4,4) | # 臺北, start with 02, plus 8 digits
    match(/\A(9\d\d)\d{6}\z/)   >> split(3,3) | # mobile phone, start with 09, plus 8 digits, but local usually show 4-3-3.
    fixed(2)                >> split(4,4)   # fallback unknown
end
