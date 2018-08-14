class Game < ActiveRecord::Base
	validates_presence_of :title, :platform
	belongs_to :user
end