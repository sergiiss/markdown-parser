require 'test_helper'

class TestHeader < Minitest::Test
  def test_get_the_header_level_3
    header = Header.new("### Заголовок 3 уровня\n")
    result = header.convert_headers_in_html
    
    assert_equal "<h3>Заголовок 3 уровня</h3>\n", result
  end  
end
