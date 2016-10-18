class StaffsearchesController < ApplicationController
	def new
		@staffsearcher = Staffsearch.new
	end

	def create
		@staffsearcher = Staffsearch.new(staffsearch_params)

		if @staffsearcher.save
			redirect_to staffs_path(date: @staffsearcher.date)
		else
			render :new
		end
	end

	private 
	def staffsearch_params
		params.require(:staffsearch).permit(:date)
	end
end
