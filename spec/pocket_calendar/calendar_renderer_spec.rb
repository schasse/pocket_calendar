require 'spec_helper'

describe PocketCalendar::CalendarRenderer do
  let(:renderer) do
    PocketCalendar::CalendarRenderer.new from_date, to_date, minimum_page_count
  end
  let(:from_date) { Date.new 2014, 10, 1 }
  let(:to_date) { Date.new 2015, 4, 1 }
  let(:minimum_page_count) { 60 }

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
  end
end
