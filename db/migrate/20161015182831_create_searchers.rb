class CreateSearchers < ActiveRecord::Migration
  def change
    create_table :searchers do |t|
      t.date :search_from
      t.date :search_to

      t.timestamps null: false
    end
  end
end
