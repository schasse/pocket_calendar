require 'spec_helper'

describe PocketCalendar::WeekPageRenderer do
  subject(:renderer) { PocketCalendar::WeekPageRenderer.new 2014, 39 }
  its(:monday) { should eq 'Monday' }
  its(:sunday) { should eq 'Sunday' }
  its(:mondays_day_of_month) { should eq 22 }
  its(:month_name) { should eq 'September' }
  its(:week) { should eq 'week' }
  its(:rendered_template) { should include 'Monday' }
  its(:rendered_template) { should_not include '<%= monday %>' }
  its(:rendered_template) { should_not include CGI.escapeHTML '<%= monday %>' }

  context 'with german configuration' do
    before { I18n.locale = 'de' }
    its(:monday) { should eq 'Montag' }
    after { I18n.locale = 'en' }
  end

  context 'when week is in two months' do
    subject(:renderer) { PocketCalendar::WeekPageRenderer.new 2014, 40 }
    its(:month_name) { should eq 'September - October' }
  end
end
