module Cronjobs
  class Schedule < ActiveRecord::Base
    set_table_name 'cronjob_schedules'
    belongs_to :cronjob, :polymorphic => true
    has_many :executions, :class_name => 'Cronjobs::Execution', :foreign_key => :cronjob_schedule_id

    def self.find_to_run time
      Schedule.all.select do |s|
        !!s.has_to_run?(time)
      end
    end

    def status
      executions.running.count > 0
    end

    def schedule!(time)
      executions.create!(:triggered_at => time)
      self.last_scheduled_at = time
      self.save!
    end

    def has_to_run? time
      if last_scheduled_at.nil? or last_scheduled_at < last_schedulable_moment(time)
        true #self.executions.pending.empty? && self.executions.running.empty?
      else
        false
      end
    end

    def last_schedulable_moment time
      sc = ScheduleCheck.new months_of_year, days_of_month, days_of_week
      sc.schedulable_moment_before time
    end

    def to_s
      "#{cronjob.to_s}@(#{days_of_month||'*'} #{days_of_week||'*'} #{months_of_year||'*'})"
    end
  end
end 
