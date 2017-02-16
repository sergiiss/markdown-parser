require 'test_helper'

class TestSelectedText < Minitest::Test
  def test_get_the_selected_text
    selected_text = MarkdownParser::SelectedText.new('_Это выделенный текст_')
    result = selected_text.convert_the_selected_text_in_html

    assert_equal '<em>Это выделенный текст</em>', result
  end

  def test_get_bold_text
    selected_text = MarkdownParser::SelectedText.new('__полужирный__')
    result = selected_text.convert_the_selected_text_in_html

    assert_equal '<strong>полужирный</strong>', result
  end
end
