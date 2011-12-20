%w(
  cronjobs_tasks
).each do |task|
  load "tasks/#{task}.rake"
end
