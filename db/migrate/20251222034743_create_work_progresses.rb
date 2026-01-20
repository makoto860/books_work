class CreateWorkProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :work_progresses do |t|
      t.string :status
      t.integer :floor
      t.text :comment
      t.datetime :start_time
      t.datetime :end_time
      t.string :manager
      t.integer :book_specification_id

      t.timestamps
    end
  end
end
