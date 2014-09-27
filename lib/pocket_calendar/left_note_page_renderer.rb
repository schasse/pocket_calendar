module PocketCalendar
  class LeftNotePageRenderer
    include Renderer

    TEMPLATE_PATH = File.expand_path(
      'left_note_page.svg', PocketCalendar::TEMPLATES_PATH)
  end
end
