module PocketCalendar
  class CalendarRenderer
    def rendered_templates
      [[timetable_page] + week_double_pages + note_pages].flatten
    end

    private

    def timetable_page
      TimetableRenderer.new.rendered_template
    end

    def week_double_pages
      @week_double_pages ||= year_week_pairs.map do |year, week|
        [
          WeekPageRenderer.new(year, week).rendered_template,
          right_note_page
        ]
      end.flatten
    end

    def left_note_page
      @left_not_page ||= LeftNotePageRenderer.new.rendered_template
    end

    def right_note_page
      @right_note_page ||= RightNotePageRenderer.new.rendered_template
    end

    def note_pages
      (note_page_count / 2).times.map do
        [left_note_page, right_note_page]
      end.flatten + [left_note_page]
    end

    def year_week_pairs(current_date = PocketCalendar::Config.from)
      if PocketCalendar::Config.to < current_date
        []
      else
        [[current_date.year, current_date.cweek]] +
          year_week_pairs(current_date.weeks_since 1)
      end
    end

    def note_page_count
      page_count - pages_without_note_pages
    end

    def page_count
      [
        next_dividable_by_4(PocketCalendar::Config.minimum_page_count),
        next_dividable_by_4(pages_without_note_pages)
      ].max
    end

    def pages_without_note_pages
      1 + week_double_pages.count
    end

    def next_dividable_by_4(n)
      n + 4 - (n % 4)
    end
  end
end
