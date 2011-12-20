class CreateCustomWorkers < ActiveRecord::Migration
  def change
    create_table :custom_workers do |t|

      t.timestamps
    end
  end
end
