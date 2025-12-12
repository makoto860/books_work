class CreateBookSpecifications < ActiveRecord::Migration[8.0]
  def change
    create_table :book_specifications do |t|
      t.string :title
      t.integer :number_of_copies
      t.integer :number_of_machines
      t.text :note
      t.datetime :deadline
      t.string :author

      t.timestamps
    end
  end
end
