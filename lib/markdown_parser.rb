require 'markdown-parser/list'
require 'markdown-parser/header'
require 'markdown-parser/selected_text'
require 'markdown-parser/header_first_or_second_level'

class MarkdownParser
  def convert_to_html
    read_the_input_file
    replace_markdown_text_in_html_text
    create_output_file
  end
  
  private
  
  attr_reader :converted_characters
   
  def read_the_input_file
    @converted_characters = File.open(ARGV[0]) { |input_file| input_file.read }
  end
    
  def replace_markdown_text_in_html_text
    convert_lists
    convert_headers
    convert_selected_text
    convert_headers_first_or_second_level
  end

  def convert_headers
    header = Header.new(converted_characters)
    @converted_characters = header.convert_headers_in_html
  end

  def convert_selected_text
    selected_text = SelectedText.new(converted_characters)
    @converted_characters = selected_text.convert_the_selected_text_in_html
  end

  def convert_lists
    list = List.new(converted_characters)
    @converted_characters = list.convert_lists_or_sublists_in_html
  end

  def convert_headers_first_or_second_level
    header_first_or_second_level = HeaderFistOrSecondLevel.new(converted_characters)
    @converted_characters = header_first_or_second_level.convert_headers_first_or_second_level_in_html
  end  
  
  def create_output_file
    File.open(ARGV[1], "w") { |file| file.write converted_characters }
  end
end