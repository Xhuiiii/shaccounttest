class AddHrToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :hr_use, :integer
  	add_column :accounts, :hr_cc, :integer
  end
end
