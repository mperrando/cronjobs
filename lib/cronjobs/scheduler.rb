module Cronjobs
  class Scheduler
    def schedule time
      schedules = Cronjobs::Schedule.find_to_run(time).select do |schedule|
        schedule.has_to_run? time
      end
      schedules.each do |schedule|
          schedule.schedule! time
      end
      schedules
    end
  end
end
