require 'spec_helper'

describe PocketCalendar::Runner do
  describe '.invoke' do
    let(:runner) { PocketCalendar::Runner }
    let(:generated_pdf) do
      File.expand_path '../../../calendar.pdf', __FILE__
    end

    before do
      PocketCalendar::Config.from = Date.new 2014, 10, 1
      PocketCalendar::Config.to = Date.new 2014, 11, 1
      PocketCalendar::Config.output = 'calendar.pdf'
      PocketCalendar::Config.minimum_page_count = 0
      runner.invoke
    end
    after { File.delete generated_pdf }

    it 'creates a pdf file' do
      expect(File).to exist(generated_pdf)
    end
  end
end
