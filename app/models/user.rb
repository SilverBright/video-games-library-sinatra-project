class User < ActiveRecord::Base
	has_many :games #a user has many games
	validates :username, presence: true, uniqueness: true #validate the presence of a user and cannot be duplicated
	has_secure_password #this is a macro that works in conjunction with bcrypt
end
