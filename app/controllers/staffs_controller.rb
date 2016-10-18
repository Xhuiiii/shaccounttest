class StaffsController < ApplicationController
  # def new
  #   @yesterdays_accounts = Account.where(:account_date => Time.now.yesterday)
  #   @todays_accounts = Account.where(:account_date => Time.now)
  #   @total_accounts = []
  #   @total_accounts = @yesterdays_accounts + @todays_accounts
  #   @total_room_numbers = []
  #   @total_accounts.each do |account|
  #     @total_room_numbers << account.room_no
  #   end
  #   @yesterdays_housekeeping = Staff.where("DATE(created_at) = ?", Date.today - 1)
  #   @todays_housekeeping = Staff.where("DATE(created_at) = ?", Date.today)
  #   @total_housekeeping = []
  #   @total_housekeeping = @yesterdays_housekeeping + @todays_housekeeping
  #   @total_housekeeping.each do |cleaned|
  #     @total_room_numbers.each_with_index do |room, index|
  #       if (room == cleaned.room_number)
  #         @total_room_numbers.delete_at(index)
  #         break
  #       end
  #     end
  #   end
  #   @total_room_numbers.sort!
  #   @staff = Staff.new
  # end

  # def create
  # 	@staff = Staff.new(staff_params)

  #   if @staff.save
  #     redirect_to staffs_path(date: Date.today), notice: "Saved successfully."
  #   else
  #     render :new
  #   end
  # end

  def index
    @date_chosen = params[:date]
    @date_chosen_format = params[:date].to_date.strftime('%d %b %Y')
    @staffs = Staff.where("DATE(created_at) = ?", @date_chosen)
    @staffs = @staffs.order(room_number: :asc)
    @first = @staffs[0]
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
