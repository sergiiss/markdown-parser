require 'test_helper'

class TestList < Minitest::Test
  def test_get_a_list_in_html
    list = MarkdownParser::List.new('
    * Список 1
    * Строка 2
       * подстрока 1
       * подстрока 2
    * Строка 3

Дальнейший текст.
')
    result = list.convert_lists_or_sublists_in_html
    expected_result =
    <<~HTML

    <ul>
    <li>Список 1</li>
    <li>Строка 2
    <ul><li>подстрока 1</li>
    <li>подстрока 2</li>
    </ul></li>
    <li>Строка 3</li>
    </ul>

    Дальнейший текст.
    HTML

    assert_equal expected_result, result
  end
end
