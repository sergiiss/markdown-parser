module MarkdownParser
  class Cli
    attr_reader :converted_characters

    def convert_file
      read_the_input_file
      convert_text
      create_output_file
    end

    def read_the_input_file
      @converted_characters = File.open(ARGV[0]) { |input_file| input_file.read }
    end

    def convert_text
      parser = Parser.new(converted_characters)
      @converted_characters = parser.replace_markdown_text_in_html_text
    end

    def create_output_file
      File.open(ARGV[1], 'w') { |file| file.write converted_characters }
    end
  end
end