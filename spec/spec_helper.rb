require File.join(File.dirname(__FILE__), '../lib/e164')

require 'spec'

$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '../lib')

require 'spec_helper_extensions'
include SpecHelperExtensions