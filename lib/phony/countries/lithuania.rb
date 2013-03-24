# put in it's own file, because it has a trunk code of 8

#country '370',
#        one_of('700', '800')  >> split(2,3)   | # Service
#        match(/^(6\d\d)\d+$/) >> split(2,3)   | # Mobile
#        one_of('5')           >> split(3,2,2) | # Vilnius
#        one_of('37','41')     >> split(2,2,2) | # Kaunas, Šiauliai
#        fixed(3)              >> split(1,2,2),  # 3-digit NDCs.
#        length(8)

handlers = []
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Variable.new(nil, %w{ 700 800 }),
  Phony::LocalSplitters::Fixed.instance_for([2, 3]),
  true, '8'
)
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Regex.new(/^(6\d\d)\d+$/),
  Phony::LocalSplitters::Fixed.instance_for([2, 3]),
  true, '8'
)
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Variable.new(nil, %w{ 5 }),
  Phony::LocalSplitters::Fixed.instance_for([3, 2, 2]),
  true, '8'
)
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Variable.new(nil, %w{ 37 41 }),
  Phony::LocalSplitters::Fixed.instance_for([2, 2, 2]),
  true, '8'
)
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Fixed.new(3),
  Phony::LocalSplitters::Fixed.instance_for([1, 2, 2]),
  true, '8'
)

Phony.define do
  country '370', Phony::Country.new(*handlers)
end
