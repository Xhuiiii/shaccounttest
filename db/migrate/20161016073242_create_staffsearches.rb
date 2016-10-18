class CreateStaffsearches < ActiveRecord::Migration
  def change
    create_table :staffsearches do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
