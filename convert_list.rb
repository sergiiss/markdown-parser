# Преобразование списков из Markdown в HTML
#
# (c) Dostankius Sergeus

class List

  attr_reader :first_row_spaces, :start, :finish, :replacement
  attr_accessor :start_list 

  def initialize
    @start_list = true
  end

  def convert_list_or_sublist(converted_characters)    
    converted_characters = converted_characters.join
    
    while converted_characters.match(/(^\n)?^(\s*)([\*|\d])\.?\s(.+?)\n(^\n)?/)
      list_view = $3
      empty_line = $5
      select_the_type_of_list(list_view)
      select_the_end_of_the_list(empty_line)
        
      if $1
        @replacement = "#{$1}#{start}\n<li>#{$4}</li>#{$5}"
        @first_row_spaces = $2    
      else
        convert_the_remaining_lines_list($1, $2, $4, $5)
      end
      
      converted_characters.sub!(/(^\n)?^(\s*)([\*|\d])\.?\s(.+?)\n(^\n)?/, "#{replacement}\n")
    end
    
    remove_unnecessary_tags(converted_characters)
    
    converted_characters.chars
  end
  
  private
  
  attr_reader :finish_list, :finish_sublist
  
  def select_the_type_of_list(list_view)
    if list_view == "*"
      @start = "<ul>"
      @finish = "</ul>"
    else
      @start = "<ol>"
      @finish = "</ol>"
    end
  end
  
  def select_the_end_of_the_list(empty_line)
    if empty_line
      @finish_list = "\n#{finish}"
    else
      @finish_list = nil
    end
  end
  
  def convert_the_remaining_lines_list(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    if whitespace != first_row_spaces && start_list
      find_beginning_of_the_sublist(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    elsif whitespace != first_row_spaces
      convert_sublist(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    else
      if @start_list == false
        complete_list(starting_an_empty_string, finish_sublist, text, completing_an_empty_string, finish_list)   
      else
        convert_list(starting_an_empty_string, whitespace, text, completing_an_empty_string)             
      end
    end
  end
  
  def find_beginning_of_the_sublist(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    @replacement = "#{starting_an_empty_string}#{start}<li>#{text}</li>#{completing_an_empty_string}"
    @start_list = false
    @finish_sublist = "#{finish}</li>"
  end
  
  def convert_sublist(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    if completing_an_empty_string
      complete_sublist(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    else
      @replacement = "#{starting_an_empty_string}<li>#{text}</li>#{completing_an_empty_string}"           
    end
  end
  
  def complete_sublist(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    @replacement = "#{starting_an_empty_string}<li>#{text}</li>#{finish_sublist}#{finish_list}#{completing_an_empty_string}"
    @finish_sublist = nil
    @start_list = true
  end
  
  def complete_list(starting_an_empty_string, finish_sublist, text, completing_an_empty_string, finish_list)
    @replacement = "#{starting_an_empty_string}#{finish_sublist}\n<li>#{text}</li>#{finish_list}#{completing_an_empty_string}"
    @start_list = true         
  end
    
  def convert_list(starting_an_empty_string, whitespace, text, completing_an_empty_string)
    @replacement = "#{starting_an_empty_string}<li>#{text}</li>#{finish_list}#{completing_an_empty_string}"
  end
    
  def remove_unnecessary_tags(converted_characters)
    remove_unnecessary_tags_usual_list(converted_characters)
    remove_unnecessary_tags_numbered_list(converted_characters)
  end
  
  def remove_unnecessary_tags_usual_list(converted_characters)
    while converted_characters.match(/\<\/li\>\n\<ul\>\<li\>/)
      converted_characters.sub!(/\<\/li\>\n\<ul\>\<li\>/, "\n<ul><li>")
    end
  end
  
  def remove_unnecessary_tags_numbered_list(converted_characters)
    while converted_characters.match(/\<\/li\>\n\<ol\>\<li\>/)
      converted_characters.sub!(/\<\/li\>\n\<ol\>\<li\>/, "\n<ol><li>")
    end
  end  
end
