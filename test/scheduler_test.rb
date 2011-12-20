require File.dirname(__FILE__) + '/test_helper.rb'

class SchedulerTest < Test::Unit::TestCase
  def setup
    @scheduler = Cronjobs::Scheduler.new
  end

  def test_schedules_schedules_to_run
    sch = Object.new
    time = Time.now
    Cronjobs::Schedule.stubs(:find_to_run).with(time).returns([sch])
    sch.expects(:schedule!)

    @scheduler.schedule time
  end
end
