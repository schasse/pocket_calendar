require 'spec_helper'

describe PocketCalendar::Runner do
  describe '.invoke' do
    let(:runner) { PocketCalendar::Runner }
    let(:generated_pdf) do
      File.expand_path '../../../jira_issues.pdf', __FILE__
    end

    before do
      PocketCalendar::Config.query = 'key = WBS-24'
      PocketCalendar::Config.domain = 'jira.atlassian.com'
      PocketCalendar::Config.output = 'jira_issues.pdf'
      runner.invoke
    end
    after { File.delete generated_pdf }

    it 'creates a pdf file' do
      expect(File).to exist(generated_pdf)
    end
  end
end
