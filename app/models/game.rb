class Game < ActiveRecord::Base
	validates_presence_of :title, :platform #requires both title and platform fields not to be black
	belongs_to :user  # A game belongs to a user
end