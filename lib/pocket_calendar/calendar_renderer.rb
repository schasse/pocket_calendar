module PocketCalendar
  class CalendarRenderer < Struct.new(:from_date, :to_date)
    def rendered_templates
      year_week_pairs.map do |year, week|
        [
          WeekPageRenderer.new(year, week).rendered_template,
          note_page_template
        ]
      end
    end

    private

    def year_week_pairs(current_date = from_date)
      if to_date < current_date
        []
      else
        [[current_date.year, current_date.cweek]] +
          year_week_pairs(current_date.weeks_since 1)
      end
    end

    def note_page_template
      @note_page_renderer ||= NotePageRenderer.new.rendered_template
    end
  end
end
