module Cronjobs
  class Execution < ActiveRecord::Base
    attr_accessible :triggered_at
    set_table_name 'cronjob_executions'
    belongs_to :schedule, :class_name => 'Cronjobs::Schedule', :foreign_key => :cronjob_schedule_id
    validates_inclusion_of :outcome, :in => ['success', 'interrupted', 'failed'], :allow_nil => true

    def self.running
      where('launched_at is not null and finished_at is null')
    end

    def self.pending
      where('triggered_at is not null and launched_at is null')
    end

    def execute!
      self.launched_at = Time.now
      self.save!
      begin
        schedule.cronjob.execute
      rescue 
        self.error_message = $!
        self.error_trace = $@.join("\n")
        self.outcome = 'failed'
      else
        self.outcome = 'success'
      ensure
        self.finished_at = Time.now
        self.save!
      end
    end

    def to_s
      "Execution triggered #{triggered_at} launched at #{launched_at} finished at #{finished_at} with outcome #{outcome} for #{schedule}"
    end
  end
end

