class Staff < ActiveRecord::Base
	validates_presence_of :room_number
	validate :validate_time, :on => :update

	def validate_time
		if self.time_in_was
	      #make sure the new time in is after the old
	      if self.time_in
	        if self.time_in.strftime( "%H%M%S%N" ) < self.time_in_was.strftime( "%H%M%S%N" )
	        	errors.add(:staff, 'Time in has to be after the previous time.')
	        end
	      end
	      if self.time_out
	        if self.time_out < self.time_in
	        	errors.add(:staff, 'Time out has to be after time in.')
	        end
	      end
	    else
	      #Make sure new time_in is after time.now
	      if self.time_in
	        if self.time_in.strftime( "%H%M%S%N" ) < Time.now.beginning_of_minute.strftime( "%H%M%S%N" )
	        	errors.add(:staff, 'Time in has to be after the current time.')
	        end
	        if self.time_out
	          if self.time_out < self.time_in
	          	errors.add(:staff, 'Time out has to be after time in.')
	          end
	        end
	      else
	        if self.time_out
	        	errors.add(:staff, 'There must be a time in.')
	        end
	      end
	    end
	end
end
