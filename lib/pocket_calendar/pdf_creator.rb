module PocketCalendar
  class PdfCreator < Struct.new(:svgs, :config)
    def create_pdf
      concatenate_pdfs
      make_printable if config.printversion
      cleanup
    end

    private

    def concatenate_pdfs
      `pdftk #{pdf_files.join(' ')} cat output #{config.output}`
    end

    def make_printable
      cmd = 'pdfbook '\
            "--short-edge #{config.output} "\
            "--outfile #{config.output}"
      `#{cmd}`
    end

    def cleanup
      (pdf_files + svg_files).each { |tmp_file| File.delete tmp_file }
      Dir.rmdir tmp_folder
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
        template_file = File.join tmp_folder, "pocket_calendar.#{index}.svg"
        File.open(template_file, 'w') { |f| f.write svg }
        template_file
      end
    end

    def tmp_folder
      return @tmp_folder if @tmp_folder
      random = SecureRandom.hex 4
      Dir.mkdir(File.join('tmp', random))
      @tmp_folder = File.join('tmp', random)
    end
  end
end
