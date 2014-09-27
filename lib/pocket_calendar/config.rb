module PocketCalendar
  class Config < Struct.new(:argv)
    include ActiveSupport::Configurable

    DEFAULT_CONFIG = File.expand_path 'default.yml', PocketCalendar::CONFIG_PATH
    HOME_CONFIG = File.expand_path '~/.pocket_calendar'
    LOCAL_CONFIG = File.expand_path '.pocket_calendar'

    AVAILABLE_OPTIONS = {
      # TODO: from and to as dates, language some options
      # TODO: add option printable
      from: 'The smallest date the calendar should include.',
      to: 'The biggest date the calendar should include.',
      language: 'Specifies the language of the calendar.',
      output: 'Output file name.',
      minimum_page_count: 'The calendar will have at least that page count.'
    }

    AVAILABLE_OPTIONS.keys.each do |config|
      config_accessor config
    end

    class << self
      def load(argv = nil)
        configure_pocket_calendar argv
        configure_i18n
      end

      def reset
        AVAILABLE_OPTIONS.keys.each do |option|
          send "#{option}=", nil
        end
        I18n.locale = 'en'
      end

      private

      def configure_pocket_calendar(argv)
        config = new argv
        AVAILABLE_OPTIONS.keys.each do |option|
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

        AVAILABLE_OPTIONS.each do |option, description|
          add_option opts, option, description
        end

        opts.on_tail('--version', 'Show version.') do
          puts PocketCalendar::VERSION
          exit
        end
      end
    end

    def add_option(opts, option, description)
      opts.on(
        "-#{option.to_s.chars.first}",
        "--#{option} #{option.to_s.upcase}",
        description) do |option_value|

        @options[option] = option_value
      end
    end
  end
end
