require 'rubygems'
require 'active_support'

$:.unshift File.join(File.dirname(__FILE__), 'lib')
$:.unshift File.join(File.dirname(__FILE__), 'lib', 'ndc')

require 'ndc/fixed_size'
require 'ndc/prefix'

require 'ndc/austria'
require 'ndc/germany'

require 'e164'