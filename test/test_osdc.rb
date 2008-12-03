require File.dirname(__FILE__) + '/test_helper.rb'

class TestOsdc < Test::Unit::TestCase

  def setup
  end
  
  def test_has_version
    assert_not_nil(Osdc::VERSION)
  end
end
