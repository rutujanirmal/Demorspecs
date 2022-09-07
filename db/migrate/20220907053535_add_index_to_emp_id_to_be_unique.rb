class AddIndexToEmpIdToBeUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :employees, :emp_id, unique: true
  end
end
