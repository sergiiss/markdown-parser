class SelectedText
  attr_reader :converted_characters
  
  def initialize(converted_characters)
    @converted_characters = converted_characters
  end
  
  def convert_the_selected_text_in_html
    receiving_the_selected_text
  
    converted_characters
  end
  
  private
  
  attr_reader :emphasis_level, :text, :replacement

  def receiving_the_selected_text
    while converted_characters =~ /([_|\*]{1,2})([^\s\*_][^[_|\*]]*[^\s^\*_])[_|\*]{1,2}/
      @emphasis_level = $1
      @text = $2
      
      choose_how_to_replace
      convert_the_selected_text_matched
    end
  end
  
  def choose_how_to_replace
    case emphasis_level
    when "*", "_"
      @replacement = "<em>#{text}</em>"
    when "__", "**"
      @replacement = "<strong>#{text}</strong>"
    end
  end
  
  def convert_the_selected_text_matched
    @converted_characters.sub!(/([_|\*]{1,2})([^\s\*_][^[_|\*]]*[^\s\*_])[_|\*]{1,2}/, "#{replacement}")
  end
end
