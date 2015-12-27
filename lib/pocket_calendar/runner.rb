module PocketCalendar
  class Runner
    attr_reader :args

    def initialize(args = nil)
      @args = args
    end

    def invoke
      create_pdf_from rendered_templates
    end

    private

    def create_pdf_from(templates)
      PdfCreator.new(templates, config).create_pdf
    end

    def rendered_templates
      CalendarRenderer.new(config).rendered_templates
    end

    def config
      config = PocketCalendar::Config.new
      config.load args
      config
    end
  end
end
