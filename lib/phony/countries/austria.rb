include Phony::DSL

# Austria uses a variable-length ndc code, thus we use a separate file to not let all_other.rb explode.
#
ndcs = [
  '1', # Vienna
 '57',  # -
 '59',  # -
 '89',  # Routing Number
 '316', # Graz
 '501', # -
 '502', # -
 '503', # -
 '504', # -
 '505', # -
 '506', # -
 '507', # -
 '508', # -
 '509', # -
 '512', # Innsbruck
 '517', # -
 '662', # Salzburg
 '720', #
 '732'  # Linz
]

mobile = [
 '67', 
 '68', 
 '644',
 '650',
 '651',
 '652',
 '653',
 '655',
 '657',
 '659',
 '660',
 '661',
 '663',
 '664',
 '665',
 '666',
 '667',
 '668',
 '669'
]

service = [
 '710',
 '711',
 '718',
 '730',
 '740',
 '780',
 '800',
 '802',
 '804',
 '810',
 '820',
 '821',
 '828',
 '900',
 '901',
 '930',
 '931',
 '939'  
]

Phony::Countries::Austria = one_of(service + mobile + ndcs, :max_length => 4) >> split(10)