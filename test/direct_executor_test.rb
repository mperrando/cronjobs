require File.dirname(__FILE__) + '/test_helper.rb'


class DirectExecutorTest < Test::Unit::TestCase
  def setup
    @executor = Cronjobs::DirectExecutor.new
  end

  def test_calss_execute_on_cronjob_of_not_launched_executions
    run = Object.new
    run.expects(:execute!).once
    Cronjobs::Execution.stubs(:pending).returns([run])
    @executor.execute
  end
end
