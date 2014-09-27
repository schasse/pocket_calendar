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
      def helpers_for(*subjects)
        define_week_day_translations if subjects.include? :week_day_translations
        define_days_of_month if subjects.include? :days_of_month
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
    end

    def monday_date
      fail 'implement me for use of days_of_month'
    end

    def translate_day(cwday)
      I18n.translate('date.day_names')[cwday]
    end
  end
end
