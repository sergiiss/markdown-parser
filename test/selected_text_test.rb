require 'test_helper'

class TestSelectedText < Minitest::Test
  def test_get_the_selected_text
    selected_text = SelectedText.new('_Это выделенный текст_').convert_the_selected_text_in_html
    
    assert_equal '<em>Это выделенный текст</em>', selected_text
  end 

  def test_get_bold_text
    selected_text = SelectedText.new('__полужирный__').convert_the_selected_text_in_html
    
    assert_equal '<strong>полужирный</strong>', selected_text
  end 
end
