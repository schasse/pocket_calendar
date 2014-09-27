module PocketCalendar
  class WeekPageRenderer < Struct.new(:year, :week)
    def rendered_template
    end

    {
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6,
      sunday: 7
    }.each do |day, cwday|
      define_method(day) { translate_day cwday }

      define_method("#{day}s_day_of_month") do
        monday_date.days_since(cwday - 1).day
      end
    end

    def month_name
      I18n.translate('date.month_names')[monday_date.month]
    end

    private

    def monday_date
      @monday_date ||= Date.commercial year, week
    end

    def translate_day(cwday)
      I18n.translate('date.day_names')[cwday]
    end
  end
end
