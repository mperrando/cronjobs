namespace :cronjobs do
  desc "Find schedules to run and launch them"
  task :run => :environment do
    schedules = Cronjobs::Scheduler.new.schedule(Time.now)
    puts "Scheduled: DOM DOW MOY"
    puts schedules.map(&:to_s).join "\n"
    executions = Cronjobs::DirectExecutor.new.execute
    puts "Executed:"
    puts executions.map(&:to_s).join "\n"
  end
end
