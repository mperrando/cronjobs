class CreateCronjobExecutions < ActiveRecord::Migration
  def change
    create_table :cronjob_executions do |t|
      t.references :cronjob_schedule
      t.timestamp :triggered_at
      t.timestamp :launched_at
      t.timestamp :finished_at
      t.string :outcome
      t.string :error_message
      t.text :error_trace
    end
  end
end
