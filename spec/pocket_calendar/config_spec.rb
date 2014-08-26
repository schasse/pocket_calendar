require 'spec_helper'

describe PocketCalendar::Config do
  subject { PocketCalendar::Config }

  context 'with default config' do
    before { PocketCalendar::Config.load }
    its(:domain) { should eq 'jira.atlassian.com' }
    its(:query) { should eq nil }
  end

  context 'with local config' do
    let(:local_config) { PocketCalendar::Config::LOCAL_CONFIG }

    before do
      File.open(local_config, 'w') { |f| f.write 'password: top_secret' }
      PocketCalendar::Config.load
    end
    after { File.delete local_config }

    its(:password) { should eq 'top_secret' }
  end

  context 'with options' do
    let(:argv) { ['-q', 'key = WIB-123'] }
    before { PocketCalendar::Config.load argv }
    its(:query) { should eq 'key = WIB-123' }
  end
end
