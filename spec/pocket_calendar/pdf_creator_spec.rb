require 'spec_helper'

describe PocketCalendar::PdfCreator do
  let(:config) { PocketCalendar::Config.new }
  let(:creator) { PocketCalendar::PdfCreator.new svgs, config }
  let(:svgs) { 3.times.map { svg } }
  let(:svg) { File.read PocketCalendar::TimetableRenderer::TEMPLATE_PATH }

  describe '#create_pdf' do
    let(:generated_pdf) { 'tmp/calendar.pdf' }
    let(:page_count) { Prawn::Document.new(template: generated_pdf).page_count }
    before do
      Dir.mkdir 'tmp' unless File.exist? 'tmp'
      config.output = 'tmp/calendar.pdf'
      creator.create_pdf
    end
    after { File.delete generated_pdf }

    it 'creates one concatenated pdf' do
      expect(File).to exist(generated_pdf)
    end
  end
end
