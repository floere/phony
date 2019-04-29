# frozen_string_literal: true

# Zimbabwe, https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=ZW
# http://www.itu.int/dms_pub/itu-t/oth/02/02/T02020000E90002PDFE.pdf

Phony.define do
  country '263',
    trunk('0', normalize: true) |
    one_of(%w(2582 2583 5483)) >>
    matched_split(/\A\d{6}\z/ => [3,3],
                  /\A\d+\z/ => [3] ) | # geographic [XXXX] XXX(XXX)
    one_of(%w(147 204 205 222 227 228 238 248 2582 2583 271 272 274 276 281 283
            284 286 287 288 289 298 308 317 371 375 376 379 383 387 389 517 518
            557 558 628 637 667 668 687 688 698 848)) >>
        matched_split(/\A\d{6}\z/ => [3,3],
                      /\A\d+\z/ => [3] ) | # geographic [XXX] XXX(XXX)
    one_of(%w(270)) >>
        matched_split(/\A\d{6}\z/ => [3,3],
                      /\A\d+\z/ => [3,2] ) | # geographic [XXX] XXXXX(X)
    one_of(%w(273 275 277 278 279 282 285)) >>
        matched_split(/\A\d{6}\z/ => [3,3],
                      /\A\d+\z/ => [2,2] ) | # geographic [XXX] XXXX(XX)
    one_of(%w(13 14 15 16 17 18 19 21 24 26 29 30 31 32 34 35 36 50 55 57 58 59 60
            63 64 65 66 69)) >>
        matched_split(/\A\d{6}\z/ => [3,3],
                      /\A\d+\z/ => [3] ) | # geographic [XX] XXX(XXX)
    one_of(%w(20)) >>
        matched_split(/\A\d{6}\z/ => [3,3],
                      /\A\d+\z/ => [3,2] ) | # geographic [XXX] XXXXX(X)
    one_of(%w(25 33 39 51 52 53 54 56 61 62 67 68 )) >>
        matched_split(/\A\d{6}\z/ => [3,3],
                      /\A\d+\z/ => [2,2] ) | # geographic [XXX] XXXX(XX)
    one_of(%w(86)) >> split(4,4) | # VoIP telephony
    one_of(%w(71 73 77 78)) >> split(3,4) | # mobile
    one_of(%w(4 9)) >>
        matched_split(/\A\d{6}\z/ => [4,4],
                      /\A\d+\z/ => [3,2] ) | # geographic [X] XXXXX(XXX)
    fixed(2) >> split(3,3)
end
