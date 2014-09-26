require 'cgi'
require 'active_support/configurable'
require 'active_support/core_ext/hash'
require 'yaml'
require 'erb'
require 'optparse'

module PocketCalendar
  PATH = File.expand_path '../..', __FILE__
  LIB_PATH = File.expand_path '..', __FILE__
  RESOURCES_PATH = File.expand_path '../../resources', __FILE__
  CONFIG_PATH = File.expand_path '../../config', __FILE__
end

Dir[PocketCalendar::LIB_PATH + '/**/*.rb'].each { |file| require file }
