class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :full_name, null: false
      t.string :emp_id, null: false, unique: true
      t.string :gender, null: false
      t.boolean :allocated, default: false

      t.timestamps
    end
  end
end
