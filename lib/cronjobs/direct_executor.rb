module Cronjobs
  class DirectExecutor
    def execute
      executions = Cronjobs::Execution.pending
      executions.each do |exec|
        exec.execute!
      end
      executions
    end
  end
end
