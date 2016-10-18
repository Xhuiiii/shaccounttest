class AddOldRoomToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :old_room, :integer
  end
end
