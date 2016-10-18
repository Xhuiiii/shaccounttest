class AccountsController < ApplicationController
  def index
    @search_from = params[:search_from]
    @search_to = params[:search_to]
    @accounts = []

    @day_total_price = 0
    @day_total_deposit = 0
    @day_total_misc = 0
    @day_total_gst = 0
    @day_total_cc = 0
    @day_total = 0

    @night_total_price = 0
    @night_total_deposit = 0
    @night_total_misc = 0
    @night_total_gst = 0
    @night_total_cc = 0
    @night_total = 0

    @total_price = 0
    @total_deposit = 0
    @total_misc = 0
    @total_gst = 0
    @total_cc = 0
    @total = 0

    if params[:today_day]
      @day_accounts = Account.where(:day => true, :account_date => Date.today)
      @day_accounts = @day_accounts.sort_by {|acc| acc.invoice_no}
      @day_accounts.each do |account|
        @day_total_price += account.price
        @day_total_gst += ((account.price * 0.06)/1.06)
        @day_total_deposit += account.deposit
        @day_total_misc += account.miscellaneous || 0
        @day_total_cc += account.cc || 0
      end
      @day_total = @day_total_price + @day_total_misc
      render :day
    end

    if params[:today_night]
      day_start = Time.parse "08:00 am"
      night_start = Time.parse "08:00 pm"
      midnight = Time.now.beginning_of_day
      end_of_the_day = Time.now.end_of_day
      #if next day already
      if midnight < Time.now && Time.now < day_start 
        @night_accounts = Account.where(:night => true, :account_date => Time.now.yesterday)         
      else
        @night_accounts = Account.where(:night => true, :account_date => Date.today)
      end
      @night_accounts = @night_accounts.sort_by {|acc| acc.invoice_no}
      @night_accounts.each do |account|
        @night_total_price += account.price
        @night_total_gst += ((account.price * 0.06)/1.06)
        @night_total_deposit += account.deposit
        @night_total_misc += account.miscellaneous || 0
        @night_total_cc += account.cc || 0
      end
      @night_total = @night_total_price + @night_total_misc
      render :night
    end

  	if(@search_from && @search_to)
  		@accounts = Account.where(:account_date => @search_from.to_time..@search_to.to_time)
      @day_accounts = @accounts.where(:day => true)
      @day_accounts = @day_accounts.sort_by {|acc| acc.invoice_no}
      @night_accounts = @accounts.where(:night => true)
      @night_accounts = @night_accounts.sort_by {|acc| acc.invoice_no}
  		@accounts.each do |account|
        if account.day
          @day_total_price += account.price
          @day_total_gst += ((account.price * 0.06)/1.06)
          @day_total_deposit += account.deposit
          @day_total_misc += account.miscellaneous || 0
          @day_total_cc += account.cc || 0
        elsif account.night
          @night_total_price += account.price
          @night_total_gst += ((account.price * 0.06)/1.06)
          @night_total_deposit += account.deposit
          @night_total_misc += account.miscellaneous || 0
          @night_total_cc += account.cc || 0
        end
  			@total_price += account.price
        @total_gst += ((account.price * 0.06)/1.06)
  			@total_deposit += account.deposit
        @total_misc += account.miscellaneous || 0
        @total_cc += account.cc || 0
  		end
      @day_total = @day_total_price + @day_total_misc
      @night_total = @night_total_price + @night_total_misc
      @total = @total_price + @total_misc
  	end
  end

  def show
  	@account = Account.find(params[:id])
  end

  def new
  	@account = Account.new
    @housekeeping = Staff.new
  end

  def create 
  	@account = Account.new(account_params)
    @housekeeping = Staff.new
    @housekeeping.room_number = @account.room_no

    day_start = Time.parse "08:00 am"
    night_start = Time.parse "08:00 pm"
    midnight = Time.now.beginning_of_day
    end_of_the_day = Time.now.end_of_day
    beginning_of_month = Time.now.beginning_of_month
    now = Time.now

    #if night shift
    if midnight < Time.now && Time.now < day_start 
      @account.account_date = Time.now.yesterday
      @account.night = true
    elsif night_start < Time.now && Time.now < end_of_the_day
      @account.account_date = Date.today
      @account.night = true
    else
      @account.account_date = Date.today
      @account.day = true
    end

    current_accounts = []
    current_accounts = Account.where(:account_date => beginning_of_month..now)
    if current_accounts.length > 0
      @account.invoice_no = Account.last.invoice_no + 1
    else
      @account.invoice_no = 1
    end

    if @account.save
      @housekeeping.save!
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def edit
  	@account = Account.find(params[:id])
  end

  def update 
    @account = Account.find(params[:id])
  	if @account.update(account_params)
  		redirect_to @account, notice: "Account was successfully updated."
  	else
  		render :edit
  	end
  end

  private 
  def account_params
  	params.require(:account).permit(:cc, :day, :night, :account_date, :search_from, :search_to, :invoice_no, :room_no, :price, :extension, :deposit, :miscellaneous, :remark, :date)
  end
end
