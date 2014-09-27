require 'cgi'
require 'active_support/configurable'
require 'active_support/concern'
# TODO: remove hash extension?
require 'active_support/core_ext/hash'
require 'yaml'
require 'erb'
require 'optparse'
require 'optparse/date'

module PocketCalendar
  # TODO: difference expand_path and join
  PATH = File.expand_path '../..', __FILE__
  LIB_PATH = File.expand_path '..', __FILE__
  TEMPLATES_PATH = File.expand_path '../../resources/templates', __FILE__
  LOCALES_PATH = File.expand_path '../../resources/locales', __FILE__
  CONFIG_PATH = File.expand_path '../../config', __FILE__
end

Dir[PocketCalendar::LIB_PATH + '/**/concerns/*.rb'].each { |file| require file }
Dir[PocketCalendar::LIB_PATH + '/**/*.rb'].each { |file| require file }
