require 'spec_helper'

describe PocketCalendar::CalendarRenderer do
  let(:renderer) { PocketCalendar::CalendarRenderer.new }

  before do
    PocketCalendar::Config.from = Date.new 2014, 10, 1
    PocketCalendar::Config.to = Date.new 2015, 4, 1
    PocketCalendar::Config.minimum_page_count = 60
  end

  describe '#rendered_templates' do
    subject(:rendered_templates) { renderer.rendered_templates }

    it 'returns an Array of Strings' do
      expect(rendered_templates).to be_a Array
      rendered_templates.each { |template| expect(template).to be_a String }
    end

    it 'should be dividable by 4' do
      expect(rendered_templates.size % 4).to eq 0
    end
  end

  describe '#year_week_pairs' do
    subject { renderer.send :year_week_pairs }
    its(:first) { should eq [2014, 40] }
    its(:last) { should eq [2015, 14] }

    context 'with Dates 2015/16' do
      before do
        PocketCalendar::Config.from = Date.new 2015, 11, 22
        PocketCalendar::Config.to = Date.new 2016, 5, 22
        PocketCalendar::Config.minimum_page_count = 60
      end

      it 'is an array of existing weeks and years' do
        subject.each do |year, week_of_year|
          expect { Date.commercial year, week_of_year }
            .to_not raise_error
        end
      end
    end
  end
end
