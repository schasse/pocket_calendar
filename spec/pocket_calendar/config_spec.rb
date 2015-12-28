require 'spec_helper'

describe PocketCalendar::Config do
  subject(:config) { PocketCalendar::Config.new }

  context 'with default config' do
    before { config.load }
    its(:language) { should eq 'en' }
    its(:output) { should eq 'calendar.pdf' }
    its(:minimum_page_count) { should eq 0 }
  end

  context 'with local config' do
    let(:local_config) { PocketCalendar::Config::LOCAL_CONFIG }

    before do
      File.open(local_config, 'w') { |f| f.write 'minimum_page_count: 60' }
      config.load
    end
    after { File.delete local_config }

    its(:minimum_page_count) { should eq 60 }
  end

  context 'with options' do
    let(:argv) { ['-f', '2014-10-1'] }
    before { config.load argv }
    its(:from) { should eq Date.new(2014, 10, 1) }
    its(:printversion) { should be_nil }
  end
end
