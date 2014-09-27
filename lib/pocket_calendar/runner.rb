module PocketCalendar
  class Runner
    class << self
      def invoke
        create_pdf_from rendered_templates_from
      end

      private

      def create_pdf_from(templates)
        PdfCreator.new(templates).create_pdf
      end

      def rendered_templates_from(jira_issues)
        Renderer.new(jira_issues).rendered_templates
      end

      def jira_issues
        JiraApi::Issue.where PocketCalendar::Config.query
      end
    end
  end
end
