class Game < ActiveRecord::Base
	validates_presence_of :title, :platform, error: "cannot be blank"
	belongs_to :user
end