class SearchersController < ApplicationController
	def new
		@searcher = Searcher.new
	end

	def create
		@searcher = Searcher.new(searcher_params)

		if @searcher.save
			redirect_to accounts_path(search_from: @searcher.search_from, search_to: @searcher.search_to)
		else
			render :new
		end
	end

	private 
	def searcher_params
		params.require(:searcher).permit(:search_from, :search_to)
	end

end