require File.dirname(__FILE__) + '/test_helper.rb'

FactoryGirl.define do
  factory 'schedule', :class => Cronjobs::Schedule do
    days_of_month = '*'
    months_of_year = '*'
    days_of_week = '*'
  end
  factory 'execution', :class => Cronjobs::Execution do
    schedule
  end
end

class ScheduleTest < Test::Unit::TestCase

  include Cronjobs
  def setup
    @now = Time.local(2001, 12, 22, 16, 05, 22)
    @schedule = FactoryGirl.create('schedule')
  end

  def test_execute_creates_new_execution
    @schedule.schedule! @now
    assert_equal 1, @schedule.executions.count
    assert_equal @now.to_i, @schedule.executions.first.triggered_at.to_i
  end

  def test_find_to_run
    sch1 = @schedule
    sch2 = FactoryGirl.create('schedule')
    sch1.expects(:has_to_run?).with(@now).returns(true)
    sch2.expects(:has_to_run?).with(@now).returns(false)
    Schedule.stubs(:all).returns([sch1, sch2])
    assert_equal [sch1], Schedule.find_to_run(@now)
  end

  def test_has_to_run?
    @schedule.last_scheduled_at = @now - 3.days
    @schedule.expects(:last_schedulable_moment).with(@now).returns @now - 3.days + 1.second
    assert @schedule.has_to_run? @now
  end

  def test_last_schedulable_moment
    @schedule.stubs(:months_of_year).returns('moy')
    @schedule.stubs(:days_of_month).returns('dom')
    @schedule.stubs(:days_of_week).returns('dow')

    sc = Object.new
    ScheduleCheck.stubs(:new).with('moy', 'dom', 'dow').returns(sc)
    target = Object.new
    sc.stubs(:schedulable_moment_before).with(@now).returns(target)

    assert_equal target, @schedule.last_schedulable_moment(@now)
  end
end
