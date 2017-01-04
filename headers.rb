# Преобразование заголовков из Markdown в HTML
#
# (c) Dostankius Sergeus

class Headers
attr_reader :header_level, :header_text

  def replace_headers(converted_characters)
    converted_characters = converted_characters.join
      while converted_characters =~ /^(\#{1,6})\s?([^#]*?)\s*(\#{1,6})?\n/
        header_text = $2
        header_level = $1
        header_level = header_level.chars.size
        replacement = "<h#{header_level}>#{header_text}</h#{header_level}>"
        converted_characters.sub!(/^(\#{1,6})\s?([^#]*?)\s*(\#{1,6})?\n/, "#{replacement}\n")
      end
      
    converted_characters.chars
  end
end