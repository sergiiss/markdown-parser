
require_relative "convert_list"
require_relative "headers"
require_relative "selected_text"
require_relative "headers_first_or_second_level"

class MarkdownParser
  attr_accessor :converted_characters
            
  def initialize
    @converted_characters = []
  end
  
  def convert_to_html
    brake_file_to_chars
    replace_markdown_with_html
    output_to_file  
  end
  
  private
   
  def brake_file_to_chars
    file = File.open(ARGV[0]) do |review_file|
      @converted_characters = review_file.read.chars
    end
  end
    
  def replace_markdown_with_html
    converted_characters.each do |char|
      case char
      when "#"
        headers = Headers.new
        @converted_characters = headers.replace_headers(@converted_characters) 
      when "_", "*"
        selected_text = SelectedText.new
        @converted_characters = selected_text.receiving_the_selected_text(@converted_characters)        
        list = List.new
        @converted_characters = list.convert_list_or_sublist(@converted_characters)
      when "-", "="
        headers_first_or_second_level = HeadersFistOrSecondLevel.new
        @converted_characters = headers_first_or_second_level.headers_to_receive_first_or_second_level(@converted_characters)
      end
    end
  end  
  
  def output_to_file
    File.open(ARGV[1], "w") {|file| file.write @converted_characters.join}
  end  
end

parser = MarkdownParser.new
parser.convert_to_html