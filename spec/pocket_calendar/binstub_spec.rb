require 'spec_helper'

describe "PocketCalendar's binstub" do
  describe 'its execution' do
    let(:command) do
      'ruby '\
      "-I #{PocketCalendar::LIB_PATH} "\
      "#{PocketCalendar::BIN_PATH}/pocket_calendar "\
      " --from 2014-10-1 --to 2014-10-1 --output #{output_file}"
    end
    let(:output_file) { 'tmp/calendar.pdf' }

    before do
      Dir.mkdir 'tmp' unless File.exist? 'tmp'
      `#{command}`
    end
    after { File.delete output_file }

    it 'creates a pdf file' do
      expect(File).to exist(output_file)
    end
  end
end
