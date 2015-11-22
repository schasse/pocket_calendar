module PocketCalendar
  class PdfCreator < Struct.new(:svgs)
    def create_pdf
      concatenate_pdfs
      make_printable if PocketCalendar::Config.printversion
      cleanup
    end

    private

    def concatenate_pdfs
      `pdftk #{pdf_files.join(' ')} cat output #{PocketCalendar::Config.output}`
    end

    def make_printable
      `pdfbook --short-edge #{PocketCalendar::Config.output}`
    end

    def cleanup
      (pdf_files + svg_files).each { |tmp_file| File.delete tmp_file }
    end

    def pdf_files
      @pdf_files ||= svg_files.map do |svg_file|
        pdf_file = svg_file.sub 'svg', 'pdf'
        `inkscape --file=#{svg_file} --export-pdf=#{pdf_file}`
        pdf_file
      end
    end

    def svg_files
      @svg_files ||= svgs.each_with_index.map do |svg, index|
        template_file = "tmp/pocket_calendar.#{index}.svg"
        File.open(template_file, 'w') { |f| f.write svg }
        template_file
      end
    end
  end
end
