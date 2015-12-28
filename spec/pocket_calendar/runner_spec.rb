require 'spec_helper'

describe PocketCalendar::Runner do
  describe '.invoke' do
    let(:runner) { PocketCalendar::Runner.new argv }
    let(:generated_pdf) { 'tmp/calendar.pdf' }
    let(:argv) do
      %w(
        --from 2014-10-1
        --to 2014-11-1
        --output tmp/calendar.pdf
        --minimum_page_count 0)
    end

    before do
      Dir.mkdir 'tmp' unless File.exist? 'tmp'
      runner.invoke
    end
    after { File.delete generated_pdf }

    it 'creates a pdf file' do
      expect(File).to exist(generated_pdf)
    end
  end
end
