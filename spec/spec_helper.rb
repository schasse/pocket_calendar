path_to_lib = File.expand_path '../../lib', __FILE__
$LOAD_PATH.unshift path_to_lib

require 'rspec/its'
require 'pry'
require 'simplecov'

SimpleCov.start

require 'pocket_calendar'

RSpec.configure do |config|
  config.order = 'random'
end
