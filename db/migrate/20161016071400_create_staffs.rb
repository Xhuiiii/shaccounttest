class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :room_number
      t.time :time_in
      t.time :time_out
      t.text :name
      t.text :remark

      t.timestamps null: false
    end
  end
end
