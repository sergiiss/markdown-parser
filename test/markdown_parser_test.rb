require 'test_helper'

class TestMarkdownParser < Minitest::Test
  def test_get_the_selected_and_bold_text
    selected_text = SelectedText.new('_Это выделенный текст_ а это __полужирный__')
    result = selected_text.convert_the_selected_text_in_html
    
    assert_equal '<em>Это выделенный текст</em> а это <strong>полужирный</strong>', result
  end 

  def test_get_the_header_level_2
    header = Header.new("## Заголовок 2 уровня\n")
    result = header.convert_headers_in_html
    
    assert_equal "<h2>Заголовок 2 уровня</h2>\n", result
  end 
end
