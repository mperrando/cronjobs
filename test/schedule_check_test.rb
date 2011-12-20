require File.dirname(__FILE__) + '/test_helper.rb'

class ScheduleCheckTest < Test::Unit::TestCase
  include Cronjobs
  def setup
    @now = Time.local(2011, 12, 22, 16, 05, 22)
  end

  def test_schedulable_moment_before
    sc = ScheduleCheck.new('7,11', '15-30', '1')
    assert_equal Time.local(2011, 11, 28, 0, 0, 0), sc.schedulable_moment_before(@now)
    sc = ScheduleCheck.new('7,12', '*', '1')
    assert_equal Time.local(2011, 12, 19, 0, 0, 0), sc.schedulable_moment_before(@now)
  end

  def test_parse_single
    assert_equal [7], parse('7', 1, 12)
  end

  def test_parse_range
    assert_equal [7,8,9,10,11], parse('7-11', 1, 12)
  end

  def test_parse_multi
    assert_equal [7,11], parse('7,11', 1, 12)
  end
end
