require "test_helper"

class QuickRandomRecordsTest < Minitest::Test
  def setup; end

  def test_that_it_has_a_version_number
    refute_nil ::QuickRandomRecords::VERSION
  end

  def test_strategy1_query_part
    expected = 5
    assert_equal expected, User.random_records(5).size
  end

  def test_strategy1_query_all
    expected = User.all
    assert_equal expected, User.random_records(10).sort
  end

  def test_strategy1_query_part_with_multiple
    expected = 5
    assert_equal expected, User.random_records(5, multiple: 1).size
  end

  def test_strategy1_query_all_with_multiple
    expected = User.all
    assert_equal expected, User.random_records(10, multiple: 1).sort
  end

  def test_strategy1_query_part_with_loop_limit
    expected = 5
    assert_equal expected, User.random_records(5, loop_limit: 5).size
  end

  def test_strategy1_query_all_with_loop_limit
    expected = User.all
    assert_equal expected, User.random_records(10, loop_limit: 5).sort
  end

  def test_strategy2_query_part
    expected = 5
    assert_equal expected, User.random_records(5, strategy: 2).size
  end

  def test_strategy2_query_all
    expected = User.all
    assert_equal expected, User.random_records(10, strategy: 2).sort
  end

  def test_strategy3_query_part
    expected = 5
    assert_equal expected, User.random_records(5, strategy: 3).size
  end

  def test_strategy3_query_all
    expected = User.all
    assert_equal expected, User.random_records(10, strategy: 3).sort
  end

  def test_strategy_not_support
    expected = "this gem doesn't support strategy other than 1, 2, 3"
    assert_equal expected, User.random_records(10, strategy: 4)
  end
end
