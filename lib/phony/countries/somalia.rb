# frozen_string_literal: true

Phony.define do
  # Somali Democratic Republic http://www.wtng.info/wtng-252-so.html
  # https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=SO
  # https://en.wikipedia.org/wiki/Telecommunications_in_Somaliland#Telesom
  country '252',
    one_of('88216') >> split(3) | # Thuraya Satellite Telecommunications Company
    one_of(%w(1034 1043)) >> split(3,2) | # Hortel
    one_of(%w(1313)) >> split(3) | # Telcom Somalia
    one_of(%w(160 161 162 163 164 165 166 167 168)) >> split(2,2) | # Hortel
    one_of(%w(200 203 211 212 213 313)) >> split(3) | # Telcom Somalia
    one_of(%w(201 204 208 210 214)) >> split(2,2) | # Telcom Somalia
    one_of(%w(500 501 502 503 504 505 506 507 508 509)) >> split(3,2) | # mobile NationLink Telecom
    one_of(%w(523 525 526)) >> split(2,2) | # Netco
    match(/\A(61|62|63|64|65|66|67|68|69|90)\d{7}\z/) >> split(3,4) | # mobile Hormuud, Somtel Mogadishu, Telesom, Hormuud, Somtel, Somtel Puntland, Nationlink Mogadishu, Nationlink Mogadishu, Nationlink, Golis
    one_of(%w(642 643 644 648 649)) >> split(2,2) | # Galcom
    one_of(%w(33 51 52 54 55 56 57 58 59 68 71 76 78 79 88)) >> split(3,2) |
    match(/\A(67)\d{5}\z/) >> split(3,2) | # Golis Telecom Somalia
    one_of(%w(15 40 42 45 46 60 61 90 91)) >> split(3,3) | # mobile Somafone, Hortel
    one_of(%w(18)) >> split(3,2) | # Hortel
    one_of(%w(27 28 29 62 63 87)) >> split(2,2) | # Telcom Somalia, Emir Set
    one_of(%w(67 69)) >> split(4,3) | # mobile NationLink Telecom
    one_of('1') >> split(3,3) |
    fixed(1) >> split(3,3)
end
