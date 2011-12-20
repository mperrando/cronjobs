class CreateCronjobSchedules < ActiveRecord::Migration
  def change
    create_table :cronjob_schedules do |t|
      t.string :days_of_month
      t.string :months_of_year
      t.string :days_of_week
      t.timestamp :last_scheduled_at, :null => true
      t.integer :cronjob_id
      t.string :cronjob_type
      t.timestamps
    end
  end
end
