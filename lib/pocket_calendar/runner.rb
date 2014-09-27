module PocketCalendar
  class Runner
    class << self
      def invoke
        create_pdf_from rendered_templates
      end

      private

      def create_pdf_from(templates)
        PdfCreator.new(templates).create_pdf
      end

      def rendered_templates
        CalendarRenderer.new(
          PocketCalendar::Config.from,
          PocketCalendar::Config.to,
          PocketCalendar::Config.minimum_page_count)
          .rendered_templates
      end
    end
  end
end
