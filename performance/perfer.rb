# Run with:
#   perfer run perfer.rb
#
require 'perfer'
require_relative '../lib/phony'

Perfer.session "Phony" do |s|
  s.metadata do
    description "Phony.normalize"
  end
  s.bench "Phony.normalize with linearly increasing call amount" do |n|
    s.measure { n.times { Phony.normalize("+81 08 12 34 56 78") } }
  end
end
