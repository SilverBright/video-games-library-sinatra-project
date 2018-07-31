class Game < ActiveRecord::Base
	validates_presence_of :titles, :platform
	belongs_to :user
end