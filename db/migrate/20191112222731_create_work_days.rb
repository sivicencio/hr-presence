class CreateWorkDays < ActiveRecord::Migration[5.2]
  def change
    create_table :work_days do |t|
      t.date :day
      t.datetime :arrived_at
      t.datetime :left_at
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :work_days, :day
  end
end
