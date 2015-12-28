module PocketCalendar
  class TimetableRenderer < Struct.new(:config)
    include Renderer
    include RenderHelper

    TEMPLATE_PATH = File.expand_path(
      'timetable.svg', PocketCalendar::TEMPLATES_PATH)

    helpers_for_week_day_translations

    def language
      config.language
    end
  end
end
