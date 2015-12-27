module PocketCalendar
  class WeekPageRenderer < Struct.new(:year, :week_of_year, :config)
    include Renderer
    include RenderHelper

    TEMPLATE_PATH = File.expand_path(
      'week_page.svg', PocketCalendar::TEMPLATES_PATH)

    helpers_for_week_day_translations
    helpers_for_days_of_month_and_holiday

    def month_name
      [
        I18n.translate('date.month_names', locale: language)[monday_date.month],
        I18n.translate('date.month_names', locale: language)[sunday_date.month]
      ].uniq.join ' - '
    end

    def week
      I18n.translate 'date.week', locale: language
    end

    private

    def monday_date
      @monday_date ||= Date.commercial year, week_of_year
    end

    def sunday_date
      @sunday_date ||= monday_date.days_since 7
    end

    def language
      config.language
    end

    def config_holidays
      config.holidays
    end
  end
end
