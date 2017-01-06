class SelectedText
  attr_reader :text, :emphasis_level

  def receiving_the_selected_text(converted_characters)
    converted_characters = converted_characters.join
      while converted_characters =~ /([_|\*]{1,2})([^\s\*_][^[_|\*]]*[^\s^\*_])[_|\*]{1,2}/
        @text = $2
        @emphasis_level = $1
        convert_the_selected_characters(emphasis_level, text, converted_characters)        
      end
      
    converted_characters = converted_characters.chars
  end
  
  def convert_the_selected_characters(emphasis_level, text, converted_characters)
    case emphasis_level
    when "*", "_"
      replacement = "<em>#{text}</em>"
    when "__", "**"
      replacement = "<strong>#{text}</strong>"
    end
    
    converted_characters.sub!(/([_|\*]{1,2})([^\s\*_][^[_|\*]]*[^\s\*_])[_|\*]{1,2}/, "#{replacement}")
  end

end