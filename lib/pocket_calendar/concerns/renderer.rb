module PocketCalendar
  module Renderer
    def rendered_template
      ERB.new(template_file_contents.clone).result binding
    end

    def template_file_contents
      @template_file_contents ||= CGI.unescapeHTML File.read template_path
    end

    def template_path
      self.class::TEMPLATE_PATH
    end
  end
end
