class List
  attr_reader :converted_characters

  def initialize(converted_characters)
    @converted_characters = converted_characters
    
    @start_list           = true
  end

  def convert_lists_or_sublists_in_html
    find_lists_of_coincidence
    remove_unnecessary_tags
    
    converted_characters
  end
  
  private
  
  attr_reader :first_row_spaces, :start, :finish, :replacement, :starting_an_empty_string,
              :whitespace, :text, :completing_an_empty_string, :start_list, :finish_list,
              :finish_sublist, :list_view
  
  def find_lists_of_coincidence
    while converted_characters.match(/(^\n)?^(\s*)([\*|\d])\.?\s(.+?)\n(^\n)?/)
      @starting_an_empty_string = $1
      @whitespace = $2
      @list_view = $3
      @text = $4
      @completing_an_empty_string = $5
      
      select_the_type_of_list
      select_the_end_of_the_list
      convert_list_or_sublist
      
      @converted_characters.sub!(/(^\n)?^(\s*)([\*|\d])\.?\s(.+?)\n(^\n)?/, "#{replacement}\n")
    end
  end
  
  def select_the_type_of_list
    if list_view == "*"
      @start = "<ul>"
      @finish = "</ul>"
    else
      @start = "<ol>"
      @finish = "</ol>"
    end
  end
  
  def select_the_end_of_the_list
    if completing_an_empty_string
      @finish_list = "\n#{finish}"
    else
      @finish_list = nil
    end
  end
  
  def convert_list_or_sublist
    if starting_an_empty_string
      @replacement = "#{starting_an_empty_string}#{start}\n<li>#{text}</li>#{completing_an_empty_string}"
      @first_row_spaces = whitespace
    else
      convert_the_remaining_lines_list
    end
  end
  
  def convert_the_remaining_lines_list
    if whitespace != first_row_spaces && start_list
      find_beginning_of_the_sublist
    elsif whitespace != first_row_spaces
      convert_sublist
    else
      convert_or_finish_the_list
    end
  end
  
  def find_beginning_of_the_sublist
    @replacement = "#{starting_an_empty_string}#{start}<li>#{text}</li>#{completing_an_empty_string}"
    @start_list = false
    @finish_sublist = "#{finish}</li>"
  end
  
  def convert_sublist
    if completing_an_empty_string
      complete_sublist
    else
      @replacement = "#{starting_an_empty_string}<li>#{text}</li>#{completing_an_empty_string}"
    end
  end
  
  def complete_sublist
    @replacement = "#{starting_an_empty_string}<li>#{text}</li>#{finish_sublist}#{finish_list}#{completing_an_empty_string}"
    @finish_sublist = nil
    @start_list = true
  end
  
  def convert_or_finish_the_list
    if start_list == false
      convert_ending_list_or_sublist
    else
      convert_list
    end
  end
  
  def convert_ending_list_or_sublist
    @replacement = "#{starting_an_empty_string}#{finish_sublist}\n<li>#{text}</li>#{finish_list}#{completing_an_empty_string}"
    @start_list = true
  end
    
  def convert_list
    @replacement = "#{starting_an_empty_string}<li>#{text}</li>#{finish_list}#{completing_an_empty_string}"
  end
    
  def remove_unnecessary_tags
    remove_unnecessary_tags_usual_list
    remove_unnecessary_tags_numbered_list
  end
  
  def remove_unnecessary_tags_usual_list
    while converted_characters.match(/\<\/li\>\n\<ul\>\<li\>/)
      @converted_characters.sub!(/\<\/li\>\n\<ul\>\<li\>/, "\n<ul><li>")
    end
  end
  
  def remove_unnecessary_tags_numbered_list
    while converted_characters.match(/\<\/li\>\n\<ol\>\<li\>/)
      @converted_characters.sub!(/\<\/li\>\n\<ol\>\<li\>/, "\n<ol><li>")
    end
  end
end
