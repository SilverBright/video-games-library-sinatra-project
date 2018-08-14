# Models: The 'logic' of a web application. This is where data is manipulated and/or saved.

class Game < ActiveRecord::Base
	validates_presence_of :title, :platform #requires both title and platform fields not to be blank
	belongs_to :user  # A game belongs to a user
end