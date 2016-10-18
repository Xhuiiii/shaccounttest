class AddCcToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :cc, :integer
  end
end
