require 'test_helper'

class TestHeaderFistOrSecondLevel < Minitest::Test
  def test_get_the_header_level_2
    header = HeaderFistOrSecondLevel.new("Заголовок 2 уровня\n------------------\n")
    
    result = header.convert_headers_first_or_second_level_in_html
    
    assert_equal "<h2>Заголовок 2 уровня</h2>\n", result
  end  
end
