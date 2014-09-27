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
        CalendarRenderer.new.rendered_templates
      end
    end
  end
end
