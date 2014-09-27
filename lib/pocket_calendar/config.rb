module PocketCalendar
  class Config < Struct.new(:argv)
    include ActiveSupport::Configurable

    DEFAULT_CONFIG = File.expand_path 'default.yml', PocketCalendar::CONFIG_PATH
    HOME_CONFIG = File.expand_path '~/.pocket_calendar'
    LOCAL_CONFIG = File.expand_path '.pocket_calendar'

    OPTIONS = {
      # TODO: add option printable
      from: [
        '-f', '--from DATE', Date,
        'The smallest date the calendar should include.'
      ],
      to: [
        '-t', '--to DATE', Date,
        'The biggest date the calendar should include.'
      ],
      language: [
        '-l', '--language LANGUAGE', [:de, :en],
        'Specifies the language of the calendar.'
      ],
      output: ['-o', '--output FILE', 'Output file name.'],
      minimum_page_count: [
        '-mpg', '--minimum_page_count N', Integer,
        'The calendar will have at least N pages.'
      ]
    }

    OPTIONS.keys.each do |config|
      config_accessor config
    end

    class << self
      def load(argv = nil)
        configure_pocket_calendar argv
        configure_i18n
      end

      def reset
        OPTIONS.keys.each do |option|
          send "#{option}=", nil
        end
        I18n.locale = 'en'
      end

      private

      def configure_pocket_calendar(argv)
        config = new argv
        OPTIONS.keys.each do |option|
          option_value = config.options[option]         ||
            config.local_config[option.to_s]            ||
            config.home_config[option.to_s]             ||
            ENV['POCKET_CALENDAR' + option.to_s.upcase] ||
            config.default_config[option.to_s]
          send "#{option}=", option_value
        end
      end

      def configure_i18n
        # TODO: configurable locale file
        I18n.load_path = Dir[PocketCalendar::LOCALES_PATH + '/*.yml']
        I18n.backend.load_translations
        I18n.locale = language
        I18n.enforce_available_locales = false
      end
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

    def options
      unless @options
        @options = {}
        option_parser.parse argv
      end
      @options
    end

    private

    def option_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: pocket_calendar [options]'

        OPTIONS.each do |option, option_spec|
          add_option opts, option, option_spec
        end

        opts.on_tail('--version', 'Show version.') do
          puts PocketCalendar::VERSION
          exit
        end
      end
    end

    def add_option(opts, option, option_spec)
      opts.on(*option_spec) do |option_value|
        @options[option] = option_value
      end
    end
  end
end
