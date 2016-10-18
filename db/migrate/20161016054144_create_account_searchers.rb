class CreateAccountSearchers < ActiveRecord::Migration
  def change
    create_table :account_searchers do |t|
      t.integer :account_id
      t.integer :seatcher_id

      t.timestamps null: false
    end
  end
end
