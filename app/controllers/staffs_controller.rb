class StaffsController < ApplicationController
  def index
    @date_chosen = params[:date]
    @yesterday = params[:date].to_date - 1.day
    @date_chosen_format = params[:date].to_date.strftime('%d %b %Y')
    @yesterday_format = @yesterday.strftime('%d %b %Y')
    @yes_staffs = Staff.where("DATE(created_at) = ?", @yesterday)
    @yes_staffs = @yes_staffs.sort_by {|yes| yes.room_number}
    @to_staffs = Staff.where("DATE(created_at) = ?", @date_chosen)
    @to_staffs = @to_staffs.sort_by {|tos| tos.room_number}
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])
    if @staff.update(staff_params)
      redirect_to staffs_path(date: Date.today), notice: "Housekeeping was successfully updated."
    else
      render :edit
    end
  end

  private
  def staff_params
  	params.require(:staff).permit(:room_number, :time_in, :time_out, :name, :remark)
  end

end
