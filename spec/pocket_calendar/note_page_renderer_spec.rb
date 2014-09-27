require 'spec_helper'

describe PocketCalendar::NotePageRenderer do
  let(:renderer) { PocketCalendar::NotePageRenderer.new }
  its(:template_path) { should end_with 'note_page.svg' }
end
