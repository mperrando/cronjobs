require File.dirname(__FILE__) + '/test_helper.rb'

class ActsAsCronjobTest < Test::Unit::TestCase
  def test_a_worker_schedule_accessor_name_should_be_schdules
    assert_equal "schedules", Worker.schedules_accessor_name
  end

  def test_a_customw_orker_schedule_accessor_name_should_be_schdules
    assert_equal "programs", CustomWorker.schedules_accessor_name
  end

  def test_add_schedule_for_worker
    assert_not_nil Cronjobs::Schedule.new(:cronjob => Worker.new).cronjob
  end

  def test_add_schedule_for_custom_worker
    assert_not_nil Cronjobs::Schedule.new(:cronjob => CustomWorker.new).cronjob
  end

  def test_schedule_appears_in_worker_schedules
    w = Worker.new
    w.schedules.build
    assert_equal 1, w.schedules.size
  end

  def test_schedule_appears_in_custom_worker_programs
    w = CustomWorker.new
    w.programs.build
    assert_equal 1, w.programs.size
  end
end
