module PocketCalendar
  module RenderHelper
    extend ActiveSupport::Concern

    WEEK_DAYS = {
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6,
      sunday: 7
    }

    module ClassMethods
      def helpers_for_days_of_month_and_holiday
        define_days_of_month
        define_days_holiday
        define_days_of_month_and_holiday
      end

      def helpers_for_week_day_translations
        define_week_day_translations
      end

      private

      def define_week_day_translations
        WEEK_DAYS.each do |day, cwday|
          define_method(day) { translate_day((cwday % 7), language) }
        end
      end

      def define_days_of_month
        WEEK_DAYS.each do |day, cwday|
          define_method("#{day}s_day_of_month") do
            monday_date.days_since(cwday - 1).day
          end
        end
      end

      def define_days_of_month_and_holiday
        WEEK_DAYS.keys.each do |day|
          define_method("#{day}s_day_of_month_and_holiday") do
            [send("#{day}s_day_of_month"), send("#{day}s_holiday")]
              .compact.join ', '
          end
        end
      end

      def define_days_holiday
        WEEK_DAYS.each do |day, cwday|
          define_method("#{day}s_holiday") do
            return if config_holidays.blank?
            holidays = Holidays.on(
              monday_date.days_since(cwday - 1),
              config_holidays)
            return if holidays.empty?
            '☼ ' + holidays.map { |holiday| holiday[:name] }.join(', ')
          end
        end
      end
    end

    def monday_date
      fail 'implement me for use of days_of_month'
    end

    def translate_day(cwday, language)
      I18n.translate(
        'date.day_names', locale: language)[cwday]
    end
  end
end
