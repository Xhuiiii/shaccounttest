class Account < ActiveRecord::Base
	has_one :account_searcher

	validates_presence_of :room_no
	validates_presence_of :price
	validates_presence_of :deposit
	if !:day
		validates_presence_of :night
	end
	if !:night
		validates_presence_of :day
	end
		
	validate :check_rm_cleaned, :on => [:create, :update]

    private 

    def check_rm_cleaned
    	@yesterdays_accounts = Account.where(:account_date => Time.now.yesterday)
	    @todays_accounts = Account.where(:account_date => Time.now)
	    @total_accounts = []
	    @total_accounts = @yesterdays_accounts + @todays_accounts
	    @total_room_numbers = []
	    @total_accounts.each do |account|
	      @total_room_numbers << account.room_no
	    end
	    @yesterdays_housekeeping = Staff.where("DATE(created_at) = ?", Date.today - 1).where.not(:time_out => nil)
	    @todays_housekeeping = Staff.where("DATE(created_at) = ?", Date.today).where.not(:time_out => nil)
	    @total_housekeeping = []
	    @total_housekeeping = @yesterdays_housekeeping + @todays_housekeeping
	    @total_housekeeping.each do |cleaned|
	      @total_room_numbers.each_with_index do |room, index|
	        if (room == cleaned.room_number)
	          @total_room_numbers.delete_at(index)
	          break
	        end
	      end
	    end

    	@total_room_numbers.each do |uncleaned_rms|
	      	if self.room_no == uncleaned_rms 
	      		if self.old_room
		      		if self.room_no != self.old_room
			        	errors.add(:account, 'Room not cleaned.')
			       		break
			       	end
			    else
			    	errors.add(:account, 'Room not cleaned.')
			       	break
			    end
	      	end
    	end
	end
end
