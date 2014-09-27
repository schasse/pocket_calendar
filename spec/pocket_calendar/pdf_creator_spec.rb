require 'spec_helper'

describe PocketCalendar::PdfCreator do
  let(:creator) { PocketCalendar::PdfCreator.new svgs }
  let(:svgs) { 3.times.map { svg } }
  let(:svg) { File.read PocketCalendar::CalendarRenderer::TEMPLATE_PATH }

  describe '#create_pdf' do
    let(:generated_pdf) do
      File.expand_path '../../../jira_issues.pdf', __FILE__
    end
    let(:page_count) { Prawn::Document.new(template: generated_pdf).page_count }
    before do
      PocketCalendar::Config.output = 'jira_issues.pdf'
      creator.create_pdf
    end
    after { File.delete generated_pdf }

    it 'creates one concatenated pdf' do
      expect(File).to exist(generated_pdf)
      # TODO: make this work expect(page_count).to eq 3
    end
  end
end
