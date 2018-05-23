require "test_helper"

class QuickRandomRecordsTest < Minitest::Test
  def setup; end

  def test_that_it_has_a_version_number
    refute_nil ::QuickRandomRecords::VERSION
  end

  def test_random_query_5
    expected = 5
    assert_equal expected, User.random_records(5).size
  end

  def test_random_query_all
    expected = User.all
    assert_equal expected, User.random_records(10).sort
  end
end
