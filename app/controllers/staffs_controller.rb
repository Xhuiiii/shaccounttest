class StaffsController < ApplicationController
  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    @staff.housekeeping_date = Date.today
    if @staff.save
      redirect_to staffs_path(date: Date.today), notice: "Housekeeping was successfully created."
    else
      render :new
    end
  end

  def index
    @date_chosen = params[:date]
    @yesterday = params[:date].to_date - 1.day
    @date_chosen_format = params[:date].to_date.strftime('%d %b %Y')
    @yesterday_format = @yesterday.strftime('%d %b %Y')
    @yes_staffs = Staff.where(:housekeeping_date => @yesterday)
    @yes_staffs = @yes_staffs.sort_by {|yes| yes.room_number}
    @to_staffs = Staff.where(:housekeeping_date => @date_chosen)
    @to_staffs = @to_staffs.sort_by {|tos| tos.room_number}
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])
    @account = Account.find_by(:room_no => @staff.room_number, :account_date => @staff.housekeeping_date)
    if @staff.update(staff_params)
      if @account
        @account.update(:remark => staff_params[:remark])
      end
      redirect_to staffs_path(date: Date.today), notice: "Housekeeping was successfully updated."
    else
      render :edit
    end
  end

  private
  def staff_params
  	params.require(:staff).permit(:housekeeping_date, :room_number, :time_in, :time_out, :name, :remark)
  end

end
