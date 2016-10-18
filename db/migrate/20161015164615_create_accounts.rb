class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :invoice_no
      t.integer :room_no
      t.integer :price
      t.integer :extension
      t.integer :deposit
      t.text :miscellaneous
      t.text :remark
      t.date :date

      t.timestamps null: false
    end
  end
end
