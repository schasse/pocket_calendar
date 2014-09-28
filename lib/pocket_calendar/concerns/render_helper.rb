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
      sunday: 0
    }

    module ClassMethods
      def helpers_for(*subjects)
        define_week_day_translations if subjects.include? :week_day_translations
        if (subjects & [:days_of_month, :days_of_month_and_holiday]).any?
          define_days_of_month
        end
        return unless subjects.include? :days_of_month_and_holiday
        define_days_holiday
        define_days_of_month_and_holiday
      end

      private

      def define_week_day_translations
        WEEK_DAYS.each do |day, cwday|
          define_method(day) { translate_day cwday }
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
            return if PocketCalendar::Config.holidays.blank?
            holidays = Holidays.on(
              monday_date.days_since(cwday - 1),
              PocketCalendar::Config.holidays)
            return if holidays.empty?
            '☼ ' + holidays.map { |holiday| holiday[:name] }.join(', ')
          end
        end
      end
    end

    def monday_date
      fail 'implement me for use of days_of_month'
    end

    def translate_day(cwday)
      I18n.translate('date.day_names')[cwday]
    end
  end
end
