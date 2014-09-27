require 'spec_helper'

describe PocketCalendar::LeftNotePageRenderer do
  let(:renderer) { PocketCalendar::LeftNotePageRenderer.new }
  its(:template_path) { should end_with 'note_page.svg' }
end
