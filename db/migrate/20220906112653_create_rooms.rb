class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :room_number, null: false
      t.string :full_name, null: false
      t.string :room_mate1
      t.string :room_mate2
      t.string :room_mate3

      t.timestamps
    end
  end
end
