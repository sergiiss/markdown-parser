module MarkdownParser
  class HeaderFistOrSecondLevel
    attr_reader :converted_characters

    def initialize(converted_characters)
      @converted_characters = converted_characters
    end

    def convert_headers_first_or_second_level_in_html
      headers_to_find_and_transform

      converted_characters
    end

    private

    attr_reader :headers, :headers_level, :replacement

    def headers_to_find_and_transform
      while converted_characters =~ /(^.+?)\s*\n^(-|=)+?\n/
        @headers = $1
        @headers_level = $2

        convert_haider
      end
    end

    def convert_haider
      select_the_heading_level
      create_placeholder_text
      convert_the_haider_matched
    end

    def select_the_heading_level
      case headers_level
      when '='
        @headers_level = 1
      when '-'
        @headers_level = 2
      end
    end

    def create_placeholder_text
      @replacement = "<h#{headers_level}>#{headers}</h#{headers_level}>"
    end

    def convert_the_haider_matched
      @converted_characters.sub!(/(^.+?)\s*\n^(-|=)+?\n/, "#{replacement}\n")
    end
  end
end
