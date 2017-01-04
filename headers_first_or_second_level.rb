class HeadersFistOrSecondLevel

def headers_to_receive_first_or_second_level(converted_characters)
    converted_characters = converted_characters.join
      while converted_characters =~ /(^.+?)\s*\n^(-|=)+?\n/        
        headers = $1
        headers_level = $2
        convert_characters_of_the_first_or_second_level(headers_level, headers, converted_characters)
      end
      
    converted_characters.chars
  end
  
  def convert_characters_of_the_first_or_second_level(headers_level, headers, converted_characters)
    case headers_level
    when "="
      headers_level = 1
    when "-"
      headers_level = 2
    end      
    replacement = "<h#{headers_level}>#{headers}</h#{headers_level}>"
    
    converted_characters.sub!(/(^.+?)\s*\n^(-|=)+?\n/, "#{replacement}\n") 
  end
end