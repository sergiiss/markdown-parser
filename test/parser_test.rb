require 'test_helper'

class TestParser < Minitest::Test
  def test_get_the_selected_and_bold_text
    selected_text = MarkdownParser::Parser.new('_Это выделенный текст_ а это __полужирный__')
    result = selected_text.replace_markdown_text_in_html_text

    assert_equal '<em>Это выделенный текст</em> а это <strong>полужирный</strong>', result
  end

  def test_get_the_header_level_2
    header = MarkdownParser::Parser.new("## Заголовок 2 уровня\n")
    result = header.replace_markdown_text_in_html_text

    assert_equal "<h2>Заголовок 2 уровня</h2>\n", result
  end
end
