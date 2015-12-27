module PocketCalendar
  class Config
    DEFAULT_CONFIG = File.expand_path 'default.yml', PocketCalendar::CONFIG_PATH
    HOME_CONFIG = File.expand_path '~/.pocket_calendar'
    LOCAL_CONFIG = File.expand_path '.pocket_calendar'

    OPTIONS = {
      from: [
        '-f', '--from DATE', Date,
        'The smallest date the calendar should include. Format yyy-mm-dd.'
      ],
      to: [
        '-t', '--to DATE', Date,
        'The biggest date the calendar should include. Format yyy-mm-dd.'
      ],
      language: [
        '-l', '--language LANGUAGE', [:de, :en],
        'Specifies the language of the calendar.'
      ],
      holidays: [
        '-h', '--holidays COUNTRY', Holidays.available,
        'Specifies the country for holidays.'
      ],
      output: ['-o', '--output FILE', 'Output file name.'],
      minimum_page_count: [
        '-mpg', '--minimum_page_count N', Integer,
        'The calendar will have at least N pages.'
      ],
      printversion: ['-p', '--printversion', 'Sorts the pdf to be printready.']
    }

    OPTIONS.keys.each do |config|
      attr_accessor config
    end

    def load(argv = nil)
      options = parsed_options(argv)
      OPTIONS.keys.each do |option|
        option_value =
          options[option.to_sym] ||
          local_config[option.to_s] ||
          home_config[option.to_s] ||
          ENV['POCKET_CALENDAR_' + option.to_s.upcase] ||
          default_config[option.to_s]
        send "#{option}=", option_value
      end
    end

    private

    def configure_i18n
      # TODO: configurable locale file? or load I18n elsewhere
    end

    def default_config
      @default_config ||= YAML.load File.read DEFAULT_CONFIG
    end

    def home_config
      @home_config ||=
        (File.exist?(HOME_CONFIG) && YAML.load(File.read(HOME_CONFIG))) || {}
    end

    def local_config
      @local_config ||=
        (File.exist?(LOCAL_CONFIG) && YAML.load(File.read(LOCAL_CONFIG))) || {}
    end

    # rubocop:disable Metrics/MethodLength
    def parsed_options(argv)
      parsed_options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: pocket_calendar [options]'

        OPTIONS.each do |option, option_spec|
          opts.on(*option_spec) do |option_value|
            parsed_options[option] = option_value
          end
        end

        opts.on_tail('--version', 'Show version.') do
          puts PocketCalendar::VERSION
          exit
        end
      end.parse argv
      parsed_options
    end
    # rubocop:endable Metrics/MethodLength
  end
end
