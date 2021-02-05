# frozen_string_literal: true

# Moldova
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# https://www.numberingplans.com/?page=plans&sub=phonenr&alpha_2_input=MD

ndcs_with_6_subscriber_numbers = %w(22)
ndcs_with_5_subscriber_numbers = %w(
230
231
235
236
237
241
242
243
244
246
247
248
249
250
251
252
254
256
258
259
262
263
264
265
268
269
271
272
273
277
291
293
294
297
298
299
)

Phony.define do
  country '373',
          trunk('0') |
          one_of(ndcs_with_5_subscriber_numbers) >> split(3,2) |
          one_of(ndcs_with_6_subscriber_numbers) >> split(3,3) |
          fixed(3) >> split(3,2)
end
