class AccountSearcher < ActiveRecord::Base
	belongs_to :account 
	belongs_to :searcher
end
