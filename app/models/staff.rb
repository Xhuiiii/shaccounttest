class Staff < ActiveRecord::Base
	validates_presence_of :room_number
	validates_presence_of :name
	validates_presence_of :time_in
end
