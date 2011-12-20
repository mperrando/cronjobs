class CronjobsMonthsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Cronjobs::ScheduleCheck.parse value, 1, 12
  rescue Exception => e
    record.errors[attribute] << "bad scehdule: #{value}"
  end
end
