class AddDateToStaff < ActiveRecord::Migration
  def change
  	add_column :staffs, :housekeeping_date, :date
  end
end
