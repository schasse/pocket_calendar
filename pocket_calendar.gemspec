$LOAD_PATH.unshift 'lib'
require 'pocket_calendar/version'

Gem::Specification.new do |s|
  s.name         = 'pocket_calendar'
  s.version      = PocketCalendar::VERSION
  s.date         = Time.now.strftime('%Y-%m-%d')
  s.summary      = 'Create your diy pocket calendar with PocketCalendar.'
  s.homepage     = 'http://github.com/schasse/pocket_calendar'
  s.email        = 'sebastian.schasse@gapfish.com'
  s.authors      = ['schasse']
  s.has_rdoc     = false
  s.licenses     = ['MIT']

  s.description  = <<desc
  With PocketCalendar you can print Jira issues in a pdf.
desc

  s.files        = Dir['{bin,lib,resources,config}/**/*']
  s.files       += %w(README.md MIT-LICENSE)
  s.test_files   = Dir['spec/**/*']

  s.executables  = %w(pocket_calendar)

  s.add_runtime_dependency 'activesupport'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'pry'
end
