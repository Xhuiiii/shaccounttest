class Staff < ActiveRecord::Base
	validates_presence_of :room_number
end
