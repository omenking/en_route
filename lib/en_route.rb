dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

require 'en_route/tokens'
require 'en_route/parser'
require 'en_route/compiler'
