require 'spec_helper'

describe PocketCalendar::WeekPageRenderer do
  subject(:renderer) { PocketCalendar::WeekPageRenderer.new 2014, 39 }
  its(:monday) { should eq 'Monday' }
  its(:mondays_day_of_month) { should eq 22 }
  its(:month_name) { should eq 'September' }

  context 'with german configuration' do
    before { I18n.locale = 'de' }
    its(:monday) { should eq 'Montag' }
    after { I18n.locale = 'en' }
  end
end
