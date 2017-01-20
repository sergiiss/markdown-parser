class Header
  attr_reader :converted_characters

  def initialize(converted_characters)
    @converted_characters = converted_characters
  end
  
  def convert_headers_in_html
    replace_headers
    
    converted_characters
  end
  
  private
  
  attr_reader :header_level, :header_text, :replacement

  def replace_headers
    while converted_characters =~ /^(\#{1,6})\s?([^#]*?)\s*(\#{1,6})?\n/
      @header_level = $1
      @header_text = $2
      
      calculate_heading_level
      create_placeholder_text
      convert_text
    end
  end
  
  def calculate_heading_level
    @header_level = header_level.chars.size
  end
  
  def create_placeholder_text
    @replacement = "<h#{header_level}>#{header_text}</h#{header_level}>"
  end
  
  def convert_text
    @converted_characters.sub!(/^(\#{1,6})\s?([^#]*?)\s*(\#{1,6})?\n/, "#{replacement}\n")
  end
end
