module PocketCalendar
  class TimetableRenderer
    include Renderer
    include RenderHelper

    TEMPLATE_PATH = File.expand_path(
      'timetable.svg', PocketCalendar::TEMPLATES_PATH)

    helpers_for :week_day_translations
  end
end
