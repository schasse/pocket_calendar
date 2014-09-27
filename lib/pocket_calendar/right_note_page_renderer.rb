module PocketCalendar
  class RightNotePageRenderer
    include Renderer

    TEMPLATE_PATH = File.expand_path(
      'right_note_page.svg', PocketCalendar::TEMPLATES_PATH)
  end
end
