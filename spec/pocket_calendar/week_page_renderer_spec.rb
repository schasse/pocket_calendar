require 'spec_helper'

describe PocketCalendar::WeekPageRenderer do
  before { PocketCalendar::Config.language = 'en' }
  subject(:renderer) { PocketCalendar::WeekPageRenderer.new 2014, week }
  let(:week) { 39 }
  its(:monday) { should eq 'Monday' }
  its(:sunday) { should eq 'Sunday' }
  its(:mondays_day_of_month) { should eq 22 }
  its(:mondays_holiday) { should eq nil }
  its(:mondays_day_of_month_and_holiday) { should eq '22' }
  its(:month_name) { should eq 'September' }
  its(:week) { should eq 'week' }
  its(:rendered_template) { should include 'Monday' }
  its(:rendered_template) { should_not include '<%= monday %>' }
  its(:rendered_template) { should_not include CGI.escapeHTML '<%= monday %>' }

  context 'with german configuration' do
    before { PocketCalendar::Config.holidays = I18n.locale = 'de' }
    its(:monday) { should eq 'Montag' }
    context 'when week is with a holiday' do
      let(:week) { 40 }
      its(:fridays_day_of_month_and_holiday) do
        should end_with 'Tag der Deutschen Einheit'
      end
    end
    after { I18n.locale = 'en' }
  end

  context 'when week is in two months' do
    subject(:renderer) { PocketCalendar::WeekPageRenderer.new 2014, 40 }
    its(:month_name) { should eq 'September - October' }
  end
end
