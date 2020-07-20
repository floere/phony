# frozen_string_literal: true

# Belarus
# http://www.eng.beltelecom.by/en/subscribers/phone-codes
# https://www.numberingplans.com

ndcs_with_5_subscriber_digits = %w(
1511
1512
1513
1514
1515
1562
1563
1564
1591
1592
1593
1594
1595
1596
1597
1631
1632
1633
1641
1642
1643
1644
1645
1646
1647
1651
1652
1655
1713
1714
1715
1716
1717
1718
1719
1770
1771
1772
1774
1775
1776
1792
1793
1794
1795
1796
1797
2130
2131
2132
2133
2135
2136
2137
2138
2139
2151
2152
2153
2154
2155
2156
2157
2158
2159
2230
2231
2232
2233
2234
2235
2236
2237
2238
2239
2240
2241
2242
2243
2244
2245
2246
2247
2248
2330
2332
2333
2334
2336
2337
2339
2340
2342
2344
2345
2346
2347
2350
2353
2354
2355
2356
2357
)

ndcs_with_6_subscriber_digits = %w(152 154 162 163 165 174 176 177 212 214 216 222 225 232 236 602)

ndcs_with_7_subscriber_digits = %w(17 25 29 33 44)

Phony.define do
  country '375',
          trunk('80?') |
          one_of(ndcs_with_5_subscriber_digits) >> split(5) |
          one_of(ndcs_with_6_subscriber_digits) >> split(6) |
          one_of(ndcs_with_7_subscriber_digits) >> split(7) |
          # not available from abroad
          one_of(%w(600)) >> split(3) |
          one_of(%w(606 777 801 803 805 810 902)) >> split(7) |
          one_of(%w(820)) >> split(8) |
          # Non-geographic number - Home country direct service
          # Assigned to Beltelecom - not available from abroad
          match(/\A(800)\d{3}\z/) >> split(3) |
          match(/\A(800)\d{4}\z/) >> split(4) |
          match(/\A(800)\d{7}\z/) >> split(7)
end

