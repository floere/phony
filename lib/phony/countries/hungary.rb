
service = [ # Not exhaustive.
 '104',
 '105',
 '107',
 '112',
]

budapest = [ '1' ]

#country '36',
#        one_of('104','105','107','112') >> split(3,3) | # Service
#        one_of('1')                     >> split(3,4) | # Budapest
#        fixed(2)                        >> split(3,4),   # 2-digit NDCs
#        length( 3 => 9, 1 => 8, 2 => 9 )

handlers = []
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Variable.new(nil, service),
  Phony::LocalSplitters::Fixed.instance_for([3, 3]),
  true, '06'
)
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Variable.new(nil, budapest),
  Phony::LocalSplitters::Fixed.instance_for([3, 4]),
  true, '06'
)
handlers << Phony::NationalCode.new(
  Phony::NationalSplitters::Fixed.new(2),
  Phony::LocalSplitters::Fixed.instance_for([3, 4]),
  true, '06'
)

Phony.define do
  country '36', Phony::Country.new(*handlers)

end
