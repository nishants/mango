ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require File.expand_path '../../src/server/server.rb', __FILE__