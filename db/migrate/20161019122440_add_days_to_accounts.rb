class AddDaysToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :days, :integer
  end
end
