# db/migrate/20251119000000_create_solid_queue_tables.rb
class CreateSolidQueueTables < ActiveRecord::Migration[7.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.text :job_data, null: false
      t.datetime :scheduled_at, null: false, index: true
      t.timestamps
    end
    add_index :solid_queue_jobs, :queue_name

    create_table :solid_queue_failed_executions do |t|
      t.text :job_data, null: false
      t.text :error_message
      t.timestamps
    end

    create_table :solid_queue_processes do |t|
      t.string :hostname, null: false
      t.timestamps
    end
  end
end

