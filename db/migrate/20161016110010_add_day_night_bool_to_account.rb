class AddDayNightBoolToAccount < ActiveRecord::Migration
  def change
  	add_column :accounts, :day, :boolean
  	add_column :accounts, :night, :boolean
  	add_column :accounts, :account_date, :date
  end
end
