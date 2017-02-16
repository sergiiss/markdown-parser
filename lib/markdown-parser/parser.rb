module MarkdownParser
  class Parser
    attr_reader :converted_characters

    def initialize(converted_characters)
      @converted_characters = converted_characters
    end

    def replace_markdown_text_in_html_text
      convert_headers
      convert_headers_first_or_second_level
      convert_lists
      convert_selected_text
    end

    private

    def convert_headers
      header = Header.new(converted_characters)
      @converted_characters = header.convert_headers_in_html
    end

    def convert_headers_first_or_second_level
      header_first_or_second_level = HeaderFistOrSecondLevel.new(converted_characters)
      @converted_characters = header_first_or_second_level.convert_headers_first_or_second_level_in_html
    end

    def convert_lists
      list = List.new(converted_characters)
      @converted_characters = list.convert_lists_or_sublists_in_html
    end

    def convert_selected_text
      selected_text = SelectedText.new(converted_characters)
      @converted_characters = selected_text.convert_the_selected_text_in_html
    end
  end
end