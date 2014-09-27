module PocketCalendar
  class NotePageRenderer
    include Renderer

    TEMPLATE_PATH = File.expand_path(
      'note_page.svg', PocketCalendar::TEMPLATES_PATH)
  end
end
