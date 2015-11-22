module PocketCalendar
  class WeekPageRenderer < Struct.new(:year, :week_of_year)
    include Renderer
    include RenderHelper

    TEMPLATE_PATH = File.expand_path(
      'week_page.svg', PocketCalendar::TEMPLATES_PATH)

    helpers_for :week_day_translations, :days_of_month_and_holiday

    def month_name
      [
        I18n.translate('date.month_names', locale: locale)[monday_date.month],
        I18n.translate('date.month_names', locale: locale)[sunday_date.month]
      ].uniq.join ' - '
    end

    def week

      I18n.translate 'date.week', locale: locale
    end

    private

    def monday_date
      @monday_date ||= Date.commercial year, week_of_year
    end

    def sunday_date
      @sunday_date ||= monday_date.days_since 7
    end

    def locale
      PocketCalendar::Config.language
    end
  end
end
