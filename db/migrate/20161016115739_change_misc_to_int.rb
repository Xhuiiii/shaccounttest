class ChangeMiscToInt < ActiveRecord::Migration
  def change
  	change_column :accounts, :miscellaneous, :integer
  end
end
